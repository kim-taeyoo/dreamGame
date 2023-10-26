class Spell {
  float positionX;
  float positionY;
  float velocityX;
  float velocityY;
  float directionX;
  float directionY;
  float speed = 7;
  float radius;

  // 0 은 화염구
  int attackType;

  //화염구 이미지
  PImage[] fireBall;
  int imageNumber;
  int updateBeforeNextMove;
  int moveIdx = 0;

  Spell(Player player, int mousePosX, int mousePosY, int attack) {
    attackType = attack;

    positionX = player.positionX;
    positionY = player.positionY;

    float distanceToMousePosX = mousePosX - positionX;
    float distanceToMousePosY = mousePosY - positionY;
    float distanceToMousePos = dist(mousePosX, mousePosY, positionX, positionY);

    directionX = distanceToMousePosX/distanceToMousePos;
    directionY = distanceToMousePosY/distanceToMousePos;

    radius = 35;
    imageNumber = 5;
    updateBeforeNextMove = 5;
    // 화염구 이미지 저장
    fireBall = new PImage[imageNumber];
    for (int i = 0; i < imageNumber; i++) {
      fireBall[i] = loadImage("fireball_" + i + ".png");
    }
  }


  void update() {
    velocityX = directionX*speed;
    velocityY = directionY*speed;

    positionX += velocityX;
    positionY += velocityY;

    //화염구 애니메이션
    //애니메이션 관련
    updateBeforeNextMove--;
    if (updateBeforeNextMove == 0) {
      updateBeforeNextMove = 5;
      if (moveIdx < imageNumber - 1)
        moveIdx++;
      else
        moveIdx = 0;
    }

    pushMatrix();
    translate(positionX, positionY);
    float a = atan2(directionY, directionX);
    rotate(a);
    image(fireBall[moveIdx], 0, 0);
    popMatrix();
  }
}
