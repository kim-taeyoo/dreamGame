PImage roomImg;
PImage bedImg;

JSONObject weatherJson;

DrawWeather drawWeather;

int weatherId = 0;

class Room {
  boolean loadingDone = false;
  Room() {
  }

  void drawPage() {

    if (!loadingDone) {
      text("Loading...", width/2, height/3);
      return;
    }

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
}
