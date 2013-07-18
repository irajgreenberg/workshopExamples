/**
 * Continuous Cellular Automata Main Tab - 01
 * By Ira Greenberg <br />
 * The Essential Guide to Processing for Flash Developers,
 * Friends of ED, 2009
 */

CA_1DC[] cacs = new CA_1DC[16];
float threshMin = 75, threshMax = 175;
float constMin = 1, constMax = 130;

int seedCount = 1;
int[] seeds = new int[seedCount];
color[] cols = new color[seedCount];

void setup(){
  size(800, 800);
  background(127);
  noStroke();
  for (int i=0; i<cacs.length; i++){
    cacs[i] = new CA_1DC(200, 200, 1);
    for (int j=0; j<seeds.length; j++){
      seeds[j] = int((cacs[i].rows-1)*cacs[i].cols + int(random(cacs[i].cols)));
     cols[j] = color(random(255), random(255), random(255));
    }
    float t1 = random(threshMin, threshMax);
    float t2 = random(threshMin, threshMax);
    float t3 = random(threshMin, threshMax);
    float c1 = random(constMin, constMax);
    float c2 = random(constMin, constMax);
    float c3 = random(constMin, constMax);
    cacs[i].setThresholds( new float[] {t1, t2, t3});
    cacs[i].setconsts( new float[] {c1, c2, c3});
    cacs[i].setInitState(seeds, cols);
  }
}

void draw(){
  translate(cacs[0].w/2, cacs[0].h/2);
  int step = cacs.length/4;
  for (int i=0; i<step; i++){
    for (int j=0; j<step; j++){
      pushMatrix();
      translate(cacs[step*i + j].w*i, cacs[step*i + j].h*j);
      cacs[step*i + j].createGeneration();
      popMatrix();
    }
  }
}



