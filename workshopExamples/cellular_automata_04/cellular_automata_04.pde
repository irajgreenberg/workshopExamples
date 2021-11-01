/**
 * Cellular Automata Main Tab - 04
 * By Ira Greenberg <br />
 * The Essential Guide to Processing for Flash Developers,
 * Friends of ED, 2009
 */

CA_1D[] cas = new CA_1D[16];
boolean[] rules = new boolean[8];
color onC = 0xff000000;
color offC = 0xff111111;

void setup(){
  size(800, 800);
  background(255);
  for (int i=0; i<cas.length; i++){
    cas[i] = new CA_1D(200, 200, 1);
    // calculate random rules
    for (int j=0; j<8; j++){
      rules[j] = boolean(round(random(1)));
    }
    cas[i].setRules(rules);
  }
}

void draw(){
  translate(cas[0].w/2, cas[0].h/2);
  int step = cas.length/4;
  for (int i=0; i<step; i++){
    for (int j=0; j<step; j++){
      pushMatrix();
      translate(cas[step*i + j].w*i, cas[step*i + j].h*j);
      cas[step*i + j].createGeneration();
      popMatrix();
    }
  }
}










