// Perlin noise example
float detail = 200.0;
float noiseFactor = .065;
float noiseSpace = 0;
int octaves = 19;
float fallOff = .59;


void setup() {
  size(1800, 200);
  background(0);
  noFill();
  stroke(255);
  float xStep = width/(detail);
  float y = 0;
  float x = 0;
  noiseDetail(octaves, fallOff);
  beginShape();
  for (int i=0; i<=detail; i++) {
    x = i*xStep;
    noiseSpace += .065;
    y = noise(noiseSpace)*height/2;
    vertex(x, y);
  }
  endShape();
}

