/**
 * Continuous Cellular Automata Main Tab - 02
 * By Ira Greenberg <br />
 * The Essential Guide to Processing for Flash Developers,
 * Friends of ED, 2009
 */

// global variables
int rows = 4, cols = 4;
int rowSpan, colSpan;
int cellScale = 1;
float threshMin = 128, threshMax = 255;
float constMin = 2, constMax = 127;
// for random seed placement
int seedCount = 1;

// declare arrays
CA_1DC[] cacs;
int[] seeds;
color[] clrs;

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
  seeds = new int[seedCount];
  clrs = new color[seedCount];

  for (int i=0; i<cacs.length; i++){
    cacs[i] = new CA_1DC(colSpan, rowSpan, cellScale);

    for (int j=0; j<seedCount; j++){
      seeds[j] = int((cacs[i].rows-1)*(cacs[i].cols) + int(random(cacs[i].cols)));
      clrs[j] = color(random(255), random(255), random(255));
    }
    cacs[i].setInitState(seeds, clrs);

    float t = random(threshMin, threshMax);
    cacs[i].setThresholds(new float[] { t, t, t });
    float c = random(constMin, constMax);
    cacs[i].setconsts(new float[] { c, c, c });
  }
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
    }
  }
}















