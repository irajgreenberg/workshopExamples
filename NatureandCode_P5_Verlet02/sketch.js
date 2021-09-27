// Ira Greenberg
// Nature & Code
// Center of Creative Computation | SMU
// Fall, 2021

// Description:
// Creating a Verlet Stick

let bounds; // vector
let node1;
let node2;
let stick;

function setup() {
    createCanvas(600, 600);
    bounds = createVector(400, 400);
    node1 = new VerletNode(new p5.Vector(0, 0,), 6);
    node2 = new VerletNode(new p5.Vector(100, 0,), 6);
    stick = new VerletStick(node1, node2, .05, 0, '#6644ff');
    stick.nudge(1, new p5.Vector(random(-12, 12), random(-12, 12)));
}

function draw() {
    background(255);
    translate(width / 2, height / 2);
    drawBounds();
    
    stick.verlet();
    stick.draw();
    stick.boundsCollide(bounds);
}

function drawBounds() {
    noFill();
    stroke(0);
    rect(-bounds.x / 2, -bounds.y / 2, bounds.x, bounds.y);
}