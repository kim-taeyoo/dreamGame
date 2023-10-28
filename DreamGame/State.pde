class State {
  Survival survival;
  Player player;
  MainCharacter mainCharacter;
  //플레이어 mp
  float maxMp;
  float currentMp;
  float mpBarStart = width*3/4 - 30;
  float mpBarWidth = width/4;

  //주인공 악몽 수치
  float maxNightmarePoint = 10;
  float currentNightmarePoint;
  float nightmareBarStart = 30;
  float nightmareBarWidth = width/4;

  State(Player player, MainCharacter mainCharacter, Survival survival) {
    this.survival = survival;
    this.player = player;
    this.mainCharacter = mainCharacter;

    maxMp = player.mp;
  }

  void update() {
    //현재 mp가져오기
    currentMp = player.mp;
    //현재 악몽수치 가져오기
    currentNightmarePoint = mainCharacter.nightmarePoint;

    //mp바 그리기
    float currentMpWidth = map(currentMp, 0, maxMp, 0, mpBarWidth);
    fill(0, 150, 255, 100);
    rect(mpBarStart, 20, mpBarWidth, 30);
    fill(0, 150, 255, 255);
    rect(mpBarStart, 20, currentMpWidth, 30);

    //악몽바 그리기
    float currentNightmareWidth = map(currentNightmarePoint, 0, maxNightmarePoint, 0, nightmareBarWidth);
    fill(150, 0, 220, 60);
    rect(nightmareBarStart, 20, nightmareBarWidth, 30);
    fill(150, 0, 220, 255);
    rect(nightmareBarStart, 20, currentNightmareWidth, 30);
    
    //남은 적 수
    fill(0); // 텍스트 색상을 검정으로 설정
    textSize(50); // 텍스트 크기 설정
    text("Enemy: " + survival.maintainEnemy, width/2 + 50, 55);
    //스테이지 표시
    text("STAGE " + survival.gameStage, width/2 - 230, 55);
  }
}
