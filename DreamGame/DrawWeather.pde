class DrawWeather {

  int Id = 0;
  //1=rain
  //2=snow
  //3=clear
  //4=cloud

  int time = 0;

  Rain[] rain = new Rain[1];
  Snow[] snow = new Snow[1];

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
      drawDrop(1, i);
      fill(130);
      noStroke();
      drawCloud(5);
      break;

    case 2: //snow
      drawDrop(2, i);
      fill(180);
      noStroke();
      drawCloud(5);
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

  void drawDrop(int kind, int param) {
    switch(kind) {
    case 1:  //rain
      if (millis()-time > 100) {
        //make rain or snow * param
        rain = new Rain[param];
        for (int i=0; i < param; i++) {
          rain[i] = new Rain();
        }
        time = millis();
      }
      if (rain[0] == null) {
        return;
      }
      for (int i=0; i < param; i++) {

        rain[i].drawRain();
        rain[i].moveRain();
      }

      break;
    case 2:  //snow
      if (millis()-time > 2500) {
        //make rain or snow * param
        snow = new Snow[param];
        for (int i=0; i < param; i++) {
          snow[i] = new Snow();
        }
        time = millis();
      }
      if (snow[0] == null) {
        return;
      }
      for (int i=0; i < param; i++) {
        snow[i].drawSnow();
        snow[i].moveSnow();
      }
      break;
    }
  }
}
