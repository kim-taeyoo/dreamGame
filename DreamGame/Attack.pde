class Attack {
  Player player;
  float positionX;
  float positionY;
  int mousePosX;
  int mousePosY;
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

  Attack(Player player) {
    this.player = player;
    
    radius = 110;
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
      positionX = player.positionX;
      positionY = player.positionY;
      
    float distanceToMousePosX = mousePosX - positionX;
    float distanceToMousePosY = mousePosY - positionY;
    float distanceToMousePos = dist(mousePosX, mousePosY, positionX, positionY);

    directionX = distanceToMousePosX/distanceToMousePos;
    directionY = distanceToMousePosY/distanceToMousePos;
    
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

      //할퀴기 이미지
      pushMatrix();
      translate(positionX, positionY);
      float a = atan2(directionY, directionX);
      rotate(a);
      image(scratch[moveIdx], 30, 0);
      //할퀴기 범위
      fill(0, 255, 0, 120);
      ellipse(30, 0, radius, radius);
      popMatrix();
    }
  }
}
