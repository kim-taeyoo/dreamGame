//Kim taeyu
//객체
Player player;
ArrayList<Enemy> enemyList = new ArrayList<Enemy>();

class Survival{
  //변수
  float centerRadius = 50;
  int spawnTime = 0;
  
  Survival(){
    player = new Player();
  }
  
  void update(){
    //주인공위치
    ellipse(width/2, height/2, centerRadius, centerRadius);
    
    //스폰시간마다 적 생성(60당 약1초)
    if(spawnTime == 180){
      Enemy newEnemy = new Enemy();
      enemyList.add(newEnemy);
      spawnTime = 0;
    }
    spawnTime++;
    
    //적 객체 그리기
    for (int i = 0; i < enemyList.size(); i++) {
      Enemy enemy = enemyList.get(i);
      ellipse(enemy.positionX, enemy.positionY, 100, 100);
      enemy.update();
      
      //중앙에 도달하면 적 삭제
      if(dist(width/2, height/2, enemy.positionX, enemy.positionY) < 75){
        enemyList.remove(i);
      }
    }
    //플레이어 그리기
    ellipse(player.positionX, player.positionY, 80, 80);
    player.update();
  }
}

void keyPressed(){
    if(key == 'w'){
        player.wKeyPressed = true;
    }
    else if(key == 'a'){
        player.aKeyPressed = true;
    }
    else if(key == 's'){
      player.sKeyPressed = true;
    }
    else if(key == 'd'){
      player.dKeyPressed = true;
    }
  }
  void keyReleased(){
    if(key == 'w'){
        player.wKeyPressed = false;
    }
    else if(key == 'a'){
      player.aKeyPressed = false;
    }
    else if(key == 's'){
      player.sKeyPressed = false;
    }
    else if(key == 'd'){
        player.dKeyPressed = false;
    }
  }
