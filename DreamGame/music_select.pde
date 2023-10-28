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

  //효과 관련 함수
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

    imageMode(CENTER);
    image(MusicImg, width/2, height/2);

    drawBtn.drawUI();

    getSongData();

    currentSong.play();

    drawEq.drawEq();

    fill(80, 80, 180);
    stroke(80, 80, 180);

    text(meta.title() + "  By."+meta.author(), width/3 + 100, height*3/5 -61);

    rectMode(CORNERS);
    rect(width/3 + 85, height*3/5 -54, width*2/3+10, height*3/5 -52);

    text("Write Song effect here", width/3 +100, height*3/5 -24);

    changeCursorWhenBtn();
  }



  void pressBtn() {
    if (!loadingDone) {
      return;
    }


    if (drawBtn.HitSelect()) {
      //when you select song, next wave start;
      println("Music selected");
      cursor(ARROW);
      if (Selected_Music == 0) {
        speedMusic++;
      } else if (Selected_Music == 1) {
        cooltimeMusic++;
      } else if (Selected_Music == 2) {
        reduceUseMp++;
      }
      page = 3;
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
}
