class Spell {
  float positionX;
  float positionY;
  float velocityX;
  float velocityY;
  float directionX;
  float directionY;
  float speed = 7;
  float radius = 30;

  Spell(Player player, int mousePosX, int mousePosY) {
    positionX = player.positionX;
    positionY = player.positionY;
    
    float distanceToMousePosX = mousePosX - positionX;
    float distanceToMousePosY = mousePosY - positionY;
    float distanceToMousePos = dist(mousePosX, mousePosY, positionX, positionY);

    directionX = distanceToMousePosX/distanceToMousePos;
    directionY = distanceToMousePosY/distanceToMousePos;
  }

  void update() {

    velocityX = directionX*speed;
    velocityY = directionY*speed;

    positionX += velocityX;
    positionY += velocityY;
  }
}
