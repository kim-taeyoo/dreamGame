//Keun Woongjae

import ddf.minim.*;
import ddf.minim.analysis.*;

class Music_select_window {
  musicSelect myMusic;

  Music_select_window() {
    //size(1200,800);
    //fullScreen();
    background(100);

    minim = new Minim(this);

    musicList = new ArrayList<AudioPlayer>();

    myMusic = new musicSelect();

    thread ("loadDataBeforeStart");
  }

  void update() {
    background(100);
    myMusic.drawPage();
  }

  void loadDataBeforeStart() {
    musicList.add(minim.loadFile("song_0.mp3"));
    musicList.add(minim.loadFile("song_1.mp3"));
    musicList.add(minim.loadFile("song_2.mp3"));

    println(musicList.size());

    MusicImg = loadImage("CdPlayer.png");

    loadingDone = true;
  }

  void mousePressed() {
    myMusic.pressBtn();
  }
}
