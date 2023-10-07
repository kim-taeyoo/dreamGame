import processing.sound.*;
SoundFile music;

boolean loadingDone = false;

void setup() {
  size(800, 800);
  thread ("loadSong");
}

void draw() {
  background(255);
  fill(0);
  textSize(50);

  if (!loadingDone) {
    text("Loading...", 10, height/2);
    return;
  }


  if (music.isPlaying()) {
    text("Playing!", 10, height/2);
    return;
  } else {
    text("Paused", 10, height/2);
    return;
  }

}

void mousePressed() {
  if (loadingDone) {
    if (music.isPlaying()) {
      music.pause();
    } else {
      music.play();
    }
  }
}

void loadSong() {
  music = new SoundFile(this, "song.mp3");
  music.play();
  
  loadingDone = true;
}
