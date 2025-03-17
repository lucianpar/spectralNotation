void updatePos(int col, int row) {
  //should maybe switch roll and col
  xScan = xStep * col;
  yScan =height - (int(height/4.5)) - (yStep * row); //accounts for 0 indexing
}

void makeLines(int x, int y, int mag, int pal) {
  int randomMag = round(random(density));
  if (randomMag == density){
    mag = 0;
    return;
  }
  if (mag<=10){
    xLen = 1;
    yLen = 1;
  }
  else if (mag == 20){
    xLen = int(mag*yStep)+yStep;
    yLen = int(mag*yStep)+yStep;
  }
  else{
    xLen = int(random(mag*yStep));
    yLen = int(random(mag*yStep));
  }
  int loops = mag + yStep;//int(mag + yStep); //might tweak param 

  // Random direction each time
  xDir = (random(1) < 0.5) ? -1 : 1;
  yDir = (random(1) < 0.5) ? -1 : 1;

  for (int m = 0; m < loops; m++) {
    //pallete of 80 has worked
    switch(pal){
      case 0:
        stroke(194, 198, 255, 1); // faint purple
        break;
      case 1:
        stroke(random(20.), random(255.), random(228.), 1); //main green
        break;
      case 2:
        stroke(random(20.), random(200.), random(255.), 1); //main blue
        break;
      case 3:
        stroke(129, 0, 199, 1); //purple
        break;
      case 4:
        stroke(176, 0, 91,1); //scarlet     
        break;
      //add more colors, tweak order
        
    }
    strokeWeight(1);
    line(x, y, x + (xLen * xDir), y + (random(yLen) * yDir));
  }
}

//void makeCluster(int x, int y, int mag, int pal){
//  int randomMag = round(random(density*5));
//  int len;
//  if (randomMag == density){
//    mag = 0;
//    return;
//  }
//  if (mag<=10){
//    len = 1;
//  }
//  else if (mag == 20){
//    len = 3;
//  }
//  else{
//    len = 2;
   
//  }
//  int loops = mag*100;//int(mag + yStep); //might tweak param 

//  // Random direction each time
//  xDir = (random(1) < 0.5) ? -1 : 1;
//  yDir = (random(1) < 0.5) ? -1 : 1;
//  switch(pal){
//      case 0:
//        stroke(194, 198, 255, 1); // faint purple
//        break;
//      case 1:
//        stroke(random(20.), random(255.), random(228.), 1); //main green
//        break;
//      case 2:
//        stroke(random(20.), random(200.), random(255.), 1); //main blue
//        break;
//      case 3:
//        stroke(129, 0, 199, 1); //purple
//        break;
//      case 4:
//        stroke(176, 0, 91,1); //scarlet     
//        break;
//      //add more colors, tweak order
        
//    }

//  for (int m = 0; m < loops; m++) {
//    int displace = int(random(yStep));
//    //pallete of 80 has worked
    
//    strokeWeight(3);
//    line(x +(displace*xDir), y + (displace*yDir), x +(displace*xDir),y + (displace*yDir));
//  }
//}



void makeCluster(int x, int y, int mag, int pal){
  int randomMag = round(random(density));
  if (randomMag == density){
    mag = 0;
    
    return;
  }
  if (pal == 4){
    mag = mag + int(random(4)*yStep);
  }
  switch(pal){
      case 0:
        stroke(194, 198, 255, 1); // faint purple
        break;
      case 1:
        stroke(random(20.), random(255.), random(228.), 1); //main green
        break;
      case 2:
        stroke(random(20.), random(200.), random(255.), 1); //main blue
        break;
      case 3:
        stroke(129, 0, 199, 1); //purple
        break;
      case 4:
        stroke(176, 0, 91,1); //scarlet     
        break;
      //add more colors, tweak order
        
    }
  //stroke(176, 0, 91,1);
  strokeWeight(10);
  point(x, y);
  //xDir = (random(1) < 0.5) ? -1 : 1;
  //yDir = (random(1) < 0.5) ? -1 : 1;
  for (int m = 0; m < (mag*100); m++) {
    xDir = (random(1) < 0.5) ? -1 : 1; //might be a problem with global var
    yDir = (random(1) < 0.5) ? -1 : 1;
    point(x+((random(yStep*m))*xDir), y + ((random(yStep*m))*yDir));
  }
}

void calcMagPal(float amplitude){
  if (amplitude<1){
      temp = 0;
      pal = 0;
    }
    else if (amplitude>=1 && amplitude<10){
      temp = amplitude;
      pal = 0;
    }
    else if (amplitude>=10 && amplitude<40){ //will need to tweak these numbers, might need to scan for a median
      temp =amplitude;
      pal = 1;
      //print(3);
    }
    else if (amplitude>=40 && amplitude<=60){
      temp = 40;
      pal = 2;
    }
    else if (amplitude > 60 && amplitude<=80){
      temp = amplitude;
      pal = 3;
    }
    else if (amplitude > 80){
      temp = amplitude;
      pal = 4;
    }
}

//void makeArcs(int x, int y, int mag, int pal){
//}

void setDrawMethod(int method, int xScan, int yScan, int magnitude, int pal){
  switch(method){
    case 0:
      makeLines(xScan, yScan, magnitude, pal);
      break;
    case 1: 
      makeCluster(xScan, yScan, magnitude, pal);
      break;
    //case 2:
    //  makeArcs(xScan, yScan, magnitude, pal);
  }
}
