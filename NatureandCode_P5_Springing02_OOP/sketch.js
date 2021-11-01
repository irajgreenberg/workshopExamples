// Ira Greenberg
// Nature & Code
// Center of Creative Computation | SMU
// September 13, 2021

// Description:
// P5_Springing02_OOP
// OOP version of springing
// using a follow the 
// leader approach with
// controllable easing.

let bounds; // vector
let leader; //Vector
let follower; //Vector
let dude; // SpringyDude

function setup() {
    createCanvas(600, 600);
    bounds = createVector(400, 400);

    leader = new Bot(15, color(200, 100, 0), createVector(0, 0),
        createVector(random(-1.5, 1.5), random(-1.5, 1.5)));

    follower = new Bot(8, color(15, 170, 255), createVector(0, 0),
        createVector(0, 0));

    dude = new SpringyDude(leader, follower, .003, .9, .75);
}

function draw() {
    background(255);
    translate(width / 2, height / 2);
    drawBounds();

    dude.slither();
    dude.checkBoundsCollision(bounds);
}

function drawBounds() {
    noFill();
    stroke(0);
    rect(-bounds.x / 2, -bounds.y / 2, bounds.x, bounds.y);
}