// Lorenze System// chaotic system

// known inputs but not deterministic behavior
float a = 10, b = 28, c = 8/3; 
PVector p = new PVector(.1, 0, 0);
int lim = 10000;
float h = .01;

void setup() {
  size(800, 600, P3D);
  background(255);
  noFill();

  translate(width/2, height/2);
  scale(7, 7, 7);
  beginShape();
  // for (int i=0; i<lim; ++i) {


  /*
     dx/dt = delta * (y - x)
   dy/dt = r * x - y - x * z
   dz/dt = x * y - b * z
   */PVector temp = new PVector(1, 1, 1);
  for ( int i=0; i< lim; i++) {
    temp.x = p.x + h * a * (p.y - p.x);
    temp.y = p.y + h * (p.x*(b-p.z) - p.y);
    temp.z = p.z + h * (p.x * p.y - c * p.z);
    p = temp;
    vertex(p.x, p.y, p.z);
    println(p);
  }
  endShape();
}

/*void draw() {
 translate(width/2, height/2);
 beginShape();
 // for (int i=0; i<lim; ++i) {
 
// dx/dt = delta * (y - x)
// dy/dt = r * x - y - x * z
// dz/dt = x * y - b * z

p.x = a * (p.y - p.x);
p.y = c * p.x - p.y - p.x * p.z;
p.z = p.x * p.y - b * p.z;
vertex(p.x, p.y, p.z);

//}
endShape();
}*/
