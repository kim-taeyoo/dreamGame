//Kim taeyu
class GameLoop {
  Survival survival;
  
  GameLoop(MusicSelect musicSelect) {
    survival = new Survival(musicSelect);
  }

  void update() {
    noStroke();
    rectMode(CORNER);
    background(255);
    survival.update();
  }
}
