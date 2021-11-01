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

// Step 04 - Control particle emission rate


float gravity = .03; // global environmental variable
Emitter e;

void setup() {
  size(1024, 768, P2D);
  e = new Emitter(10000, loadImage("arrow.png"), new PVector(2, 12), new PVector(width/2, height/8), new PVector(.5, 2), 4);
}

void draw() {
  // fading background for some sizzzle
  fill(0, 60);
  rect(-1, -1, width+2, height+2);
  e.run();
}
