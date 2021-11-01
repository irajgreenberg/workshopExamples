Plane p;
int orbCount = 100;
Orb[] os = new Orb[orbCount];
//PVector s0, s1, s2, s3;

void setup() {
  size(800, 600, P3D);
  PVector[] vs = new PVector[4];
  vs[0] = new PVector(-30, -30, 10);
  vs[1] = new PVector(30, -30, 10);
  vs[2] = new PVector(30, 30, -10);
  vs[3] = new PVector(-30, 30, -10);
  p = new Plane(vs);

  for (int i=0; i<orbCount; i++) {
    os[i] = new Orb(10, new PVector(random(350, 450), random(-350, -275), random(280, 330)),
      new PVector(random(-4.2, -3.1), random(2.5, 3.2), random(-3.9, -3.0)));
  }

  /*
  vs[0]****************vs[1]
   *                    *
   *                    *
   *        pt          *  or p
   *                    *
   *                    *
   vs[3]****************vs[2]
   */
  //s0 = PVector.sub(p.vs[1], p.vs[0]);
  //s1 = PVector.sub(p.vs[2], p.vs[1]);
  //s2 = PVector.sub(p.vs[2], p.vs[3]);
  //s3 = PVector.sub(p.vs[3], p.vs[0]);
}

void draw() {
  background(255);
  translate(width/2, height/2, -100);
  //rotateY(PI/2);
  fill(187);

  // draw plane
  p.draw();
  PVector n = p.getNormal();
  // draw/move ball
  for (int i=0; i<orbCount; i++) {
    os[i].move();
    os[i].draw();

    // collision with infinitie plane
    //Ax + By + Cz + D = 0
    // check if point lies on infinite plane
    if (n.x*os[i].pos.x + n.y*os[i].pos.y + n.z*os[i].pos.z + -os[i].r < 0) {
      os[i].spd.mult(-1);
    }


    float t0 = getArea(p.vs[0], p.vs[1], os[i].pos);
    float t1 = getArea(p.vs[1], p.vs[2], os[i].pos);
    float t2 = getArea(p.vs[2], p.vs[3], os[i].pos);
    float t3 = getArea(p.vs[3], p.vs[0], os[i].pos);


    // point contained in quad if sum of 4 triangles
    // < area of the quad

    // edges with pt and quad verts
    //PVector d0 = PVector.sub(os[i].pos, p.vs[0]);
    //PVector d1 = PVector.sub(os[i].pos, p.vs[1]);
    //PVector d2 = PVector.sub(os[i].pos, p.vs[2]);
    //PVector d3 = PVector.sub(os[i].pos, p.vs[3]);
  }
}

float getArea(PVector a, PVector b, PVector c) {
  PVector s0 = PVector.sub(b, a).normalize();
  PVector s1 = PVector.sub(c, a).normalize();
  
  return s0.cross(s1).mult.5);
}
