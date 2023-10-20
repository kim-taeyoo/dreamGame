PImage roomImg;
PImage bedImg;


void setup() {
  fullScreen();
  roomImg = loadImage("room.png");
  bedImg = loadImage("noPlBed.png");
  background(100);
}

void draw() {

  background(100);
  
  //weather
  rectMode(CENTER);
  fill(50,50,105);
  rect(width/2 + 250, height/2 - 320,200,150);
  
  //room
  imageMode(CENTER);
  image(roomImg, width/2, height/2);
  image(bedImg, width/2-3, height/2-150);
}
