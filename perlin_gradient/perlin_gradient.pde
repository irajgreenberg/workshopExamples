// perlin gradient

color[] colors = { 
  color(255, 127, 20), color(20, 100, 200)
};
float dimW, dimH;
int rows, cols;
float seed;

void setup() {
  size(400, 400);
  dimW = 400;
  dimH = 400;
  rows = 200;
  cols = 200;
  seed = .065;
  noStroke();
  randomGradient(dimW, dimH, rows, cols, colors, seed);
}



void randomGradient(float dimW, float dimH, int rows, int cols, color[] colors, float seed) {
  PImage p = createImage(int(dimW), int(dimH), RGB);
  float colSpan = dimW/cols;
  float rowSpan = dimH/rows;
  float srcR, srcG, srcB, 
  dstR, dstG, dstB;
  float deltaR, deltaG, deltaB;
  int steps = rows*cols;

  srcR = red(colors[0]);
  srcG = green(colors[0]);
  srcB = blue(colors[0]);

  dstR = red(colors[1]);
  dstG = green(colors[1]);
  dstB = blue(colors[1]);

  deltaR = (dstR-srcR)/steps;
  deltaG = (dstG-srcG)/steps;
  deltaB = (dstB-srcB)/steps;

  //p.loadPixels();
  for (int i=0, k=0, l = 0; i<cols; i++) {
    for (int j=0; j<rows; j++) {

      //p.pixels[k] = 
      //float n = random(10);
      float n = noise(l)*120;
      fill(color(srcR + deltaR*k+n, srcG + deltaG*k+n, srcB + deltaB*k+n));
      rect(colSpan*j, rowSpan*i, colSpan, rowSpan);
      k++;
      l+=60.595;
    }
  }
  //p.updatePixels();
  
  //image(p, 0, 0);
}

