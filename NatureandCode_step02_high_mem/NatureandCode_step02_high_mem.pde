// Ira Greenberg
// Nature & Code
// Center of Creative Computation | SMU
// August 18, 2021

// Description:
// Simple particle system utilizing
// an image particle with
// orientation based on its
// movement vector.

// Note:
// Image should be pointing along
// positive x-axis for orientation.

// Step 02 - many particles in memory 
// (expensive and slow)


int PARTICLE_COUNT = 50; // constant
ImageParticle[] parts;
float gravity = .03; // global environmental variable

void setup() {
  size(1024, 768);

  // Creates PARTICLE_COUNT of ImageParticles in memory
  parts = new ImageParticle[PARTICLE_COUNT];

  // Initiate particle on upward trajectory.
  for (int i=0; i<parts.length; i++) {
    parts[i] = new ImageParticle(loadImage("arrow.png"), new PVector(random(5, 20), random(5, 20)),
      new PVector(width/2, height/2), new PVector(random(-4, 4), random(-5, -2)));
  }
}

void draw() {
  background(0);
  for (ImageParticle p : parts) {
    p.move();
    p.create();
  }
}
