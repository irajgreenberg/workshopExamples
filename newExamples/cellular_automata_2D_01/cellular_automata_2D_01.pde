/**
 * Cellular Automata 2D _ main tab – 01
 * By Ira Greenberg <br />
 * The Essential Guide to Processing for Flash Developers,
 * Friends of ED, 2009
 */

CA_2D ca2;

void setup(){
  size(600, 600);
  background(255);
  ca2 = new CA_2D(600, 600, 1);
}

void draw(){
  translate(ca2.w/2, ca2.h/2);
  ca2.createGeneration();
  if (frameCount == 1000)
   noLoop();
}
