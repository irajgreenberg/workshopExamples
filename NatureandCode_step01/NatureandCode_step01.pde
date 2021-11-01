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

// Step 01 - single particle

ImageParticle p;
float gravity = .3; // global environmental variable

void setup(){
  size(1024, 768);
  // Initiate particle on upward trajectory.
  p = new ImageParticle(loadImage("arrow.png"), new PVector(30, 30), new PVector(width/2, height/2), new PVector(1.21, -15));
}

void draw(){
  background(0);
  p.move();
  p.create();
}
