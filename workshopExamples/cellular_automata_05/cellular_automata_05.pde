/**
 * Cellular Automata Main Tab - 05
 * By Ira Greenberg <br />
 * The Essential Guide to Processing for Flash Developers,
 * Friends of ED, 2009
 */

CA_1D[] cas = new CA_1D[16];
boolean[] rules = new boolean[8];
// for random rotation
float[] rots = new float[cas.length];

void setup(){
  size(800, 800);
  background(255);
  for (int i=0; i<cas.length; i++){
    cas[i] = new CA_1D(200, 200, round(random(1, 20)));
    // calculate random rules
    for (int j=0; j<8; j++){
      rules[j] = boolean(round(random(1)));
    }
    cas[i].setRules(rules);
    // calculate random color
    cas[i].setOnColor(color(random(255), random(255), random(255)));
    cas[i].setOffColor(color(random(255), random(255), random(255)));
    // calculate random rotation
    rots[i] = HALF_PI*round(random(1, 3));
  }
}

void draw(){
  translate(cas[0].w/2, cas[0].h/2);
  int step = cas.length/4;
  for (int i=0; i<step; i++){
    for (int j=0; j<step; j++){
      pushMatrix();
      translate(cas[step*i + j].w*i, cas[step*i + j].h*j);
      rotate(rots[i]);
      cas[step*i + j].createGeneration();
      popMatrix();
    }
  }
}



