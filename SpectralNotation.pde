//Table Factors
Table fftData;
int rowIndex = 0;       // We'll iterate over rows in draw()
int times = 0;// Number of frequency bins = columns in CSV
int bands = 0;

//canvas params (calculate in python and pass in)
int pyWidth;// + 100 gives padding at end of track // will use from py to set dims//number of time steps in audio file
int pyHeight; //(9/16) of width for aspect ratio
int padding = 800; //padding should be width / 10, this allows for more gradual end to piece

//int newWidth = pyWidth * quality;

//Spectral Factors
int centroid = 0; //potentially use to scale loudness feature
float loudness = 0.; //measure in librosa, helps scale amplitude values for thresholding
float loudnesScale = 0.;

//user Params 
int quality = 1; //1,2,3,4 - how large the pixel canvas is scaled by, will affect content slightly as well. runtime is factor of n
int style = 0; //sculptural, grains, organic
int density = 1; //the higher, the more dense. it will randomly not plot 1 in n density indices
//1 - 3 recommended. 3 is already pushing it in terms of runtime. 
//will label as less dense or more dense


//Position Related 
int xScan = 0;
int yScan = 0;
int xStep = 0;
int yStep = 0;

//Drawing Related
float amplitude = 0;
float temp = 0;
int pal = 0;
int xLen = 0;
int yLen = 0;
float xDir = 1;
float yDir = 1;



void setup() {
  size(4221, 2363);
  //column count is width, row count is height. load in values from python
  background(255, 252, 239);


  fftData = loadTable("canyon-4221-2363.csv", "csv");



  // Count columns; each is a frequency bin
  times = fftData.getColumnCount();
  bands = fftData.getRowCount();
  
  println("Loaded CSV with " + bands + " rows and "
    + times + " columns.");

//drawing steps
  xStep = int(width / times); 
  yStep = int(height / bands);
  print(height, yStep, yStep*bands);
 
  //print(yStep);
  
  //windowResize(800, 800);
  //surface.setResizable(true);
  //surface.setLocation(100, 100);
  //windowResize(newWidth, newHeight)  ;
  style = 0;
  
}

void draw() {
  //scale(0.2);
  // Optionally clear each frame so you see each row anew:
  // background(255, 252, 239);

  // If we've reached the end of the CSV, stop drawing
  if (rowIndex >= bands) {
    print("DONE");
    noLoop();
    save("CanyonTest5.jpg");
   
    return;
  }


  // For each time step in the current bin (row),
  // read its amplitude and call makeLines()
 
  for (int col = 0; col < times; col++) {
    amplitude = (fftData.getFloat(rowIndex, col));   
    calcMagPal(amplitude);
    
    
    int magnitude = int(temp);   


    updatePos(col, rowIndex);
    //print("col#",col);
    setDrawMethod(style, xScan, yScan, magnitude, pal);
    //makeCluster(xScan, yScan, magnitude, pal);
    //makeLines(xScan, yScan, magnitude, pal);
  }
  
  // Move to the next row
  int progress = (rowIndex+1/bands);
  rowIndex++;
  
  print(progress,"% done. ");
  
}

/**
 * Randomly changes xScan and yScan based on xStep, yStep,
 * and the given baseline (startingY).
 */
