import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;

ArrayList<AudioPlayer> musicList;
AudioPlayer currentSong;
AudioMetaData meta;
int Selected_Music = 0;

FFT fft;

boolean musicPlaying = false;

Playermachine myplayer;

boolean loadingDone = false;

void setup() {
  size(800, 800);

  myplayer = new Playermachine();

  minim = new Minim(this);

  musicList = new ArrayList<AudioPlayer>();

  thread ("loadSongBeforeStart");
}

void draw() {
  background(255);

  myplayer.drawUI();

  fill(0);
  textSize(50);

  if (!loadingDone) {
    text("Loading...", width/2, height/3);
    return;
  }

  getSongData();

  text(meta.title(), width/3, height/2);

  musicPlaying = currentSong.isPlaying();

  fft.forward( currentSong.mix );

  pushMatrix();
  stroke(255, 0, 0);
  for (int i = 0; i < 101; i++)
  {
    float spec = fft.getFreq(i*10);

    float size = map(spec, 0, 255, 0, 1);
 
    line( i, height, i, height - size*height );
  }
  popMatrix();

  if (musicPlaying) {
    text("Playing!", width/3, height/3);
  } else {
    text("Paused", width/3, height/3);
  }
}

void mousePressed() {
  if (!loadingDone) {
    return;
  }


  if (myplayer.HitStartPause()) {
    if (musicPlaying) {
      currentSong.pause();
    } else {
      currentSong.play();
    }
  }


  if (myplayer.HitNext()) {
    currentSong.pause();
    currentSong.rewind();
    nextSong();
    getSongData();
    if (musicPlaying) {
      currentSong.play();
    }
  }

  if (myplayer.HitPre()) {
    currentSong.pause();
    currentSong.rewind();
    preSong();
    getSongData();
    if (musicPlaying) {
      currentSong.play();
    }
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
  fft = new FFT(currentSong.bufferSize(), currentSong.sampleRate());
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
