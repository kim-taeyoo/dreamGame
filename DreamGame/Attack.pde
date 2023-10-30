//Kim Taeyu
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
  //할퀴기 범위 관련
  float radius;
  float scratchX;
  float scratchY;
  boolean setAngle = false;
  float angle;

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

    radius = 120;
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
    }

    if (animationState) {
      //각도 설정
      if(setAngle == false){
      angle = atan2(directionY, directionX);
      setAngle = true;
      }
      //할퀴기 이미지
      //플레이어이미지 우측일때
      pushMatrix();
      translate(positionX, positionY);
      rotate(angle);
      image(scratch[moveIdx], 60, 0);
      //할퀴기 범위
      fill(0, 255, 0, 0);
      ellipse(55, 0, radius, radius);
      //println("내부범위: " + (cos(a)*30 - sin(a)) + ", " + (sin(a)*30 + cos(a)));
      //공격범위 설정
      scratchX = positionX + cos(angle)*55 - sin(angle);
      scratchY = positionY + sin(angle)*55 + cos(angle);
      popMatrix();
       //println("외부범위: " + scratchX + ", " + scratchY);
    }
  }
}
