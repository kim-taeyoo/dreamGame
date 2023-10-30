//Kim Taeyu
class StageClear {
  ArrayList<Firework> fireworks = new ArrayList<Firework>();
  int a = 0;

  StageClear() {
    for (int i = 0; i < 10; i++) {
      fireworks.add(new Firework(-100)); // 왼쪽에서 시작
      fireworks.add(new Firework(width + 100)); // 오른쪽에서 시작
    }
  }

  void update() {
    //스테이지 클리어 알리기
    fill(0, a);
    rect(0, 0, width, height);
    a+=2;
    fill(255, a);
    textSize(100); // 텍스트 크기 설정
    text("Stage Clear!!!", width/2 - 320, height/2);
    textSize(50); // 텍스트 크기 설정
    text("Click on the screen to wake you up", width/2 - 420, height/2+200);
    
    for (int i = fireworks.size() - 1; i >= 0; i--) {
      Firework f = fireworks.get(i);
      f.update();
      f.display();
      if (f.isDone()) {
        fireworks.remove(i);
      }
    }
  }
}
class Firework {
  float x, y;
  float targetX, targetY;
  color fireworkColor;
  boolean exploded = false;
  ArrayList<Particle> particles = new ArrayList<Particle>();

  Firework(float startX) {
    x = startX;
    y = height;
    targetX = random(width);
    targetY = random(height / 2);
    fireworkColor = color(random(255), random(255), random(255));
  }

  void update() {
    if (!exploded) {
      float dx = targetX - x;
      float dy = targetY - y;
      x += dx * 0.1;
      y += dy * 0.1;
      if (dist(x, y, targetX, targetY) < 10) {
        explode();
      }
    } else {
      for (Particle p : particles) {
        p.update();
      }
    }
  }

  void display() {
    if (!exploded) {
      stroke(fireworkColor);
      strokeWeight(4);
      point(x, y);
    } else {
      for (Particle p : particles) {
        p.display();
      }
    }
  }

  void explode() {
    exploded = true;
    for (int i = 0; i < 300; i++) {
      float angle = random(TWO_PI);
      float speed = random(5, 10);
      float size = random(5, 15);
      float particleVY = random(10, 20); // 수직 속도를 늘림
      particles.add(new Particle(x, y, angle, speed, fireworkColor, size, particleVY));
    }
  }

  boolean isDone() {
    return (exploded && particles.isEmpty());
  }
}

class Particle {
  float x, y;
  float vx, vy;
  color particleColor;
  float size;

  Particle(float x, float y, float angle, float speed, color particleColor, float size, float particleVY) {
    this.x = x;
    this.y = y;
    vx = cos(angle) * speed;
    vy = sin(angle) * particleVY; // 수정된 수직 속도 적용
    this.particleColor = particleColor;
    this.size = size;
  }

  void update() {
    x += vx;
    y += vy;
    vy += 0.1;
  }

  void display() {
    stroke(particleColor);
    strokeWeight(size);
    point(x, y);
  }
}
