/**
 * Cellular Automata 2D _ main tab – 02
 * By Ira Greenberg <br />
 * The Essential Guide to Processing for Flash Developers,
 * Friends of ED, 2009
 */

CA_2D ca2;

void setup(){
  size(600, 600);
  background(255);
  ca2 = new CA_2D(600, 600, 20);
  translate(ca2.w/2, ca2.h/2);
  ca2.paint();
}

void draw(){
}

void mousePressed(){
  translate(ca2.w/2, ca2.h/2);
  ca2.createGeneration();
}

