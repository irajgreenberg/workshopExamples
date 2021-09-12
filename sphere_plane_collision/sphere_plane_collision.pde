Plane p;
Orb o;

void setup() {
  size(1024, 768, P3D);
  PVector[] vs = new PVector[4];
  vs[0] = new PVector(-300, -300, 100);
  vs[1] = new PVector(300, -300, 100);
  vs[2] = new PVector(300, 300, -100);
  vs[3] = new PVector(-300, 300, -100);
  p = new Plane(vs);
  
  o = new Orb(40, new PVector(400, -300, 300), new PVector(-3.9, 3.0, -3.3));
}

void draw() {
  background(255);
  translate(width/2, height/2, -100);
  rotateY(frameCount*PI/400);
  fill(187);
  
  // draw plane
  p.draw();
  
  // draw/move ball
  o.move();
  o.draw();
  
  //detect collision
  //Ax + By + Cz + D = 0
  PVector n = p.getNormal();
  n.x*o.x + n.y*o.y + n.z*o.z
}
