PImage roomImg;
PImage WakeupImg;
PImage SleepImg;

String API_KEY = "6a35dd16db35356a80220fcd0c2a91f5";
String url = "https://api.openweathermap.org/data/2.5/weather?q=Suwon&appid="+API_KEY;

JSONObject weatherJson;

DrawWeather drawWeather;

int weatherId = 0;

boolean isMusicSelected = false;  //start count down when music selected
boolean readyToStart = false;  //start fade out when count down over
float readyTime = 0;

class Room {
  float alpha = 0;  //for fade out when sleep

  Room() {
  }

  void update() {

    background(100);

    //weather
    rectMode(CENTER);
    fill(110, 110, 205);
    noStroke();
    rect(width/2 + 250, height/2 - 320, 200, 150);
    switch(weatherId) {

    case 0:
      break;

    case 1:  //rain
      drawWeather.drawWindow(weatherJson.getJSONObject("rain").getInt("1h"));
      break;

    case 2: //snow
      drawWeather.drawWindow(weatherJson.getJSONObject("snow").getInt("1h"));
      break;

    case 3: //clear sky
      drawWeather.drawWindow(0);
      break;

    case 4: //cloud
      drawWeather.drawWindow(weatherJson.getJSONObject("clouds").getInt("all"));
      break;

    default:
      break;
    }


    //room
    imageMode(CENTER);
    image(roomImg, width/2, height/2);
    if (readyToStart) {
      image(SleepImg, width/2-3, height/2-150);
    } else {
      image(WakeupImg, width/2-3, height/2-150);
    }

    // start fade out
    if (readyToStart) {
      fill(0, alpha);
      rect(width/2, height/2, width, height);
      alpha+=2;

      if (alpha == 350) {
        page = 3;
      }
    }

    //start count down
    if (isMusicSelected) {
      if (millis() - readyTime > 1500) {
        readyToStart = true;
        isMusicSelected = false;
      }
    }

    changeCursorWhenBtn();
  }

  //when player is pressed
  void pressRadioPlayer() {
    if (readyToStart||isMusicSelected) {
      return;
    }
    if (HitRadioPlayer()) {
      cursor(ARROW);
      page = 2;
    }
  }

  //check player is pressed
  boolean HitRadioPlayer() {
    if (mouseX >= (width*2/3)-140 && mouseX <= (width*2/3)-70 &&
      mouseY >= (height/3)-40 && mouseY <= (height/3)+25) {
      return true;
    } else {
      return false;
    }
  }

  void changeCursorWhenBtn() {
    if (HitRadioPlayer()) {
      cursor(HAND);
    } else {
      cursor(ARROW);
    }
  }
}
