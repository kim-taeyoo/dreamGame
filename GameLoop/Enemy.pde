//Kim taeyu

class Enemy{
  float positionX;
  float positionY;
  float velocityX;
  float velocityY;
  float speed = 5;
  float centerX;
  float centerY;
  float radius = 75;
  
  Enemy(){
    centerX = width/2;
    centerY = height/2;
    
    setRandomPosition();
  }
  
  //화면밖 랜덤위치 스폰
  void spawnUpOrDown(){
    int sign = ((int)(random(2)) * 2 - 1);
    positionX = random(width);
    if(sign > 0)
      positionY = sign * random(0 , 100) + height;
    else
      positionY = sign * random(0 , 100);
  }
  void spawnLeftOrRight(){
    int sign = ((int)(random(2)) * 2 - 1);
    if(sign > 0)
      positionX = sign * random(0 , 100) + width;
    else
      positionX = sign * random(0 , 100);
    positionY = random(height);
  }
  void setRandomPosition(){
    int num = (int)random(0, 2);
    if(num == 0)
      spawnUpOrDown();
    else
      spawnLeftOrRight();
  }
  
  void update(){
    float distanceToCenterX = centerX - positionX;
    float distanceToCenterY = centerY - positionY;
    float distanceToCenter = dist(centerX, centerY, positionX, positionY);
    
    float directionX = distanceToCenterX/distanceToCenter;
    float directionY = distanceToCenterY/distanceToCenter;
    
    if(distanceToCenter > 0){
      velocityX = directionX*speed;
      velocityY = directionY*speed;
    }
    
    positionX += velocityX;
    positionY += velocityY;
  }
}
