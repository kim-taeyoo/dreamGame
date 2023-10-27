PImage roomImg;
PImage bedImg;

String API_KEY = "6a35dd16db35356a80220fcd0c2a91f5";
String url = "https://api.openweathermap.org/data/2.5/weather?q=Suwon&appid="+API_KEY;

JSONObject weatherJson;

DrawWeather drawWeather;

int weatherId = 0;

class Room {
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

    case 3: //clear
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
    image(bedImg, width/2-3, height/2-150);
  }
  
  void pressRadioPlayer() {
   if (mouseX >= (width*2/3)-140 && mouseX <= (width*2/3)-70 &&
      mouseY >= (height/3)-40 && mouseY <= (height/3)+25) {
      page = 2;
    } 
  }
}
