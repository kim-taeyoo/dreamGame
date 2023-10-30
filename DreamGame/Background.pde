//Kim Taeyu
class Background {
  //float noiseScale = 0.02;
  //// 그리드의 열과 행 수
  //int cols = width;
  //int rows = height;

  PImage background;
  Background() {
    //cols = width;
    //rows = height;
    background = loadImage("background.png");
  }
  void update() {
    image(background, width/2, height/2);
    //  // Perlin noise 세부 설정
    //  noiseDetail(4);

    //  for (int x = 0; x < cols; x++) {
    //    for (int y = 0; y < rows; y++) {
    //      float noiseValue = noise(x * noiseScale, y * noiseScale) * 255;
    //      drawPixel(x, y, noiseValue);
    //    }
    //  }
    //

    //void drawPixel(int x, int y, float noiseValue) {
    //  float alpha = map(noiseValue, 0, 255, 0, 180);

    //  color c = color(160, 120, 224, alpha);
    //  fill(c);
    //  noStroke();
    //  rect(x, y, 1, 1);
    //}
  }
}
