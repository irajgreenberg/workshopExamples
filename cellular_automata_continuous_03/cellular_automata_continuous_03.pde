/**
 * Continuous Cellular Automata Main Tab - 03
 * By Ira Greenberg <br />
 * The Essential Guide to Processing for Flash Developers,
 * Friends of ED, 2009
 */

// global variables
int rows = 8, cols = 8;
int rowSpan, colSpan;
int cellScale = 1;
float threshMin = 128, threshMax = 255;
float constMin = 2, constMax = 127;
// for random seed placement
int seedCount = 1;

// declare arrays
CA_1DC[] cacs;
float[][] thresholds;
float[][] consts;
int[][] seeds;
color[][] clrs;

// for interactivity
int overID = 0;
boolean iSFirstClick = true;

void setup(){
  size(800, 800);
  initialize();
}

void initialize(){
  this.rows = rows;
  this.cols = cols;
  rowSpan = height/rows;
  colSpan = width/cols;

  cacs = new CA_1DC[rows*cols];
  thresholds = new float[cacs.length][3];
  consts = new float[cacs.length][3];
  seeds = new int[cacs.length][seedCount];
  clrs = new color[cacs.length][seedCount];

  for (int i=0; i<cacs.length; i++){
    cacs[i] = new CA_1DC(colSpan, rowSpan, cellScale);

    for (int j=0; j<seedCount; j++){
      seeds[i][j] = int((cacs[i].rows-1)*(cacs[i].cols) + int(random(cacs[i].cols)));
      clrs[i][j] = color(random(255), random(255), random(255));
    }
    cacs[i].setInitState(seeds[i], clrs[i]);

    for (int j=0; j<thresholds[0].length; j++){
      thresholds[i][j] = random(threshMin, threshMax);
      consts[i][j] = random(constMin, constMax);
    }
    cacs[i].setThresholds(thresholds[i]);
    cacs[i].setconsts(consts[i]);
  }
}



// draw selected CA full screen with original values
void calcCA(int i){
  // factor to scale the initial pixel state
  float widthFctr = width/cacs[i].w;
  // get original rows and cols value before updated
  float oldRows = cacs[i].rows;
  float oldCols = cacs[i].cols;

  // new output will fill te sketch window
  rows = cols = 1;
  int scl = cacs[0].cellScale;
  // reinitialize cacs
  cacs = new CA_1DC[1];
  cacs[0] = new CA_1DC(width, height, scl);
  // updates initial seeds, if originally set
  for (int j=0; j<seedCount; j++){
    if (seeds[i][j] !=0){
      seeds[i][j] = int((cacs[0].rows-1)*cacs[0].cols + (seeds[i][j]-(oldRows-1)*oldCols)*widthFctr);
    } else {
      // if default centered seed was used
      seeds[i][j] = (cacs[0].rows-1)*cacs[0].cols + cacs[0].cols/2;
    }
  }
  // set with original values
  cacs[0].setInitState(seeds[i], clrs[i]);
  cacs[0].setThresholds(thresholds[i]);
  cacs[0].setconsts(consts[i]);
}

void draw(){
  for (int i=0; i<rows; i++){
    for (int j=0; j<cols; j++){
      pushMatrix();
      // simplify stuff
      int index = cols*i + j;
      float x = cacs[index].w*j;
      float y = cacs[index].h*i;
      float w = cacs[index].w;
      float h = cacs[index].h;
      // move top left corner to 0,0
      translate(w/2, h/2);
      // move into position in table
      translate(x, y);
      // do CA magic
      cacs[index].createGeneration();
      popMatrix();

      // check which cell mouse is over
      if (mouseX > x && mouseX < x + w &&
        mouseY > y && mouseY < y + h){
        overID = index;
      }

    }
  }
}

// if the first time clicking on sketch, select CA to enlarge
void mouseClicked(){
  if (iSFirstClick){
    calcCA(overID);
    iSFirstClick = false;
  }
}














