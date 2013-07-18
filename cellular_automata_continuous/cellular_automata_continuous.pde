/**
 * Continuous Cellular Automata Main Tab - 01
 * By Ira Greenberg <br />
 * The Essential Guide to Processing for Flash Developers,
 * Friends of ED, 2009
 */

int rows = 3, cols = 3;
int rowSpan, colSpan;
CA_1DC[] cacs = new CA_1DC[rows*cols];
float threshMin = 95, threshMax = 175;
float constMin = 1, constMax = 190;

int seedCount = 3;
int[] seeds = new int[seedCount];
color[] clrs = new color[seedCount];

void setup(){
  size(800, 800);
  rowSpan = height/rows;
  colSpan = width/cols;
  background(127);
  noStroke();
  for (int i=0; i<cacs.length; i++){
    cacs[i] = new CA_1DC(colSpan, rowSpan, 1);
    for (int j=0; j<seeds.length; j++){
      seeds[j] = int((cacs[i].rows-1)*(cacs[i].cols) + int(random(cacs[i].cols)));
      clrs[j] = color(random(255), random(255), random(255));
    }
    cacs[i].setInitState(seeds, clrs);
    float t1 = random(threshMin, threshMax);
    float t2 = random(threshMin, threshMax);
    float t3 = random(threshMin, threshMax);
    cacs[i].setThresholds( new float[] {t1, t2, t3});
    float c1 = random(constMin, constMax);
    float c2 = random(constMin, constMax);
    float c3 = random(constMin, constMax);
    cacs[i].setconsts( new float[] {c1, c2, c3});
  }
}

void draw(){
  for (int i=0; i<rows; i++){
    for (int j=0; j<cols; j++){
      pushMatrix();
      translate(cacs[cols*i + j].w/2, cacs[cols*i + j].h/2);
      translate(cacs[cols*i + j].w*j, cacs[cols*i + j].h*i);
      cacs[cols*i + j].createGeneration();
      popMatrix();
    }
  }
}




