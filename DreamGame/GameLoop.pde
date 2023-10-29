//Kim taeyu
class GameLoop {
  Survival survival;
  
  GameLoop(MusicSelect musicSelect, Room room) {
    survival = new Survival(musicSelect, room);
  }

  void update() {
    noStroke();
    rectMode(CORNER);
    background(255);
    survival.update();
  }
}
