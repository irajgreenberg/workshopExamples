// Ira Greenberg
// Nature & Code
// Center of Creative Computation | SMU
// September 13, 2021

// Description:
// Simple springing
// using a follow the 
// leader approach with
// controllable easing.

// Note:
// Image removed due to P2D incompatibility
// with newer versions of Java (16). Arrow
// drawn with vertex() calls

// P5_Springing01.js
let bounds; // vector

let leader; //Vector
let leadSpd; //Vector
let follower; //Vector
let followerSpd; //vector

//scaler values
// play with these values
let springing = .03;
let damping = .9;

  
function setup() {
    createCanvas(600, 600); // size()
    bounds = createVector(400, 400);
    strokeWeight(3);
    
    leader = createVector();
    console.log(leader);
    leadSpd = createVector(random(-1.5, 1.5), random(-1.5, 1.5));

    follower = createVector();
    followerSpd = createVector(); // starts out at 0 or something else
}

function draw() {
    background(255);
    translate(width/2, height/2);
    drawBounds();
    lead();
    follow();
    render();
    checkBoundsCollision();
}

function drawBounds(){
    noFill();
    stroke(0);
    rect(-bounds.x/2, -bounds.y/2, bounds.x, bounds.y);
}

function lead() {
    leadSpd.add(createVector(random(-.2, .2), random(-.2, .2)));
    leader.add(leadSpd); // euler integration
    }

    function follow() {
    //move center point
    let deltaX = leader.x-follower.x;
    let deltaY = leader.y-follower.y;

    // create springing effect
    deltaX *= springing;
    deltaY *= springing;
    followerSpd.x += deltaX;
    followerSpd.y += deltaY;

    // move predator's center Euler
    follower.x +=  followerSpd.x;
    follower.y +=  followerSpd.y;

    // slow down springing
    followerSpd.x *= damping;
    followerSpd.y *= damping;
}

function render() {
    stroke(150);
    line(leader.x, leader.y, follower.x, follower.y);
    noStroke();
    fill(200, 100, 0);
    ellipse(leader.x, leader.y, 10, 10);
    fill(15, 170, 255);
    ellipse(follower.x, follower.y, 6, 6);
}

function checkBoundsCollision(){
//leader
if (leader.x > bounds.x/2) {
        leader.x = bounds.x/2;
        leadSpd.x*=-1;
    } 
    else if (leader.x < -bounds.x/2) {
        leader.x = -bounds.x/2;
        leadSpd.x*=-1;
    }

    if (leader.y > bounds.y/2) {
        leader.y = bounds.y/2;
        leadSpd.y*=-1;
    } 
    else if (leader.y < -bounds.y/2) {
        leader.y = -bounds.y/2;
        leadSpd.y*=-1;
    }

//follower
    if (follower.x > bounds.x/2) {
        follower.x = bounds.x/2;
        followerSpd.x*=-1;
    } 
    else if (follower.x < -bounds.x/2) {
        follower.x = -bounds.x/2;
        followerSpd.x*=-1;
    }

    if (follower.y > bounds.y/2) {
        follower.y = bounds.y/2;
        followerSpd.y*=-1;
    } 
    else if (follower.y < -bounds.y/2) {
        follower.y = -bounds.y/2;
        followerSpd.y*=-1;
    }
}

   