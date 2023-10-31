//Kim taeyu
import java.util.Iterator;
//객체
Player player;
MainCharacter mainCharacter;
State state;
Attack attack;
StageClear stageClear;
Background background;

ArrayList<Enemy> enemyList = new ArrayList<Enemy>();
ArrayList<Spell> spellList = new ArrayList<Spell>();

class Survival {
  //다른 페이지 클래스
  Room room;
  //변수
  int spawnTime = 0;
  int minusSpawnTime = 0;
  //적 관련
  int setEnemyNum = 10;
  int maintainEnemy = setEnemyNum;
  int currentEnemy = 0;
  float enemySpeed = 0;

  int gameStage = 1;

  //서바이벌 게임 실행 여부
  boolean gameStart = true;
  boolean loadingTime= true;
  int loadingSec = 180;

  //스테이지 클리어
  boolean isClear = false;
  boolean goToRoom = false;

  //게임오버
  boolean gameOver = false;
  boolean restartGame = false;
  int a = 0;

  Survival(MusicSelect musicSelect, Room room) {
    noStroke();
    this.room = room;
    player = new Player(musicSelect);
    mainCharacter = new MainCharacter();
    state = new State(player, mainCharacter, this);
    attack = new Attack(player);
    background = new Background();
  }

  void update() {
    ////게임 클리어시 화면 반투명
    //if(isClear){
    //  tint(255, 100);
    //}
    //게임으로 넘어오면 초기설정
    if (gameStart) {
      //플레이어위치
      player.positionX = width/2+70;
      player.positionY = height/2;
      player.seeRight = true;
      //음악 별 효과(속도증가)
      player.SPEED_PIXEL_PER_SECOND = 200 + musicSelect.speedMusic * 50;
      player.SPEED = player.SPEED_PIXEL_PER_SECOND / frameRate;
      //쿨타임감소
      player.spellDelay = 60 - musicSelect.cooltimeMusic*10;
      player.scratchDelay = 120 - musicSelect.cooltimeMusic*10;
      //mp소모량 감소
      player.useMp = 20-musicSelect.reduceUseMp;

      //스테이지 클리어 객체 초기화
      stageClear = new StageClear();

      //로딩텍스트
      if (loadingTime) {
        background(0);
        fill(255); // 텍스트 색상을 하양으로 설정
        textSize(100); // 텍스트 크기 설정
        text("Sleeping", width/2 - 190, height/2);
        if (loadingSec < 150) {
          text(".", width/2 + 220, height/2);
        }
        if (loadingSec < 100) {
          text(".", width/2 + 260, height/2);
        }
        if (loadingSec < 50) {
          text(".", width/2 + 300, height/2);
        }

        //효과 텍스트
        textSize(50);
        if (Selected_Music == 0) {
          text("Speed has increased", width/2-230, height/2+150);
        } else if (Selected_Music == 1) {
          text("Attack cooltime decreased", width/2-310, height/2+150);
        } else if (Selected_Music == 2) {
          text("Consumption of mp has decreased", width/2-370, height/2+150);
        }

        loadingSec--;
        if (loadingSec  == 0) {
          loadingSec = 180;
          loadingTime = false;
        }
      } else {
        gameStart = false;
      }
    } else {
      //배경출력
      background.update();
      //주인공위치
      fill(0, 0, 255, 0);
      mainCharacter.update();
      ellipse(width/2, height/2, mainCharacter.raidus, mainCharacter.raidus);


      //스폰시간마다 적 생성(60당 약1초)
      if (currentEnemy != setEnemyNum) {
        if (spawnTime == 120-minusSpawnTime) {
          Enemy newEnemy = new Enemy((int)random(0, 4), enemySpeed);
          enemyList.add(newEnemy);
          currentEnemy++;
          spawnTime = 0;
        }
        spawnTime++;
      }

      //적 객체 그리기
      for (int i = 0; i < enemyList.size(); i++) {
        Enemy enemy = enemyList.get(i);
        //충돌범위
        fill(255, 0, 0, 0);
        ellipse(enemy.positionX, enemy.positionY, enemy.radius, enemy.radius);
        enemy.update();
      }
      //스펠 그리기
      for (int i = 0; i < spellList.size(); i++) {
        Spell spell = spellList.get(i);
        fill(127, 0, 127, 0);
        ellipse(spell.positionX, spell.positionY, spell.radius, spell.radius);
        spell.update();
      }

      //플레이어 그리기
      //주인공과 닿으면 반투명
      if (dist(player.positionX, player.positionY, width/2, height/2) < player.radius/2+mainCharacter.raidus/2) {
        tint(255, 80);
      } else {
        tint(255, 255);
      }
      //충돌처리용 원 투명하게
      fill(0, 255, 0, 0);
      ellipse(player.positionX, player.positionY, player.radius, player.radius);
      player.update();
      tint(255, 255);

      //기본공격 그리기
      attack.update();

      //충돌체크
      //enemy와 player간의 충돌 체크
      Iterator<Enemy> iteratorEnemy = enemyList.iterator();
      while (iteratorEnemy.hasNext()) {
        Enemy enemy = iteratorEnemy.next();
        if (!player.collision) {
          if (dist(enemy.positionX, enemy.positionY, player.positionX, player.positionY) < enemy.radius/2 + player.radius/2) {
            player.collisionAni();
          }
        }
        //주인공과 닿으면 적 삭제
        if (dist(width/2, height/2, enemy.positionX, enemy.positionY) < enemy.radius/2 + mainCharacter.raidus/2) {
          mainCharacter.nightmarePoint++;
          iteratorEnemy.remove();
          maintainEnemy--;
        }
        //할퀴기 범위내 적이 있으면 삭제
        if (attack.animationState) {
          if (dist(attack.scratchX, attack.scratchY, enemy.positionX, enemy.positionY) < attack.radius/2 + enemy.radius/2) {
            iteratorEnemy.remove();
            maintainEnemy--;
          }
        }
        //enemy와 spell간의 충돌 체크
        Iterator<Spell> iteratorSpell = spellList.iterator();
        while (iteratorSpell.hasNext()) {
          Spell spell = iteratorSpell.next();
          //spell 맞은 적 삭제
          if (dist(enemy.positionX, enemy.positionY, spell.positionX, spell.positionY) < enemy.radius/2 + spell.radius/2) {
            iteratorSpell.remove();
            iteratorEnemy.remove();
            maintainEnemy--;
            break;
          }
          //스펠 화면 밖으로 나가면 삭제
          if ((spell.positionX < -spell.radius) || (spell.positionX > width + spell.radius) || (spell.positionY < -spell.radius) || (spell.positionY > height + spell.radius)) {
            iteratorSpell.remove();
          }
        }
      }
      //상태창 update
      state.update();

      //게임오버 시 게임초기화
      if (mainCharacter.nightmarePoint >= 10) {
        gameOver = true;
      }
      if (gameOver) {
        //스테이지 클리어 알리기
        fill(0, a);
        rect(0, 0, width, height);
        a+=2;
        fill(255, a);
        textSize(100); // 텍스트 크기 설정
        text("Game Over...", width/2 - 270, height/2);
        textSize(50); // 텍스트 크기 설정
        text("Click on the screen to back to the room", width/2 - 500, height/2+200);

        if (restartGame) {
          gameOver = false;
          restartGame = false;
          //다음스테이지 수정사항
          setEnemyNum = 10 + 5 * (gameStage-1);
          maintainEnemy = setEnemyNum;
          currentEnemy = 0;
          loadingTime = true;
          isClear = false;
          goToRoom = false;
          spellList.clear();
          enemyList.clear();
          player.mp = 100;
          mainCharacter.nightmarePoint = 0;
          //게임종료
          room.alpha = 0;
          page = 1;

          if (Selected_Music == 0) {
            musicSelect.speedMusic--;
          } else if (Selected_Music == 1) {
            musicSelect.cooltimeMusic--;
          } else if (Selected_Music == 2) {
            musicSelect.reduceUseMp--;
          }

          currentSong.pause();
          currentSong.rewind();
          currentSong = null;

          isMusicSelected = false;
          readyToStart = false;
          gameStart = true;
        }
      }

      //스테이지 종료
      if (!gameOver && maintainEnemy == 0) {
        isClear = true;
      }
      //클리어시 폭죽
      if (isClear) {
        if (!goToRoom) {
          stageClear.update();
        } else {
          //다음스테이지 수정사항
          setEnemyNum += 5 * gameStage;
          maintainEnemy = setEnemyNum;
          currentEnemy = 0;
          enemySpeed += 0.1;
          if (minusSpawnTime >15) {
            minusSpawnTime += 3;
          }
          gameStage++;
          loadingTime = true;
          isClear = false;
          goToRoom = false;
          spellList.clear();
          player.mp = 100;
          //게임종료
          room.alpha = 0;
          page = 1;

          currentSong.pause();
          currentSong.rewind();
          currentSong = null;

          isMusicSelected = false;
          readyToStart = false;
          gameStart = true;
        }
      }
    }
  }
}


void keyPressed() {
  if (!player.collision) {
    if (key == 'w') {
      player.wKeyPressed = true;
    } else if (key == 'a') {
      player.aKeyPressed = true;
    } else if (key == 's') {
      player.sKeyPressed = true;
    } else if (key == 'd') {
      player.dKeyPressed = true;
    }
  } else {
    player.wKeyPressed = false;
    player.aKeyPressed = false;
    player.sKeyPressed = false;
    player.dKeyPressed = false;
  }
}
void keyReleased() {
  if (key == 'w') {
    player.wKeyPressed = false;
  } else if (key == 'a') {
    player.aKeyPressed = false;
  } else if (key == 's') {
    player.sKeyPressed = false;
  } else if (key == 'd') {
    player.dKeyPressed = false;
  }
}
