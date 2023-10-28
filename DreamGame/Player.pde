//Kim taeyu

enum MoveState {
  NOT_MOVING,
    STARTED_MOVING,
    IS_MOVING,
    IS_COLLISION
}

class Player {

  float SPEED_PIXEL_PER_SECOND = 200;
  float SPEED = SPEED_PIXEL_PER_SECOND / frameRate;
  float positionX = width/2+30;
  float positionY = height/2;
  boolean seeRight = true;
  float radius = 70;

  boolean wKeyPressed = false;
  boolean aKeyPressed = false;
  boolean sKeyPressed = false;
  boolean dKeyPressed = false;

  //이미지 처리
  PImage[] rImages;
  int imageNumber = 4;
  MoveState moveState = MoveState.NOT_MOVING;
  int updateBeforeNextMove = 5;
  int moveIdx = 0;

  //충돌처리
  boolean collision = false;
  int stopTime = 180;
  int alphaVal = 255;

  //스펠 관련
  boolean shotTime = true;
  int spellDelay = 60;
  float mp = 100;
  float plusMp = 0.1;

  //할퀴기 관련
  boolean scratchTime = true;
  int scratchDelay = 120;
  
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
    if (!collision) {
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
    } else {
      moveState = MoveState.IS_COLLISION;
    }
    // 움직임 애니메이션 구현
    imageMode(CENTER);
    switch (moveState) {
    case NOT_MOVING:
      if (seeRight) {
        image(rImages[0], positionX, positionY-27);
      } else {
        pushMatrix();
        scale(-1, 1);
        image(rImages[0], -positionX, positionY-27);
        popMatrix();
      }
      break;
    case STARTED_MOVING:
      moveIdx = 1;
      updateBeforeNextMove = 5;
      if (seeRight) {
        image(rImages[moveIdx], positionX, positionY-27);
      } else {
        pushMatrix();
        scale(-1, 1);
        image(rImages[moveIdx], -positionX, positionY-27);
        popMatrix();
      }

      break;
    case IS_MOVING:
      updateBeforeNextMove--;
      if (updateBeforeNextMove == 0) {
        updateBeforeNextMove = 5;
        if (moveIdx < imageNumber - 1)
          moveIdx++;
        else
          moveIdx = 0;
      }
      if (seeRight) {
        image(rImages[moveIdx], positionX, positionY-27);
      } else {
        pushMatrix();
        scale(-1, 1);
        image(rImages[moveIdx], -positionX, positionY-27);
        popMatrix();
      }
      break;
    case IS_COLLISION:
      //깜빡임 효과
      if (stopTime % 15 == 0) {
        if (alphaVal == 255) {
          alphaVal = 127;
        } else if (alphaVal == 127) {
          alphaVal = 255;
        }
      }
      tint(255, alphaVal);
      if (seeRight) {
        image(rImages[0], positionX, positionY-27);
      } else {
        pushMatrix();
        scale(-1, 1);
        image(rImages[0], -positionX, positionY-27);
        popMatrix();
      }
      tint(255, 255);

    default:
      break;
    }

    //플레이어 이동관련
    if (!collision) {
      if (wKeyPressed) {
        if (aKeyPressed || dKeyPressed) {
          positionY -= SPEED*sin(PI/4);
          plusMp();
        } else {
          positionY -= SPEED;
          plusMp();
        }
      } else if (sKeyPressed) {
        if (aKeyPressed || dKeyPressed) {
          positionY += SPEED*sin(PI/4);
          plusMp();
        } else {
          positionY += SPEED;
          plusMp();
        }
      }
      if (aKeyPressed) {
        if (wKeyPressed || sKeyPressed) {
          positionX -= SPEED*cos(PI/4);
        } else {
          positionX -= SPEED;
          plusMp();
        }
        seeRight = false;
      } else if (dKeyPressed) {
        if (wKeyPressed || sKeyPressed) {
          positionX += SPEED*cos(PI/4);
        } else {
          positionX += SPEED;
          plusMp();
        }
        seeRight = true;
      }
    }


    //충돌 직후 시간
    if (collision) {
      stopTime--;
      if (stopTime == 0) {
        collision = false;
        stopTime = 120;
        moveState = MoveState.NOT_MOVING;
        alphaVal = 255;
        tint(255, alphaVal);
      }
    }

    //스펠 딜레이
    if (!shotTime) {
      spellDelay--;
      if (spellDelay == 0) {
        shotTime = true;
        spellDelay = 60;
      }
    }

    //할퀴기 딜레이
    if (!scratchTime) {
      scratchDelay--;
      if (scratchDelay == 0) {
        scratchTime = true;
        scratchDelay = 60;
      }
    }
  }

  //충돌시 애니메이션
  void collisionAni() {
    collision = true;
  }

  //mp회복
  void plusMp() {
    if (mp < 100) {
      mp += plusMp;
    }
  }
}
