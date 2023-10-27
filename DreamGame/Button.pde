//sonhyunwoo
class Button {
  String label;
  float x;
  float y;
  float w;
  float h;
  
  Button(String label, float x, float y, float w, float h) {
    this.label = label;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  void update() {
    fill(0, 0, 0);
    stroke(100);
    rect(x, y, w, h);
    textAlign(CENTER, CENTER);
    
    fill(255, 255, 255);
    textSize(40);
    text(label, x + (w/2), y + (h/2));
  }
  
  boolean mouseIsOver() {
    if (mouseX > x && mouseX < (x+w) && mouseY > y && mouseY < (y+h))
      return true;
    return false;
  }
}
