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
// Image removed due to P2D incompatibility
// with newer versions of Java (16). Arrow
// drawn with vertex() calls

// Step 07 - P5.js



const gravity = .03; // global environmental variable
let emitter;

function setup() {
  createCanvas(1024, 768);
  emitter = new Emitter(10000, createVector(2, 12), 
      createVector(width / 2, height / 8), createVector(.5, 2), 4);
}

function draw() {
    // fading background for some sizzzle
    fill(255, 0, 100, 165);
    rect(-1, -1, width + 2, height + 2);
    emitter.run();
}
   