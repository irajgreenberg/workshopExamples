Point2D dummy;
Vect2D dummyVel;

int feetCount = 4;
Point2D[] feet = new Point2D[feetCount];
Vect2D[] feetDelta = new Vect2D[feetCount];
Vect2D[] feetVel = new Vect2D[feetCount];
Vect2D[] feetAccel = new Vect2D[feetCount];

float botRadius = 30.0;
float[] springSpeed = new float[feetCount];
float springSpdMin = .05, springSpdMax = .15;
float drag = .90;

Point2D lead;
Vect2D leadVel;

void setup(){
  size(400, 400);
  smooth();
  frameRate(30);
  dummy = new Point2D(width/2, height/2);
  dummyVel = new Vect2D(3.65, 2.0);
  lead = new Point2D(width/2, height/2);
  leadVel = new Vect2D(.04, .05);
  
  // set legs with some trig
  float theta = 0;
  float rad = 100;
  for (int i=0; i<feet.length; i++){
    feet[i] = new Point2D(dummy.x + cos(theta)*botRadius, dummy.y + sin(theta)*botRadius);
    feetDelta[i] = new Vect2D(feet[i].x-dummy.x, feet[i].y-dummy.y);
    feetVel[i] = new Vect2D(0, 0);
    feetAccel[i] = new Vect2D(0, 0);
    theta += TWO_PI/feet.length;
    springSpeed[i] = random(springSpdMin, springSpdMax);
  }
}

void draw(){
  background(255);
  drawBot();
  moveBot();
}

void drawBot(){
  rectMode(CENTER);
  fill(0);
  for (int i=0; i<feet.length; i++){
    line(dummy.x, dummy.y, feet[i].x, feet[i].y);
    if (i<feet.length-1){
      line(feet[i].x, feet[i].y, feet[i+1].x, feet[i+1].y);
    } 
    else {
      line(feet[i].x, feet[i].y, feet[0].x, feet[0].y);
    }
  }
   line(mouseX, mouseY, dummy.x, dummy.y);
  fill(255);
}

void moveBot(){
  Vect2D[] feetMotionDelta = new Vect2D[feetCount];

  for (int i=0; i<feet.length; i++){
    feetMotionDelta[i] = new Vect2D((dummy.x-feet[i].x+feetDelta[i].vx)*springSpeed[i], 
    (dummy.y-feet[i].y+feetDelta[i].vy)*springSpeed[i]);

    feetAccel[i].vx+= feetMotionDelta[i].vx;
    feetAccel[i].vy+= feetMotionDelta[i].vy;

    feetVel[i].vx += feetAccel[i].vx;
    feetVel[i].vy += feetAccel[i].vy;

    feet[i].x = feetVel[i].vx ;
    feet[i].y = feetVel[i].vy ;

    feetAccel[i].vx *= drag;
    feetAccel[i].vy *= drag;

    dummy.x = mouseX;
    dummy.y = mouseY;
  }
}
