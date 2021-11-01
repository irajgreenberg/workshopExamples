class Emitter {

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
  float partEmissionCount = 0.0;

  Emitter() {
  }

  Emitter(int partCount, PImage partImg, PVector partDimRange, PVector emitterPos, PVector emitterForce, float emissionRate) {
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
      float d = random(this.partDimRange.x, this.partDimRange.y);
      dim[i] = new PVector(d, d);
      pos[i] = new PVector(this.emitterPos.x, this.emitterPos.y);
      spd[i] = new PVector(random(-this.emitterForce.x, this.emitterForce.x), random(-this.emitterForce.y));
    }
    p = new ImageParticle(this.partImg);
  }

  void run() {
    for (float j=0; j<partEmissionCount; j+=this.emissionRate) {
      int i = int(j);
      pushMatrix();
      translate(pos[i].x, pos[i].y);
      scale(dim[i].x, dim[i].y);
      rotate(atan2(pos[i].y-this.emitterPos.y, pos[i].x-this.emitterPos.x));
      p.create();
      popMatrix();
      spd[i].y += gravity;
      pos[i].add(spd[i]);
    }
    // increments for loop sentinel value 
    // enabling independent emission rate
    if (partEmissionCount<this.partCount - this.emissionRate) {
      partEmissionCount += this.emissionRate;
    }
  }
}
