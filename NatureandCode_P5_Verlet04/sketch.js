// Ira Greenberg
// Nature & Code
// Center of Creative Computation | SMU
// Fall, 2021

// Description:
// Creating a Verlet organism
// based on a Verlet Cube

let bounds; // vector-+++++++++++
let verletBox;

function setup() {
    createCanvas(600, 600, WEBGL);
    bounds = createVector(300, 300, 300);
    verletBox = new VerletBox(createVector(0, 0, 0), 80, .001, color(100, 155, 25));
    verletBox.nudge(1, createVector(10.01, 25.02, 30.03));
    verletBox.setStyles(3, color(200, 20, 20), color(20, 20, 200));
}

function draw() {
    background(0);

    ambientLight(255);
    directionalLight(255, 0, 0, 0.25, 0.25, 0);
    pointLight(0, 0, 255, mouseX, mouseY, 250);

    rotateX(frameCount*PI/720);
    rotateY(frameCount*PI/720);
    drawBounds();
    
   // specularMaterial(250);
    verletBox.verlet();
    verletBox.draw();
    verletBox.boundsCollide(bounds);
}

// NOTE: Needs to be a cube 
function drawBounds() {
    noFill();
    stroke(155, 75, 55, 5);
    box(bounds.x, bounds.y, bounds.z)
}