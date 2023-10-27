PImage i1, i2, i3, i4;
Button b1, b2, b3;
boolean credit = false;
int image = 0;
float credit_y = 250;

void setup() {
  size(500, 300);
  i1 = loadImage("1.png");
  i2 = loadImage("2.png");
  i3 = loadImage("3.png");
  i4 = loadImage("4.png");
  
  b1 = new Button("Start", 50, 230, 100, 30);
  b2 = new Button("Quit", 200, 230, 100, 30);
  b3 = new Button("Credit", 350, 230, 100, 30);
}

void draw() {
  if (!credit) {
    background(#ffffff);
    
    if (image < 50)
      image(i1, 0, 0, 500, 300);
    else if (image < 100)
      image(i2, 0, 0, 500, 300);
    else if (image < 150)
      image(i3, 0, 0, 500, 300);
    else if (image < 200)
      image(i4, 0, 0, 500, 300);
    else {
      image(i1, 0, 0, 500, 300);
      image = 0;
    }
    image++;
    textAlign(CENTER, CENTER);
    fill(255, 255, 255);
    textSize(60);
    text("Dream Game", 250, 100);
    
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
