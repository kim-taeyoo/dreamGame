PImage roomImg;
PImage bedImg;

String API_KEY = "6a35dd16db35356a80220fcd0c2a91f5";
String url = "https://api.openweathermap.org/data/2.5/weather?q=Suwon&appid="+API_KEY;

DrawWeather drawWeather;

int weatherId = 0;

void setup() {
  fullScreen();
  roomImg = loadImage("room.png");
  bedImg = loadImage("noPlBed.png");
  
  JSONObject json = loadJSONObject(url);
  
  background(100);
  
  println(json);
  
  drawWeather = new DrawWeather(json.getJSONArray("weather").getJSONObject(0).getInt("id"));
  weatherId = drawWeather.getId();
}

void draw() {

  background(100);

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
