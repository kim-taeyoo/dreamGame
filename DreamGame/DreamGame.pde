GameLoop gameLoop;
Background background;
Music_select_window musicSelectWindow;
Room_window roomWindow;

//페이지 관련 0:시작창 1:주인공 방 2:음악선택 3:서바이벌게임
int page = 0;

void setup() {
  size(1920, 1080);
  //fullScreen();

  gameLoop = new GameLoop();
  background = new Background();
  musicSelectWindow = new Music_select_window();
  roomWindow = new Room_window();
}

void draw() {
  if (page == 0) {
    background.update();
  } else if (page == 1) {
    roomWindow.update();
  } else if (page == 2) {
    musicSelectWindow.update();
  } else if (page == 3) {
    gameLoop.update();
  }
}

void mousePressed() {
  //시작화면일때
  if (page == 0) {
    if (background.b3.mouseIsOver()) {
      background.credit = true;
    } else if (background.b1.mouseIsOver()) {
      page = 1;
    }
  }
  //방 화면 일때
  else if (page == 1) {
  }
  //음악 선택창 일때
  else if (page == 2) {
  }
  //서바이벌 게임 일때
  else if (page == 3) {
    if (mouseButton == LEFT) {
      //화염구
      if (!player.collision && player.shotTime && player.mp >= 20) {
        Spell newSpell = new Spell(player, mouseX, mouseY, 0);
        spellList.add(newSpell);
        player.shotTime = false;
        player.mp -= 20;
      }
    } else if (mouseButton == RIGHT) {
      //할퀴기
      if (!player.collision && player.scratchTime) {
        player.scratchTime = false;
        attack.animationState = true;
      }
    }
  }
}
