/**
 * Euler Integration (v03)
 * Pos  +=  spd 
 * + acceleration
 * + arrays
 * + damping & friction
 * + emitter
 */


int ballCount = 2000;
EulerBall[] balls = new EulerBall[ballCount];
float emissionRate = 1.2;
float liveBallCount;

void setup() {
  size(400, 400);
  fill(0);
  for (int i=0; i<ballCount; i++) {
    balls[i] = new EulerBall(new PVector(width/2, height/2), new PVector(random(-.5, .5), random(-2.7, -1)), random(1, 2));
    balls[i].setAccel(.02);
  }
}

void draw() {
  background(255);
  for (int i=0; i<liveBallCount; i++) {
    balls[i].move();
    balls[i].render();
    balls[i].boundsCollision();
  }
  if(liveBallCount < ballCount - emissionRate){
    liveBallCount += emissionRate;
  }
}

