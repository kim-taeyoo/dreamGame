//Keun Woongjae

import ddf.minim.*;
import ddf.minim.analysis.*;


Minim minim;

ArrayList<AudioPlayer> musicList;
AudioPlayer currentSong;
AudioMetaData meta;
int Selected_Music = 0;

PImage MusicImg;

PFont myFont;

class MusicSelect {

  //효과 관련 변수
  int speedMusic = 0;
  int cooltimeMusic = 0;
  int reduceUseMp = 0;

  DrawEq drawEq;

  DrawBtn drawBtn;


  MusicSelect() {

    drawBtn = new DrawBtn();
  }

  void update() {

    background(100);

    textFont(myFont, 25);
    textAlign(LEFT);

    //background img
    imageMode(CENTER);
    image(MusicImg, width/2, height/2);

    drawBtn.drawUI();

    getSongData();

    currentSong.play();

    //make player's screen
    drawEq.drawEq();

    fill(80, 80, 180);
    stroke(80, 80, 180);

    text(meta.title() + "  By."+meta.author(), width/3 + 100, height*3/5 -61); //song title, author

    rectMode(CORNERS);
    noStroke();
    rect(width/3 + 85, height*3/5 -54, width*2/3+10, height*3/5 -52);

    text(meta.comment(), width/3 +100, height*3/5 -24);  //song description

    changeCursorWhenBtn();
  }



  void pressBtn() {
    if (!loadingDone) {
      return;
    }


    if (drawBtn.HitSelect()) {
      //when you select song, go back start;
      println("Music selected");
      cursor(ARROW);
      if (Selected_Music == 0) {
        speedMusic++;
      } else if (Selected_Music == 1) {
        cooltimeMusic++;
      } else if (Selected_Music == 2) {
        reduceUseMp++;
      }
      isMusicSelected = true;
      readyTime = millis();

      page = 1;
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

  //get selected song to currentSong
  void getSongData() {
    currentSong = musicList.get(Selected_Music);
    meta = currentSong.getMetaData();
    drawEq = new DrawEq(currentSong);
  }

  //get next song
  void nextSong() {
    Selected_Music++;
    if (Selected_Music == musicList.size()) {
      Selected_Music = 0;
    }
  }

  //get previous song
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
}
