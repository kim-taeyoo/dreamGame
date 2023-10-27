//Main

GameLoop gameLoop;
Background background;
MusicSelect musicSelect;
Room room;

boolean loadingDone = false;


//페이지 관련 0:시작창 1:주인공 방 2:음악선택 3:서바이벌게임
int page = 0;

void setup() {
  size(1920, 1080);
  //fullScreen();

  minim = new Minim(this);

  musicList = new ArrayList<AudioPlayer>();

  gameLoop = new GameLoop();
  background = new Background();
  musicSelect = new MusicSelect();
  room = new Room();

  thread ("loadData");
}

void draw() {
  background(0);

  if (!loadingDone) {
    text("Loading...", width/2, height/3);
    return;
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

void loadData() {
  musicList.add(minim.loadFile("song_0.mp3"));
  musicList.add(minim.loadFile("song_1.mp3"));
  musicList.add(minim.loadFile("song_2.mp3"));

  weatherJson = loadJSONObject(url);

  println(weatherJson);

  drawWeather = new DrawWeather(weatherJson.getJSONArray("weather").getJSONObject(0).getInt("id"));
  weatherId = drawWeather.getId();

  roomImg = loadImage("room.png");
  bedImg = loadImage("noPlBed.png");
  MusicImg = loadImage("CdPlayer.png");

  myFont = createFont("dalmoori.ttf", 50);

  loadingDone = true;
}
