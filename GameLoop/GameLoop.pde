//Kim taeyu

Survival survival;

void setup(){
  size(1200, 900);
  //fullScreen();
  survival = new Survival();
}

void draw(){
  background(255);
  survival.update();
}
