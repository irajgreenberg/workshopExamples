class Polygon {
  //fields
  PVector pos;
  int sides;
  float radius;
  color fillCol;
  PVector[] vecs;
  
  PVector spd;
  float gravity, damping, friction;

  //cstrs
  Polygon() {
  }

  Polygon(PVector pos, int sides, float radius, color fillCol) {
    this.pos = pos;
    this.sides = sides;
    this.radius = radius;
    this.fillCol = fillCol;
    vecs = new PVector[sides];
    _init();
  }

  void _init() {
    float theta = 0;
    for (int i=0; i<sides; ++i) {
      vecs[i] = new PVector(cos(theta)*radius, sin(theta)*radius);
      theta += TWO_PI/sides;
    }
  }

  void setDynamics(PVector spd, float gravity, float damping, float friction){
    this.spd = spd;
    this.gravity = gravity;
    this.damping = damping;
    this.friction = friction;
  }
  
  void move() {
    spd.y += gravity;
    pos.add(spd);
    
    if(pos.x > width-radius){
      pos.x = width-radius;
      spd.x *= -1;
    } else if (pos.x < radius){
      pos.x = radius;
      spd.x *=-1;
    }
    
    if(pos.y > height-radius){
      pos.y = height-radius;
      spd.y *= -1;
      
      // impose damping/friction
      spd.y *= damping;
      spd.x *= friction;
      
    } else if (pos.y < radius){
      pos.y = radius;
      spd.y *=-1;
    }
  }

  void display() {
    fill(fillCol);
    pushMatrix();
    translate(pos.x, pos.y);
    beginShape();
    {
      for (int i=0; i<vecs.length; ++i) {
        vertex(vecs[i].x, vecs[i].y);
      }
    }
    endShape(CLOSE);
    popMatrix();
  }
}

