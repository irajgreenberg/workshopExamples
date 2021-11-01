class Emitter {

  int partCount;
  PImage partImg;
  PVector partDimRange;
  PVector emitterPos;
  PVector emitterForce; // sets initial particle vector

  //internals
  PVector[] dim;
  PVector[] pos;
  PVector[] spd;
  ImageParticle p;

  Emitter() {
  }

  Emitter(int partCount, PImage partImg, PVector partDimRange, PVector emitterPos, PVector emitterForce) {
    this.partCount = partCount;
    this.partImg = partImg;
    this.partDimRange = partDimRange;
    this.emitterPos = emitterPos;
    this.emitterForce = emitterForce;

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
    for (int i=0; i<this.partCount; i++) {
      pushMatrix();
      translate(pos[i].x, pos[i].y);
      scale(dim[i].x, dim[i].y);
      rotate(atan2(pos[i].y-height/2, pos[i].x-width/2));
      p.create();
      popMatrix();
      spd[i].y += gravity;
      pos[i].add(spd[i]);
    }
  }
}
