class VerletStick {

  VerletBall b1, b2;
  float stiffness;

  PVector vecOrig;
  float len;

  int renderingKey;
  final static int  BODY = 0;
  final static int  SKELETON = 1;
  final static int  ARMATURE = 2;

  VerletStick() {
  }

  VerletStick(VerletBall b1, VerletBall b2, float stiffness) {
    this.b1 = b1;
    this.b2 = b2;
    this.stiffness = stiffness;
    vecOrig  = new PVector(b2.pos.x-b1.pos.x, b2.pos.y-b1.pos.y);
    len = dist(b1.pos.x, b1.pos.y, b2.pos.x, b2.pos.y);
  }

  VerletStick(VerletBall b1, VerletBall b2, float stiffness, int renderingKey) {
    this.b1 = b1;
    this.b2 = b2;
    this.stiffness = stiffness;
    this.renderingKey = renderingKey;
    vecOrig  = new PVector(b2.pos.x-b1.pos.x, b2.pos.y-b1.pos.y);
    len = dist(b1.pos.x, b1.pos.y, b2.pos.x, b2.pos.y);
  }
  
   // constrainVal needs to be changed for anchors

  void render() {
    beginShape();
    vertex(b1.pos.x, b1.pos.y);
    vertex(b2.pos.x, b2.pos.y);
    endShape();
  }

  void constrainLen() {
    for (int i=0; i<60; i++) {
      PVector delta = new PVector(b2.pos.x-b1.pos.x, b2.pos.y-b1.pos.y);
      float deltaLength = delta.mag();
      float difference = ((deltaLength - len) / deltaLength);
      b1.pos.x += delta.x * (0.5f * stiffness * difference);
      b1.pos.y += delta.y * (0.5f * stiffness * difference);
      b2.pos.x -= delta.x * (0.5f * stiffness * difference);
      b2.pos.y -= delta.y * (0.5f * stiffness * difference);
    }
  }
  
  void constrainLenCustom(float constraintB1, float constraintB2) {
    for (int i=0; i<10; i++) {
      PVector delta = new PVector(b2.pos.x-b1.pos.x, b2.pos.y-b1.pos.y);
      float deltaLength = delta.mag();
      float difference = ((deltaLength - len) / deltaLength);
      b1.pos.x += delta.x * (constraintB1 * stiffness * difference);
      b1.pos.y += delta.y * (constraintB1 * stiffness * difference);
      b2.pos.x -= delta.x * (constraintB2 * stiffness * difference);
      b2.pos.y -= delta.y * (constraintB2 * stiffness * difference);
    }
  }
}

