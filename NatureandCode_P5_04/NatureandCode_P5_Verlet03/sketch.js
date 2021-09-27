// Ira Greenberg
// Nature & Code
// Center of Creative Computation | SMU
// Fall, 2021

// Description:
// Creating a Verlet form

let bounds; // vector
// central triangle
let node1;
let node2;
let node3;
let stick1;
let stick2;
let stick3;

// triangle arms
let nodeArm1;
let nodeArm2;
let nodeArm3;
let stickArm1;
let stickArm2;
let stickArm3;

function setup() {
    createCanvas(600, 600);
    bounds = createVector(400, 400);
    
    // for central triangle
    node1 = new VerletNode(new p5.Vector(0, 0,), 10, '#888899');
    node2 = new VerletNode(new p5.Vector(100, 0,), 10, '#888899');
    node3 = new VerletNode(new p5.Vector(150, -100,), 10, '#888899');
    
    stick1 = new VerletStick(node1, node2, .0003, 0, '#ff6622');
    stick2 = new VerletStick(node2, node3, .003, 0, '#22bb11');
    stick3 = new VerletStick(node3, node1, .0008, 0, '#aa22bb');

    // for triangle arms
    nodeArm1 = new VerletNode(new p5.Vector(-200, -200,), 4, '#000000');
    nodeArm2 = new VerletNode(new p5.Vector(300, 0,), 4, '#000000');
    nodeArm3 = new VerletNode(new p5.Vector(150, -300,), 4, '#000000');
    
    stickArm1 = new VerletStick(node1, nodeArm1, .7, 0, '#0000ff');
    stickArm2 = new VerletStick(node2, nodeArm2, .7, 0, '#0000ff');
    stickArm3 = new VerletStick(node3, nodeArm3, .7, 0, '#0000ff');

    // begin motion
    stick1.nudge(1, new p5.Vector(random(-42, 42), random(-42, 42)));
    stick2.nudge(1, new p5.Vector(random(-142, 142), random(-142, 142)));
}

function draw() {
    background(255);
    translate(width / 2, height / 2);
    drawBounds();
    
    stick1.verlet();
    stick1.draw();
    stick1.boundsCollide(bounds);

    stick2.verlet();
    stick2.draw();
    stick2.boundsCollide(bounds);

    stick3.verlet();
    stick3.draw();
    stick3.boundsCollide(bounds);

    //arms
    stickArm1.verlet();
    stickArm1.draw();
    stickArm1.boundsCollide(bounds);

    stickArm2.verlet();
    stickArm2.draw();
    stickArm2.boundsCollide(bounds);

    stickArm3.verlet();
    stickArm3.draw();
    stickArm3.boundsCollide(bounds);
}

function drawBounds() {
    noFill();
    stroke(0);
    rect(-bounds.x / 2, -bounds.y / 2, bounds.x, bounds.y);
}