//Kimtaeyu
class MainCharacter{
  PImage mainCharacterImg;
  float nightmarePoint = 8;
  float raidus = 80;
  
  MainCharacter(){
    mainCharacterImg = loadImage("maincharacter.png");
  }
  
  void update(){
    image(mainCharacterImg, width/2, height/2);
  }
}
