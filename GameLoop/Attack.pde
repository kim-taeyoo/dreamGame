class Attack {
  float positionX;
  float positionY;
  float velocityX;
  float velocityY;
  float directionX;
  float directionY;
  float radius;

  //할퀴기 이미지
  PImage[] scratch;
  boolean animationState = false;
  int imageNumber;
  int updateBeforeNextMove;
  int moveIdx = 0;

  //할퀴기 관련
  boolean scratchTime = true;
  int scratchDelay = 60;

  Attack(Player player, int mousePosX, int mousePosY) {
    positionX = player.positionX;
    positionY = player.positionY;

    float distanceToMousePosX = mousePosX - positionX;
    float distanceToMousePosY = mousePosY - positionY;
    float distanceToMousePos = dist(mousePosX, mousePosY, positionX, positionY);

    directionX = distanceToMousePosX/distanceToMousePos;
    directionY = distanceToMousePosY/distanceToMousePos;
    radius = 100;
    imageNumber = 8;
    updateBeforeNextMove = 3;
    // 할퀴기 이미지 저장
    scratch = new PImage[imageNumber];
    for (int i = 0; i < imageNumber; i++) {
      scratch[i] = loadImage("scratch_" + i + ".png");
    }
  }
  void update() {
    if (animationState) {
      velocityX = directionX*5;
      velocityY = directionY*5;

      //할퀴기 애니메이션
      //애니메이션 관련
      updateBeforeNextMove--;
      if (updateBeforeNextMove == 0) {
        updateBeforeNextMove = 3;
        if (moveIdx < imageNumber - 1)
          moveIdx++;
        else {
          moveIdx = 0;
          animationState = false;
        }
      }

      pushMatrix();
      translate(positionX+velocityX*7, positionY+velocityY*7);
      float a = atan2(directionY, directionX);
      rotate(a - radians(15));
      image(scratch[moveIdx], 0, 0);
      popMatrix();
    }
  }
}
