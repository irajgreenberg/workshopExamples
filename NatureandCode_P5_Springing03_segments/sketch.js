// Ira Greenberg
// Nature & Code
// Center of Creative Computation | SMU
// September 13, 2021

// Description:
// P5_Springing03_Segments
// OOP version with segments of 
// springing using a follow the 
// leader approach with
// controllable easing.

let bounds; // vector
let leader; //Vector
let followers = []; //Vector
let segmentCount = 70;
let dude; // SpringyDude

function setup() {
    createCanvas(600, 600);
    bounds = createVector(400, 400);

    leader = new Bot(5, color(15, 180, 255, 100), createVector(0, 0),
        createVector(random(-1.5, 1.5), random(-1.5, 1.5)));

    let segmentReducer = 4.9 / segmentCount; // create wormlike body
    for (let i = 0; i < segmentCount; i++) {
        followers[i] = new Bot(5 - segmentReducer * i, color(15, 170, 255, 50), createVector(0, 0),
            createVector(0, 0));
    }

    dude = new SpringyDude(leader, followers, .16, .5, .099);
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