//Kim taeyu

Survival survival;

void setup(){
  size(1920, 1080);
  survival = new Survival();
}

void draw(){
  background(255);
  survival.update();
}
