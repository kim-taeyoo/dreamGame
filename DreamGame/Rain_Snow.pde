class Rain {

  float posX;
  float posY;

  float dropspeed = 20;

  Rain() {
    posX = random(width/2 + 170, width/2 + 330);
    posY = random(height/2 - 410,height/2 - 385);

    dropspeed = 20;
  }

  void drawRain() {
    
    pushMatrix();
    stroke(150, 150, 255);
    strokeWeight(2);

    line(posX, posY, posX, posY+random(40,70));
    popMatrix();

    
  }
  void moveRain() {
    if (posY>height/2) {
      dropspeed = 0;
    }
    posY += dropspeed;
  }
}

class Snow {
  float posX;
  float posY;
  
  float dropspeed = 1;

  Snow() {
    posX = random(width/2 + 170, width/2 + 330);
    posY = random(height/2 - 400,height/2 - 375);

    dropspeed = 1;
  }
  void drawSnow() {
    
    pushMatrix();
    fill(250, 250, 250);
    noStroke();

    ellipse(posX,posY,10,10);
    popMatrix();

  }
  
  void moveSnow() {
    if (posY>height/2) {
      dropspeed = 0;
    }
    posY += dropspeed;
  }
}
