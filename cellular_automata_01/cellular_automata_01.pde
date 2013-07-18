/**
 * Cellular Automata Main Tab - 01
 * By Ira Greenberg <br />
 * The Essential Guide to Processing for Flash Developers,
 * Friends of ED, 2009
 */

CA_1D ca;

void setup(){
  size(600, 600);
  background(255);
  ca = new CA_1D(600, 600, 1);
}

void draw(){
  translate(ca.w/2, ca.h/2);
  ca.createGeneration();
}







