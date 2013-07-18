/**
 * Cellular Automata Main Tab - 03
 * By Ira Greenberg <br />
 * The Essential Guide to Processing for Flash Developers,
 * Friends of ED, 2009
 */

CA_1D ca;
color onC = 0xff221166;
color offC = 0xffffff00;

void setup(){
  size(600, 600);
  background(255);
  ca = new CA_1D(600, 600, 12);
  ca.setOnColor(onC);
  ca.setOffColor(offC);

  //add multiple starting states
  int seedCount = 50;
  int[] cells = new int[seedCount];
  for (int i=0; i<seedCount; i++){
    cells[i] = int((ca.rows-1) * (ca.cols) + random(ca.cols));
  }
  ca.setInitState(cells);
}

void draw(){
  translate(ca.w/2, ca.h/2);
  ca.createGeneration();
}








