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
  //적 수
  int enemyNum = 30;
  int gameStage = 1;

  //서바이벌 게임 실행 여부
  boolean gameStart = true;

  Survival() {
    noStroke();
    player = new Player();
    mainCharacter = new MainCharacter();
    state = new State(player, mainCharacter, this);
    attack = new Attack(player, mouseX, mouseY);
  }

  void update() {
    //주인공위치
    fill(0, 0, 255, 127);
    ellipse(width/2, height/2, mainCharacter.raidus, mainCharacter.raidus);

    //스폰시간마다 적 생성(60당 약1초)
    if (enemyNum != 0) {
      if (spawnTime == 180) {
        Enemy newEnemy = new Enemy((int)random(0, 4));
        enemyList.add(newEnemy);
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
        enemyNum--;
      }
      //enemy와 spell간의 충돌 체크
      Iterator<Spell> iteratorSpell = spellList.iterator();
      while (iteratorSpell.hasNext()) {
        Spell spell = iteratorSpell.next();
        //spell 맞은 적 삭제
        if (dist(enemy.positionX, enemy.positionY, spell.positionX, spell.positionY) < enemy.radius/2 + spell.radius/2) {
          iteratorSpell.remove();
          iteratorEnemy.remove();
          enemyNum--;
          break;
        }
        //스펠 화면 밖으로 나가면 삭제
        if ((spell.positionX < -spell.radius) || (spell.positionX > width + spell.radius) || (spell.positionY < -spell.radius) || (spell.positionY > height + spell.radius)) {
          iteratorSpell.remove();
        }
      }
    }
    //할퀴기 공격용 - 애니메이션 상태 false면 삭제
    //Iterator<Spell> iteratorSpell = spellList.iterator();
    //while (iteratorSpell.hasNext()) {
    //  Spell spell = iteratorSpell.next();
    //  if (spell.animationState == false) {
    //    iteratorSpell.remove();
    //  }
    //}
    //상태창 update
    state.update();

    //스테이지 종료
    if (enemyNum == 0) {
      enemyNum = 30 + 5 * gameStage;
      gameStage++;
      //여기에 화면바뀌는 코드 넣으면 될듯
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
