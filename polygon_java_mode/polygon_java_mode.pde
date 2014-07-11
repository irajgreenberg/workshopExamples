int polyCount = 5000;
float birthRate = 5.45;
float livePolyCount = 0;

Polygon[] polys = new Polygon[polyCount];

void setup() {
  size(1000, 600);
  background(255);
  noStroke();
  //int sides, float radius, color fillCol
  for(int i=0; i<polys.length; ++i){
    polys[i] = new Polygon(this, new PVector(width/2, height/2), 
    int(random(3, 14)), random(1, 3), 
    new double[]{random(127, 255), random(85, 90), random(180, 255), random(255)} );
    
    //setDynamics(PVector spd, float gravity, float damping, float friction)
    polys[i].setDynamics(new PVector(random(-.8, .8), -7), random(.09, .2), .85, .98);
  }
    
}

void draw(){
  //background(255);
  fill(255, 255, 200, 20);
  rect(0, 0, width, height);
  for(int i=0; i<livePolyCount; ++i){
    polys[i].move();
    polys[i].display();
  }
  
  if (livePolyCount < polyCount-birthRate){
    livePolyCount += birthRate;
  }
}

