//sonhyunwoo
class Background {
  PImage i1, i2, i3, i4;
  Button b1, b2, b3;
  boolean credit = false;
  int image = 0;
  float credit_y = 250;

  Background() {
    i1 = loadImage("background_1.png");
    i2 = loadImage("background_2.png");
    i3 = loadImage("background_3.png");
    i4 = loadImage("background_4.png");

    b1 = new Button("Start", 150, height*5/6-100, width/6, height/8);
    b2 = new Button("Quit", width/2-150, height*5/6-100, width/6, height/8);
    b3 = new Button("Credit", width*5/6-150, height*5/6-100 , width/6, height/8);
  }

  void update() {
    if (!credit) {
      background(#ffffff);

      if (image < 20)
        image(i1, 0, 0, width, height);
      else if (image < 40)
        image(i2, 0, 0, width, height);
      else if (image < 60)
        image(i3, 0, 0, width, height);
      else if (image < 80)
        image(i4, 0, 0, width, height);
      else {
        image(i1, 0, 0, width, height);
        image = 0;
      }
      image++;
      textAlign(CENTER, CENTER);
      fill(255, 255, 255);
      textSize(140);
      text("Dream Game", width/2-30, height/2);

      b1.Draw();
      b2.Draw();
      b3.Draw();
    } else {
      if (credit_y < -300) {
        credit = false;
      }

      background(#000000);
      textAlign(CENTER, CENTER);
      fill(255, 255, 255);
      textSize(45);
      text("Credit", 250, 100 + credit_y);

      textAlign(CENTER, CENTER);
      fill(255, 255, 255);
      textSize(20);
      text("Sonhyunwoo", 250, 150 + credit_y);

      textAlign(CENTER, CENTER);
      fill(255, 255, 255);
      textSize(20);
      text("Kimtaeyoo", 250, 170 + credit_y);

      textAlign(CENTER, CENTER);
      fill(255, 255, 255);
      textSize(20);
      text("Keunwoongjae", 250, 190 + credit_y);

      credit_y--;
    }
  }

  void mousePressed() {
    if (b3.MouseIsOver()) {
      credit = true;
    }
  }
}
