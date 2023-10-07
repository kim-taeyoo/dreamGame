//Kim taeyu

enum MoveState {
  NOT_MOVING,
    STARTED_MOVING,
    IS_MOVING
}

class Player {

  float SPEED_PIXEL_PER_SECOND = 200;
  float SPEED = SPEED_PIXEL_PER_SECOND / frameRate;
  float positionX = width/2+30;
  float positionY = height/2;
  boolean seeRight = true;

  boolean wKeyPressed = false;
  boolean aKeyPressed = false;
  boolean sKeyPressed = false;
  boolean dKeyPressed = false;

  //이미지 처리
  PImage[] rImages;
  int imageNumber = 4;
  MoveState moveState = MoveState.NOT_MOVING;
  int updateBeforeNextMove = 10;
  int moveIdx = 1;

  Player() {
    rImages = new PImage[imageNumber];
    // 이미지 저장(우측방향)
    for (int i = 0; i < imageNumber; i++) {
      rImages[i] = loadImage("player_run_" + i + ".png");
    }
  }

  void update() {
    //플레이어 이미지
    //플레이어 애니메이션 구현을 위해 움직임 상태 파악
    switch (moveState) {
    case NOT_MOVING:
      if (wKeyPressed || aKeyPressed || sKeyPressed || dKeyPressed)
        moveState = MoveState.STARTED_MOVING;
      break;
    case STARTED_MOVING:
      if (wKeyPressed || aKeyPressed || sKeyPressed || dKeyPressed)
        moveState = MoveState.IS_MOVING;
      break;
    case IS_MOVING:
      if (!wKeyPressed && !aKeyPressed && !sKeyPressed && !dKeyPressed)
        moveState = MoveState.NOT_MOVING;
      break;
    default:
      break;
    }
    // 움직임 애니메이션 구현
    imageMode(CENTER);
    switch (moveState) {
    case NOT_MOVING:
      if (seeRight) {
        image(rImages[0], positionX, positionY-30);
      } else {
        pushMatrix();
        scale(-1, 1);
        image(rImages[0], -positionX, positionY-30);
        popMatrix();
      }
      break;
    case STARTED_MOVING:
      moveIdx = 1;
      updateBeforeNextMove = 5;
      if (seeRight) {
        image(rImages[moveIdx], positionX, positionY-30);
      } else {
        pushMatrix();
        scale(-1, 1);
        image(rImages[moveIdx], -positionX, positionY-30);
        popMatrix();
      }

      break;
    case IS_MOVING:
      updateBeforeNextMove--;
      if (updateBeforeNextMove == 0) {
        updateBeforeNextMove = 5;
        if (moveIdx == 1)
          moveIdx++;
        else if (moveIdx == 2)
          moveIdx++;
        else
          moveIdx = 1;
      }
      if (seeRight) {
        image(rImages[moveIdx], positionX, positionY-30);
      } else {
        pushMatrix();
        scale(-1, 1);
        image(rImages[moveIdx], -positionX, positionY-30);
        popMatrix();
      }

      break;
    default:
      break;
    }

    //플레이어 이동관련
    if (wKeyPressed) {
      if (aKeyPressed || dKeyPressed) {
        positionY -= SPEED*sin(PI/4);
      } else {
        positionY -= SPEED;
      }
    }
    if (aKeyPressed) {
      if (wKeyPressed || sKeyPressed) {
        positionX -= SPEED*cos(PI/4);
      } else {
        positionX -= SPEED;
      }
      seeRight = false;
    }
    if (sKeyPressed) {
      if (aKeyPressed || dKeyPressed) {
        positionY += SPEED*sin(PI/4);
      } else {
        positionY += SPEED;
      }
    }
    if (dKeyPressed) {
      if (wKeyPressed || sKeyPressed) {
        positionX += SPEED*cos(PI/4);
      } else {
        positionX += SPEED;
      }
      seeRight = true;
    }
  }
}
