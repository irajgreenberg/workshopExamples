// Ira Greenberg
// Nature & Code
// Center of Creative Computation | SMU
// Fall, 2021

// Description:
// Creating a Verlet organism
// based on a Verlet Cube

let bounds; // vector-+++++++++++
let box;

function setup() {
    createCanvas(600, 600, WEBGL);
    bounds = createVector(400, 400, 400);
    box = new VerletBox(createVector(0, 0, 0), 100, .004, color(200, 100, 20));
    box.nudge(1, createVector(1.01, 1.02, 1.03));
}

function draw() {
    background(255);
    drawBounds();

    rotateX(frameCount*PI/180);
    rotateY(frameCount*PI/180);
    box.verlet();
    box.draw();
    box.boundsCollide(bounds);
}

// NOTE: Needs to be a cube 
function drawBounds() {
    noFill();
    stroke(0);
    rect(-bounds.x / 2, -bounds.y / 2, bounds.x, bounds.y);
}