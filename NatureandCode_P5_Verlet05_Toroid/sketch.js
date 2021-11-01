// Ira Greenberg
// Nature & Code
// Center of Creative Computation | SMU
// Fall, 2021

// Description:
// Creating a Verlet organism
// based on a Verlet Toroid

let bounds; // vector
let verletBox;

let verletToroid;

function setup() {
    createCanvas(600, 600, WEBGL);
    bounds = createVector(300, 300, 300);
    verletToroid = new VerletToroid(100, 40, 30, 30, .3, 5);
    //color(200, 125, 255)
    verletToroid.nudge(-1, createVector(22.3, 22.5, 22.987));
}

function draw() {
    background(200);

    ambientLight(255);
    directionalLight(255, 0, 0, 0.25, 0.25, 0);
    pointLight(0, 0, 255, mouseX, mouseY, 250);

    rotateX(frameCount * PI / 720);
    rotateY(frameCount * PI / 720);
    drawBounds();

    specularMaterial(250);

    verletToroid.verlet();
    verletToroid.draw(true, true, true);
    verletToroid.boundsCollide(bounds);

    verletToroid.nudge(-1, createVector(random(-5.2, 5.2), random(-7.2, 7.2), random(-7.2, 7.2)));
}

// NOTE: Needs to be a cube 
function drawBounds() {
    noFill();
    stroke(155, 75, 55, 5);
    box(bounds.x, bounds.y, bounds.z)
}