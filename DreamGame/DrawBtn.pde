class DrawBtn {

  DrawBtn() {
  }

  // draw all button
  void drawUI() {
    drawSelectBtn();
    drawNextBtn();
    drawPreBtn();
  }

  //draw select button
  void drawSelectBtn() {
    fill(164, 163, 182);
    if (HitSelect()) {
      fill(154, 153, 172);
    }
    noStroke();
    rectMode(CENTER);
    rect(width/2, height*2/3 + 16, 182, 56);
  }

  //draw Next song button
  void drawNextBtn() {
    fill(164, 163, 182);
    if (HitNext()) {
      fill(154, 153, 172);
    }
    noStroke();
    rectMode(CENTER);
    rect(width*2/3 -89, height*2/3 + 16, 56, 56);

    fill(79, 84, 107);
    triangle(width*2/3-67, height*2/3 + 16, width*2/3-107, height*2/3-4, width*2/3-107, height*2/3+36);
  }

  //draw Previous song button
  void drawPreBtn() {
    fill(164, 163, 182);
    if (HitPre()) {
      fill(154, 153, 172);
    }
    noStroke();
    rectMode(CENTER);
    rect(width/3 +89, height*2/3 + 16, 56, 56);

    fill(79, 84, 107);
    triangle(width/3+67, height*2/3 + 16, width/3+107, height*2/3-4, width/3+107, height*2/3+36);
  }

  //checek if mouse pressed location is on button
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
