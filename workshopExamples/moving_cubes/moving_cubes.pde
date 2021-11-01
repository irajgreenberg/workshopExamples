Cube c;
void setup() {
  size(800, 800, P3D);
  fill(195);
  noStroke();
  c = new Cube(new PVector(width/2, height/2, 0), new Dimension(200, 200, 200));
}

void draw(){
  background(0);
  lights();
  c.display();
}

