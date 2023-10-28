//Main

GameLoop gameLoop;
Background background;
MusicSelect musicSelect;
Room room;

Loading loadingAnim;
boolean loadingDone = false;


//페이지 관련 0:시작창 1:주인공 방 2:음악선택 3:서바이벌게임
int page = 0;

void setup() {
  size(1920, 1080);
  //fullScreen();

  minim = new Minim(this);

  musicList = new ArrayList<AudioPlayer>();

  background = new Background();
  room = new Room();
  musicSelect = new MusicSelect();
  gameLoop = new GameLoop(musicSelect);

  loadingAnim = new Loading();
  thread ("loadData");
}

void draw() {
  background(0);

  if (!loadingDone) {
    loadingAnim.drawLoading();
    return;
  }

  if (currentSong != null) {
    if (!currentSong.isPlaying()) {
      currentSong.play();
    }
  }


  if (page == 0) {
    background.update();
  } else if (page == 1) {
    room.update();
  } else if (page == 2) {
    musicSelect.update();
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
    room.pressRadioPlayer();
  }
  //음악 선택창 일때
  else if (page == 2) {
    musicSelect.pressBtn();
  }
  //서바이벌 게임 일때
  else if (page == 3) {
    if (mouseButton == LEFT) {
      //화염구
      if (!player.collision && player.shotTime && player.mp >= 20) {
        Spell newSpell = new Spell(player, 0);
        spellList.add(newSpell);
        player.shotTime = false;
        player.mp -= player.useMp;
      }
    } else if (mouseButton == RIGHT) {
      //이미지 방향에 따라 공격 가능한 범위 설정
      if ((player.seeRight && player.positionX < mouseX)||(!player.seeRight && player.positionX > mouseX)) {
        //할퀴기
        if (!player.collision && player.scratchTime) {
          attack.mousePosX = mouseX;
          attack.mousePosY = mouseY;
          player.scratchTime = false;
          attack.animationState = true;
          attack. setAngle = false;
        }
      }
    }
  }
}

void loadData() {
  musicList.add(minim.loadFile("song_0.mp3"));
  musicList.add(minim.loadFile("song_1.mp3"));
  musicList.add(minim.loadFile("song_2.mp3"));

  weatherJson = loadJSONObject(url);

  println(weatherJson);

  drawWeather = new DrawWeather(weatherJson.getJSONArray("weather").getJSONObject(0).getInt("id"));
  weatherId = drawWeather.getId();

  roomImg = loadImage("room.png");
  WakeupImg = loadImage("EyeOpen.png");
  SleepImg = loadImage("EyeClosed.png");
  MusicImg = loadImage("CdPlayer.png");

  myFont = createFont("dalmoori.ttf", 50);

  loadingDone = true;
}
