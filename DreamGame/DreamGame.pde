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
  if(page == 0){
    background.update();
  }
  else if(page == 1){
   roomWindow.update();
  }
  else if(page == 2){
    musicSelectWindow.update();
  }
  else if(page == 3){
    gameLoop.update();
  }
}
