class Loading {

  float loading_theta = 0;
  
  Loading() {
  }

  void drawLoading() {
    fill(255);
    textSize(50);

    String str = "Loading...";
    text(str, (width/2)-(textWidth(str)*2/3), height/2);

    pushMatrix();
    translate((width/2)+(textWidth(str)*4/7), height/2-10);
    rotate(loading_theta);
    triangle(-17, 10, 0, -20, 17, 10);
    popMatrix();

    loading_theta += 0.1;
  }
}
