//Kim taeyu
class GameLoop {
  Survival survival;

  GameLoop() {
    survival = new Survival();
  }

  void update() {
    background(255);
    survival.update();
  }
}
