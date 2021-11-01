/**
 * Continuous Cellular Automata Main Tab - 01
 * By Ira Greenberg <br />
 * The Essential Guide to Processing for Flash Developers,
 * Friends of ED, 2009
 */

// global variables
CA_1DC cca;
void setup(){
  size(600, 600);
  cca = new CA_1DC(600, 600, 1);
}

void draw(){
  translate(cca.w/2, cca.h/2);
  cca.createGeneration();
} 

