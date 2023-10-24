class DrawWeather {

  int Id = 0;
  //1=rain
  //2=snow
  //3=clear
  //4=cloud

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
      fill(255, 127, 0);
      noStroke();
      ellipse(width/2 + 300, height/2 - 370, 20, 20);
      break;

    case 2: //snow
      fill(255, 127, 0);
      noStroke();
      ellipse(width/2 + 300, height/2 - 370, 20, 20);
      break;

    case 3: //clear
      fill(255, 130, 120);
      noStroke();
      ellipse(width/2 + 300, height/2 - 350, 50, 50);
      break;

    case 4: //cloud
      fill(255, 150, 150);
      noStroke();
      ellipse(width/2 + 300, height/2 - 350, 50, 50);
      break;

    default:
      break;
    }
  }

  int manipulateData(int i) {

    if (i>100) {
      i=100;
    }

    i = (int)map(i, 0, 100, 1, 10);

    return i;
  }
  
}
