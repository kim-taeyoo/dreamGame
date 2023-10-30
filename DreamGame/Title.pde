//sonhyunwoo
class Title {
  PImage i1, i2, i3, i4;
  Button b1, b2, b3;
  boolean credit = false;
  int image = 0;
  float credit_y = 1000;
  PFont myFont;

  Title() {
    i1 = loadImage("title_1.png");
    i2 = loadImage("title_2.png");
    i3 = loadImage("title_3.png");
    i4 = loadImage("title_4.png");

    b1 = new Button("Start", 150, height*5/6-100, width/6, height/8);
    b2 = new Button("Quit", width/2-150, height*5/6-100, width/6, height/8);
    b3 = new Button("Credit", width*5/6-150, height*5/6-100 , width/6, height/8);
    myFont = createFont("Arial", 24);
  }

  void update() {
    imageMode(CORNER);
    textFont(myFont);
    noStroke();
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

      b1.update();
      b2.update();
      b3.update();
    } else {
      if (credit_y < -300) {
        credit = false;
      }

      background(#000000);
      textAlign(CENTER, CENTER);
      fill(255, 255, 255);
      textSize(100);
      text("Credit", width/2, 100 + credit_y);

      textAlign(CENTER, CENTER);
      fill(255, 255, 255);
      textSize(60);
      text("Sonhyunwoo", width/2, 220 + credit_y);

      textAlign(CENTER, CENTER);
      fill(255, 255, 255);
      textSize(60);
      text("Kimtaeyoo", width/2, 320 + credit_y);

      textAlign(CENTER, CENTER);
      fill(255, 255, 255);
      textSize(60);
      text("Keunwoongjae", width/2, 420 + credit_y);

      credit_y-=3;
    }
  }
}
