class DrawBtn {

  DrawBtn() {
  }

  void drawUI() {
    drawSelectBtn();
    drawNextBtn();
    drawPreBtn();
  }

  void drawSelectBtn() {
    fill(150);
    stroke(0);
    rectMode(CENTER);
    rect(width/2, height*2/3, 50, 50);
  }

  void drawNextBtn() {
    fill(150);
    stroke(0);
    triangle(width*2/3+45, height*2/3, width*2/3, height*2/3-25, width*2/3, height*2/3+25);
  }

  void drawPreBtn() {
    fill(150);
    stroke(0);
    triangle(width/3-45, height*2/3, width/3, height*2/3-25, width/3, height*2/3+25);
  }

  boolean HitSelect() {
    if (mouseX >= (width/2)-25 && mouseX <= (width/2)+25 &&
      mouseY >= (height*2/3)-25 && mouseY <= (height*2/3)+25) {
      return true;
    } else {
      return false;
    }
  }
  
  boolean HitNext() {
    if (mouseX >= (width*2/3) && mouseX <= (width*2/3)+45 &&
      mouseY >= (height*2/3)-25 && mouseY <= (height*2/3)+25) {
      return true;
    } else {
      return false;
    }
  }
  
  boolean HitPre() {
    if (mouseX >= (width/3)-45 && mouseX <= (width/3) &&
      mouseY >= (height*2/3)-25 && mouseY <= (height*2/3)+25) {
      return true;
    } else {
      return false;
    }
  }
  
  
}
