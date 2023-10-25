String API_KEY = "6a35dd16db35356a80220fcd0c2a91f5";
String url = "https://api.openweathermap.org/data/2.5/weather?q=Suwon&appid="+API_KEY;

Room myRoom;

void setup() {
  fullScreen();
  background(100);

  myRoom = new Room();
  
  thread ("loadWeather");
}

void draw() {
  background(100);
  myRoom.drawPage();
}

void loadWeather() {
  JSONObject json = loadJSONObject(url);

  println(json);

  drawWeather = new DrawWeather(json.getJSONArray("weather").getJSONObject(0).getInt("id"));
  weatherId = drawWeather.getId();

  roomImg = loadImage("room.png");
  bedImg = loadImage("noPlBed.png");

  loadingDone = true;
}
