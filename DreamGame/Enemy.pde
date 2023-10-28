//Kim taeyu
enum Monster {
  IMP,
    PUMPKIN,
    DOC,
    SKELETON
}
class Enemy {
  float positionX;
  float positionY;
  float velocityX;
  float velocityY;
  float speed = 0;
  float centerX;
  float centerY;
  float radius = 70;

  //이미지 처리
  PImage[] rImages;
  Monster monster;
  int imageNumber = 4;
  int updateBeforeNextMove = 5;
  int moveIdx = 0;

  //몬스터 종류지정
  Monster getMonster(int num) {
    switch(num) {
    case 0:
      return Monster.IMP;
    case 1:
      return Monster.PUMPKIN;
    case 2:
      return Monster.DOC;
    case 3:
      return Monster.SKELETON;
    default:
      throw new IllegalArgumentException("Invalid value for Monster: " + num);
    }
  }

  Enemy(int num) {
    centerX = width/2;
    centerY = height/2;
    //위치 랜덤 설정
    setRandomPosition();
    //설정된 종류의 몬스터로 이미지 설정
    monster = getMonster(num);
    rImages = new PImage[imageNumber];
    // 이미지 저장(우측방향)
    switch(monster) {
    case IMP:
      radius = 40;
      for (int i = 0; i < imageNumber; i++) {
        rImages[i] = loadImage("imp_run_" + i + ".png");
      }
      //임프 초기설정
      speed = 1.5;
      break;
    case PUMPKIN:
      radius = 65;
      for (int i = 0; i < imageNumber; i++) {
        rImages[i] = loadImage("pumpkin_run_" + i + ".png");
      }
      //펌킨 초기설정
      speed = 1.5;
      break;
    case DOC:
      radius = 50;
      for (int i = 0; i < imageNumber; i++) {
        rImages[i] = loadImage("doc_run_" + i + ".png");
      }
      //doc 초기설정
      speed = 2;
      break;
    case SKELETON:
      radius = 50;
      for (int i = 0; i < imageNumber; i++) {
        rImages[i] = loadImage("skeleton_run_" + i + ".png");
      }
      //해골 초기설정
      speed = 2;
      break;
    }
  }

  //화면밖 랜덤위치 스폰
  void spawnUpOrDown() {
    int sign = ((int)(random(2)) * 2 - 1);
    positionX = random(width);
    if (sign > 0)
      positionY = sign * random(0, 100) + height;
    else
      positionY = sign * random(0, 100);
  }
  void spawnLeftOrRight() {
    int sign = ((int)(random(2)) * 2 - 1);
    if (sign > 0)
      positionX = sign * random(0, 100) + width;
    else
      positionX = sign * random(0, 100);
    positionY = random(height);
  }
  void setRandomPosition() {
    int num = (int)random(0, 2);
    if (num == 0)
      spawnUpOrDown();
    else
      spawnLeftOrRight();
  }

  void update() {
    //애니메이션 관련
    updateBeforeNextMove--;
    if (updateBeforeNextMove == 0) {
        updateBeforeNextMove = 5;
        if (moveIdx < imageNumber - 1)
          moveIdx++;
        else
          moveIdx = 0;
      }
    if (velocityX > 0) {
      image(rImages[moveIdx], positionX, positionY-3);
    } else {
      pushMatrix();
      scale(-1, 1);
      image(rImages[moveIdx], -positionX, positionY-3);
      popMatrix();
    }
    //이동 관련
    float distanceToCenterX = centerX - positionX;
    float distanceToCenterY = centerY - positionY;
    float distanceToCenter = dist(centerX, centerY, positionX, positionY);

    float directionX = distanceToCenterX/distanceToCenter;
    float directionY = distanceToCenterY/distanceToCenter;

    if (distanceToCenter > 0) {
      velocityX = directionX*speed;
      velocityY = directionY*speed;
    }

    positionX += velocityX;
    positionY += velocityY;
  }
}
