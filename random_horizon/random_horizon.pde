// pseudo random noise example
float detail = 200.0;

void setup() {
  size(1800, 200);
  background(0);
  noFill();
  stroke(255);
  float xStep = width/(detail);
  float y = height/3;
  float x = 0;

  beginShape();
  for (int i=0; i<=detail; i++) {
    x = i*xStep;
    vertex(x, y - random(20));
  }
  endShape();
}

