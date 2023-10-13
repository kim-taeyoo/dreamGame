class State{
  Player player;
  MainCharacter mainCharacter;
  //플레이어 mp
  float maxMp;
  float currentMp;
  float mpBarStart = width - 250;
  float mpBarWidth = 230;
  
  //주인공 악몽 수치
  float maxNightmarePoint = 10;
  float currentNightmarePoint;
  float nightmareBarStart = 20;
  float nightmareBarWidth = 230;
  
 State(Player player, MainCharacter mainCharacter){
   this.player = player;
   this.mainCharacter = mainCharacter;
   
   maxMp = player.mp;
 }
 
 void update(){
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
 }
}
