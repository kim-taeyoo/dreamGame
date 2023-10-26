class DrawWeather {

  int Id = 0;
  //1=rain
  //2=snow
  //3=clear
  //4=cloud
  
  int time = 0;
  
  Rain rain;
  Snow snow;

  DrawWeather(int w) {
    if (300<=w&&w<600) {
      Id = 1; //rain
    } else if (600<=w&&w<700) {
      Id = 2; //snow
    } else if (w==800) {
      Id = 3; //clear
    } else if (800<w&&w<=804) {
      Id = 4; //cloud
    } else {
      Id = 0; //nothing
    }
  }

  int getId() {
    return Id;
  }

  void drawWindow(int parameter) {
    //parameter = when rain, rain data. cloud, cloud data
    int i = manipulateData(parameter);

    switch(Id) {

    case 0:
      break;

    case 1:  //rain
      fill(130);
      noStroke();
      drawCloud(5);
      drawDrop(i);
      break;

    case 2: //snow
      fill(255, 127, 0);
      noStroke();
      ellipse(width/2 + 300, height/2 - 370, 20, 20);
      break;

    case 3: //clear
      fill(255, 200, 120);
      noStroke();
      ellipse(width/2 + 300, height/2 - 350, 45, 45);
      break;

    case 4: //cloud
      fill(210);
      noStroke();
      drawCloud(i);
      break;

    default:
      break;
    }
  }

  int manipulateData(int i) {

    if (i>100) {
      i=100;
    }

    i = (int)map(i, 0, 100, 1, 5);

    return i;
  }

  void drawCloud(int param) {
    for (int i = 0; i < param; i++) {
      ellipse(width/2 + 140+i*48, height/2 - 355, 25, 25);
      ellipse(width/2 + 155+i*48, height/2 - 355, 30, 30);
      ellipse(width/2 + 170+i*48, height/2 - 355, 25, 25);
    }
  }

  void drawDrop(int param) {
    if(millis()-time > 200) {
      //make rain or snow * param
      
      time = millis();
    }
    
    //draw rain or snow
    //drop animation
  }
}
