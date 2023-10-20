import ddf.minim.*;
import ddf.minim.analysis.*;

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
  
  myFont = createFont("dalmoori.ttf",50);

  thread ("loadSongBeforeStart");
}

void draw() {
  background(255);

  drawBtn.drawUI();

  textFont(myFont,50);

  if (!loadingDone) {
    text("Loading...", width/2, height/3);
    return;
  }

  getSongData();
  
  currentSong.play();

  drawEq.draw();

  fill(0);

  text(meta.title()+"  By."+meta.author(), width/3, height/2);
}


void mousePressed() {
  if (!loadingDone) {
    return;
  }


  if (drawBtn.HitSelect()) {
    //when you select song, next wave start;
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
