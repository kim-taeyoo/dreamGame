PImage roomImg;
PImage bedImg;

DrawWeather drawWeather;

int weatherId = 0;

boolean loadingDone = false;

class Room {

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
    drawWeather.drawWindow(100);

    //room
    imageMode(CENTER);
    image(roomImg, width/2, height/2);
    image(bedImg, width/2-3, height/2-150);
  }
}
