class DrawBtn {

  DrawBtn() {
  }

  void drawUI() {
    drawSelectBtn();
    drawNextBtn();
    drawPreBtn();
  }

  void drawSelectBtn() {
    fill(164, 163, 182);
    noStroke();
    rectMode(CENTER);
    rect(width/2, height*2/3 + 16, 182, 56);
  }

  void drawNextBtn() {
    fill(164, 163, 182);
    noStroke();
    rectMode(CENTER);
    rect(width*2/3 -89, height*2/3 + 16, 56, 56);

    fill(79, 84, 107);
    triangle(width*2/3-67, height*2/3 + 16, width*2/3-107, height*2/3-4, width*2/3-107, height*2/3+36);
  }

  void drawPreBtn() {
    fill(164, 163, 182);
    noStroke();
    rectMode(CENTER);
    rect(width/3 +89, height*2/3 + 16, 56, 56);

    fill(79, 84, 107);
    triangle(width/3+67, height*2/3 + 16, width/3+107, height*2/3-4, width/3+107, height*2/3+36);
  }

  boolean HitSelect() {
    if (mouseX >= (width/2)-91 && mouseX <= (width/2)+91 &&
      mouseY >= (height*2/3)+16-28 && mouseY <= (height*2/3)+16+28) {
      return true;
    } else {
      return false;
    }
  }

  boolean HitNext() {
    if (mouseX >= (width*2/3)-89 -28 && mouseX <= (width*2/3)-89 +28 &&
      mouseY >= (height*2/3)+16-28 && mouseY <= (height*2/3)+16+28) {
      return true;
    } else {
      return false;
    }
  }

  boolean HitPre() {
    if (mouseX >= (width/3)+89 -28 && mouseX <= (width/3)+89 +28 &&
      mouseY >= (height*2/3)+16-28 && mouseY <= (height*2/3)+16+28) {
      return true;
    } else {
      return false;
    }
  }
}
