// Ira Greenberg
// Nature & Code
// Center of Creative Computation | SMU
// September 13, 2021

// Description:
// P5_Verlet
// Moving an orb

let bounds; // vector
var orb;


function setup() {
    createCanvas(600, 600);
    bounds = createVector(400, 400);
    orb = new VerletNode(new p5.Vector(0, 0,), 50);
    orb.nudge(new p5.Vector(random(12, 14), random(12, 14)));
}

function draw() {
    background(255);
    translate(width / 2, height / 2);
    drawBounds();
    orb.verlet();
    orb.display();
    orb.boundsCollide(bounds);

}

function drawBounds() {
    noFill();
    stroke(0);
    rect(-bounds.x / 2, -bounds.y / 2, bounds.x, bounds.y);
}