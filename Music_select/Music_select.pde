import ddf.minim.*;
import ddf.minim.analysis.*;

PImage img;

Minim minim;

ArrayList<AudioPlayer> musicList;
AudioPlayer currentSong;
AudioMetaData meta;
int Selected_Music = 0;

DrawEq drawEq;

DrawBtn drawBtn;

boolean loadingDone = false;


PFont myFont;

void setup() {
  fullScreen();

  drawBtn = new DrawBtn();

  minim = new Minim(this);

  musicList = new ArrayList<AudioPlayer>();

  myFont = createFont("dalmoori.ttf", 50);

  thread ("loadSongBeforeStart");
}

void draw() {
  background(100);

  textFont(myFont, 25);

  if (!loadingDone) {
    text("Loading...", width/2, height/3);
    return;
  }


  imageMode(CENTER);
  image(img, width/2, height/2);

  drawBtn.drawUI();

  getSongData();

  currentSong.play();

  drawEq.draw();

  fill(80, 80, 180);
  stroke(80, 80, 180);

  text(meta.title() + "  By."+meta.author(), width/3 + 100, height*3/5 -61);

  rectMode(CORNERS);
  rect(width/3 + 85, height*3/5 -54, width*2/3+10, height*3/5 -52);

  text("Write Song effect here", width/3 +100, height*3/5 -24);
  
  changeCursorWhenBtn();
}


void mousePressed() {
  if (!loadingDone) {
    return;
  }


  if (drawBtn.HitSelect()) {
    //when you select song, next wave start;
    text("Selected.", width/2, height/3);
  }


  if (drawBtn.HitNext()) {
    currentSong.pause();
    currentSong.rewind();
    nextSong();
    getSongData();
    currentSong.play();
  }

  if (drawBtn.HitPre()) {
    currentSong.pause();
    currentSong.rewind();
    preSong();
    getSongData();
    currentSong.play();
  }
}


void loadSongBeforeStart() {
  musicList.add(minim.loadFile("song_0.mp3"));
  musicList.add(minim.loadFile("song_1.mp3"));
  musicList.add(minim.loadFile("song_2.mp3"));

  img = loadImage("CdPlayer.png");


  loadingDone = true;
}

void getSongData() {
  currentSong = musicList.get(Selected_Music);
  meta = currentSong.getMetaData();
  drawEq = new DrawEq(currentSong);
}

void nextSong() {
  Selected_Music++;
  if (Selected_Music == musicList.size()) {
    Selected_Music = 0;
  }
}

void preSong() {
  Selected_Music--;
  if (Selected_Music < 0) {
    Selected_Music = musicList.size()-1;
  }
}

void changeCursorWhenBtn() {
  if (drawBtn.HitSelect()) {
    cursor(HAND);
  } else if (drawBtn.HitNext()) {
    cursor(HAND);
  } else if (drawBtn.HitPre()) {
    cursor(HAND);
  } else {
    cursor(ARROW);
  }
}
