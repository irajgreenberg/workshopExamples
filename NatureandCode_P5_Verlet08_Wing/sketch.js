// Ira Greenberg
// Nature & Code
// Center of Creative Computation | SMU
// Fall, 2021

// Description:
// Creating a Verlet organism
// based on a Verlet Wing

let bounds; // vector
let verletBox;

let verletHelix;

function setup() {
    createCanvas(600, 600, WEBGL);
    bounds = createVector(400, 400, 400);
    verletHelix = new VerletHelix(80, 30, 60, 12, .3, 3, 200, 2);
    verletHelix.setColor(color(165, 90, 10));
    verletHelix.nudge(-1, createVector(22.3, 22.5, 22.987));
}

function draw() {
    background(0);

    ambientLight(100);
    directionalLight(0, 0, 0, 0.25, 0.25, 0);
    pointLight(0, 0, 255, 0, 0, 100);
    //pointLight(0, 0, 255, mouseX, mouseY, 250);

    rotateX(frameCount * PI / 720);
    rotateY(frameCount * PI / 720);
    drawBounds();

    specularMaterial(100);
    shininess(20);
    verletHelix.verlet();
    verletHelix.draw(true, true, true);
    verletHelix.boundsCollide(bounds);
    verletHelix.setAreCrossSupportsVisible(false);
    verletHelix.nudge(-1, createVector(random(-5.2, 5.2), random(-7.2, 7.2), random(-7.2, 7.2)));
}

// NOTE: Needs to be a cube 
function drawBounds() {
    noFill();
    stroke(75, 75, 75, 10);
    box(bounds.x, bounds.y, bounds.z)
}