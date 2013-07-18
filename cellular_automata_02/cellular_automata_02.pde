/**
 * Cellular Automata Main Tab - 02
 * By Ira Greenberg <br />
 * The Essential Guide to Processing for Flash Developers,
 * Friends of ED, 2009
 */

CA_1D ca;
color onC = 0xff22ee33;
color offC = 0xff772299;

void setup(){
  size(600, 600);
  background(255);
  ca = new CA_1D(600, 600, 9);
  ca.setOnColor(onC);
  ca.setOffColor(offC);
}

void draw(){
  translate(ca.w/2, ca.h/2);
  ca.createGeneration();
}







