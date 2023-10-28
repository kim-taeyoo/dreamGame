//Kim taeyu
import java.util.Iterator;
//객체
Player player;
MainCharacter mainCharacter;
State state;
Attack attack;

ArrayList<Enemy> enemyList = new ArrayList<Enemy>();
ArrayList<Spell> spellList = new ArrayList<Spell>();

class Survival {
  //변수
  int spawnTime = 0;
  //적 관련
  int setEnemyNum = 20;
  int maintainEnemy = setEnemyNum;
  int currentEnemy = 0;
  float enemySpeed = 0;
  
  int gameStage = 1;

  //서바이벌 게임 실행 여부
  boolean gameStart = true;

  Survival(MusicSelect musicSelect) {
    noStroke();
    player = new Player(musicSelect);
    mainCharacter = new MainCharacter();
    state = new State(player, mainCharacter, this);
    attack = new Attack(player);
  }

  void update() {
    //게임으로 넘어오면 초기설정
    if (gameStart) {
      //음악 별 효과(속도증가)
      player.SPEED_PIXEL_PER_SECOND = 200 + musicSelect.speedMusic * 50;
      player.SPEED = player.SPEED_PIXEL_PER_SECOND / frameRate;
      //쿨타임감소
      player.spellDelay = 60 - musicSelect.cooltimeMusic*10;
      player.scratchDelay = 120 - musicSelect.cooltimeMusic*10;
      //mp소모량 감소
      player.useMp = 20-musicSelect.reduceUseMp;

      gameStart = false;
    } else {
      //주인공위치
      fill(0, 0, 255, 127);
      ellipse(width/2, height/2, mainCharacter.raidus, mainCharacter.raidus);

      //스폰시간마다 적 생성(60당 약1초)
      if (currentEnemy != setEnemyNum) {
        if (spawnTime == 120) {
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
      //충돌처리용 원 투명하게
      fill(0, 255, 0, 0);
      ellipse(player.positionX, player.positionY, player.radius, player.radius);
      player.update();

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

      //스테이지 종료
      if (maintainEnemy == 0) {
        //다음스테이지 수정사항
        setEnemyNum += 5 * gameStage;
        maintainEnemy = setEnemyNum;
        currentEnemy = 0;
        enemySpeed += 0.3;
        gameStage++;
        //게임종료
        page = 1;
        gameStart = true;
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
