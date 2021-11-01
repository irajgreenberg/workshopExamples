// Requires import of Processing core classes 
// when .java suffix is added

import processing.core.*;

class Emitter {

  // add PApplet reference
  PApplet pApp;
  
  int partCount;
  PImage partImg;
  PVector partDimRange;
  PVector emitterPos;
  PVector emitterForce; // sets initial particle vector
  float emissionRate;

  //internals
  PVector[] dim;
  PVector[] pos;
  PVector[] spd;
  ImageParticle p;
  float partEmissionCount = 0.0f; // cast to float

  Emitter() {
  }
  
  Emitter(PApplet pApp, int partCount, PImage partImg, PVector partDimRange, PVector emitterPos, PVector emitterForce, float emissionRate) {
    this.pApp = pApp;
    this.partCount = partCount;
    this.partImg = partImg;
    this.partDimRange = partDimRange;
    this.emitterPos = emitterPos;
    this.emitterForce = emitterForce;
    this.emissionRate = emissionRate;

    //initialize and populate parallel arrays
    dim = new PVector[this.partCount];
    pos = new PVector[this.partCount];
    spd = new PVector[this.partCount];
    for (int i=0; i<this.partCount; i++) {
      float d = pApp.random(this.partDimRange.x, this.partDimRange.y);
      dim[i] = new PVector(d, d);
      pos[i] = new PVector(this.emitterPos.x, this.emitterPos.y);
      spd[i] = new PVector(pApp.random(-this.emitterForce.x, this.emitterForce.x), pApp.random(-this.emitterForce.y));
    }
    p = new ImageParticle(this.pApp, this.partImg);
  }

  void run() {
    for (float j=0; j<partEmissionCount; j+=this.emissionRate) {
      int i = (int)(j); // Java explicit conversion
      pApp.pushMatrix();
      pApp.translate(pos[i].x, pos[i].y);
      pApp.scale(dim[i].x, dim[i].y);
      pApp.rotate(pApp.atan2((float)(pos[i].y-this.emitterPos.y), (float)(pos[i].x-this.emitterPos.x)));
      p.create();
      pApp.popMatrix();
      spd[i].y += NatureandCode_step05_Java_mode.gravity; // gravity is static so requires class name
      pos[i].add(spd[i]);
    }
    // increments for loop sentinel value 
    // enabling independent emission rate
    if (partEmissionCount<this.partCount - this.emissionRate) {
      partEmissionCount += this.emissionRate;
    }
  }
}
