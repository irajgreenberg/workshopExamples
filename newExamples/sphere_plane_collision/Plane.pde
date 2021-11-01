class Plane {

  PVector[] vs;
  float normalLen = 150;

  Plane() {
  }

  Plane(PVector[] vs) {
    this.vs = vs;
  }

  PVector getNormal() {
    PVector s1 = PVector.sub(vs[1], vs[0]);
    PVector s2 = PVector.sub(vs[2], vs[0]);
    PVector n = s1.cross(s2);
    return n.normalize();
  }
  
  PVector getCentroid(){
    PVector c = PVector.add(vs[0], vs[1]);
    c.add(vs[2]);
    c.add(vs[3]);
    c.div(4);
    return c;
  }

  void draw() {
    // draw plane
    beginShape();
    for (int i=0; i< vs.length; i++) {
      vertex(vs[i].x, vs[i].y, vs[i].z);
    }
    endShape(CLOSE);
    
    // draw normal
    line(getCentroid().x, getCentroid().y, getCentroid().z,
    getCentroid().x + getNormal().x*normalLen, 
    getCentroid().y + getNormal().y*normalLen, 
    getCentroid().z + getNormal().z*normalLen);
  }
}
