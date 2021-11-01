class Emitter {

  // let partCount;
  // let partDimRange; //P5.Vector
  // let emitterPos; //P5.Vector
  // let emitterForce; //P5.Vector
  // let emissionRate;

  //internals
  // P5.Vector arrays
  dim = [];
  pos = [];
  spd = []

  //ArrowParticle 
  ap;
  partEmissionCount = 0.0; // cast to float

  constructor(partCount, partDimRange, emitterPos,
    emitterForce, emissionRate) {
    this.partCount = partCount;
    this.partDimRange = partDimRange;
    this.emitterPos = emitterPos;
    this.emitterForce = emitterForce;
    this.emissionRate = emissionRate;

    // //initialize and populate parallel arrays
    // dim = new PVector[this.partCount];
    // pos = new PVector[this.partCount];
    // spd = new PVector[this.partCount];
    // note: arrays in JavaScript are dynamiclaly filled
    // no need to pre allocate memory
    for (let i = 0; i < this.partCount; i++) {
      let d = random(this.partDimRange.x, this.partDimRange.y);
      this.dim[i] = createVector(d, d);
      this.pos[i] = createVector(this.emitterPos.x, this.emitterPos.y);
      this.spd[i] = createVector(random(-this.emitterForce.x,
        this.emitterForce.x),
        random(-this.emitterForce.y));
    }
    this.ap = new ArrowParticle();
  }

  run() {
    // let v = createVector(0, 0);
    // print(v.x);
    for (let j=0; j<this.partEmissionCount; j+=this.emissionRate) {
      let i = parseInt(j); // explicit conversion
      push();
      translate(this.pos[i].x, this.pos[i].y);
      scale(this.dim[i].x, this.dim[i].y);
      rotate(atan2(this.pos[i].y-this.emitterPos.y, this.pos[i].x-this.emitterPos.x));
      this.ap.create();
      pop();
      this.spd[i].y += gravity; // gravity is global, for better or worse
      this.pos[i].add(this.spd[i]);
    }
    // increments for loop sentinel value 
    // enabling independent emission rate
    if (this.partEmissionCount<this.partCount - this.emissionRate) {
      this.partEmissionCount += this.emissionRate;
    }
  }
}
