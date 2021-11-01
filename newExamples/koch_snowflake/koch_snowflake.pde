// Koch Snowflake
int counter = 0;
ArrayList<PVector> verts = new ArrayList<PVector>();
float radius = 225;
//<>//
void setup() {
  size(600, 600);
  background(255);
  noFill();
  float theta = 0;
  
  // initial verts
  for (int i=0; i<3; ++i) {
    verts.add(new PVector(cos(theta)*radius, sin(theta)*radius));
    theta += TWO_PI/3;
  }

  translate(width/2, height/2);
  subdivide(4);
  display();
}

void display() {
  beginShape();
  for (int i=0; i<verts.size(); ++i) {
    vertex(verts.get(i).x, verts.get(i).y);
  }
  endShape(CLOSE);
}
