/**
 * Cellular Automata 2D Parser – main tab
 * By Ira Greenberg <br />
 * The Essential Guide to Processing for Flash Developers,
 * Friends of ED, 2009
 */

LIF_Parser lp;
String url = "http://www.radicaleye.com/lifepage/patterns/breedst.lif";
CA_2D ca2;

void setup(){
  size(800, 600);
  background(255);
  ca2 = new CA_2D(width, height, 1);
  ca2.setOnColor(0xffff9900);
  ca2.setOffColor(0xff112233);
  lp = new LIF_Parser(url);
  ca2.setPattern(lp);
}

void draw(){
  translate(ca2.w/2, ca2.h/2);
  ca2.createGeneration();
}



