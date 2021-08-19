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

// Step 03 - Many instances, only 1 
// particle in memory (cheap and fast)


float gravity = .03; // global environmental variable
Emitter e;

void setup() {
  size(1024, 768, P2D);
  e = new Emitter(100, loadImage("arrow.png"), new PVector(3, 12), new PVector(width/2, height/2), new PVector(4, 5));
}

void draw() {
  background(0);
  e.run();
}
