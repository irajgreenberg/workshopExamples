class Orb {
  float r;
  PVector pos;
  PVector spd;
  Orb() {
  }
  
  Orb(float r, PVector pos, PVector spd) {
    this.r = r;
    this.pos = pos;
    this.spd = spd;
  }
  
  void move(){
    pos.add(spd);
  }
  
  void draw(){
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    sphere(r);
    popMatrix();
  }
}
