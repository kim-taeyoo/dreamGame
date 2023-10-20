class DrawEq {

  FFT fft;
  AudioPlayer song;

  DrawEq(AudioPlayer s) {
    song = s;
    fft = new FFT(song.bufferSize(), song.sampleRate());
  }

  void draw() {
    fft.forward(song.mix);
    
    pushMatrix();
    fill(100, 100, 150);
    noStroke();
    for (int i = 0; i < 5; i++)
    {
      float spec = constrain(fft.getFreq(i*200)*20,0,1024);

      float size = map(spec, 0, 1024, 2, 50);

      float startX = width/4 + i*11+1;
      float startY = height/2;
      float wide = 10;
      float hight = -size;



      rectMode(CORNERS);

      rect(startX, startY, startX+wide, startY+hight);
    }
    popMatrix();
  }
}
