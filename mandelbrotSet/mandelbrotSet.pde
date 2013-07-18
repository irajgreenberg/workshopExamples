// plotting the Mandalbrot Set (M-Set)
// z = z^2 + c;

PImage p;
ComplexNum c, z;
float realMin = -1.15, realMax = 1.15; // x-axis
float imagMin = -1.15, imagMax = 1.15; // y-axis
int iterationLim = 50; // lower for cool visuals //<>//
float shiftX, shiftY; // shift set center point in window

void setup() {
  size(1000, 1000);
  background(255);
  p = createImage(width, height, RGB);
  p.loadPixels();
  c = new ComplexNum(0, 0);
  z = new ComplexNum(0, 0); //<>//
  ComplexNum zz = new ComplexNum();
  shiftX = width/1.4;
  shiftY = height/2;

  // scale Set to window
  float xFactor = (realMax-realMin)/width; //<>//
  float yFactor = (imagMax-imagMin)/height;

  float x, y;
  for (int i=0, ii=0; i<width; ++i) {
    // scale and shift M-Set to screen pixels 
    x = (i-shiftX)*xFactor;
    for (int j=0; j<height; ++j) {
     // scale and shift M-Set to screen pixels 
      y = (j-shiftY)*yFactor;
       //<>//
      // default pixel color of M-Set
      p.pixels[ii] = color(100, 165, 160);
      
      // Mandelbrot search algorithm
      c.setReal(x);
      c.setImag(y);
      z.setReal(0);
      z.setImag(0);
      for (int k=0; k<iterationLim; ++k) {
        zz.set(z);
        zz.mult(z);
        zz.add(c);
        // if heading to infinity, colorize
        if (zz.getReal()*zz.getReal()+zz.getImag()*zz.getImag() > 2) {
          p.pixels[ii] = color(min(k*14, 255), 130, 120);
        } 
        z.set(zz);
      }
      ++ii;
    }
  }
  p.updatePixels();
  image(p, 0, 0);
}
