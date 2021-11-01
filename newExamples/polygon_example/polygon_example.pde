int polyCount = 1000;
Polygon[] polys = new Polygon[polyCount];

void setup() {
  size(600, 600);
  background(255);
  noStroke();
  //int sides, float radius, color fillCol
  for(int i=0; i<polys.length; ++i){
    polys[i] = new Polygon(new PVector(random(width), random(height)), 
    int(random(3, 14)), random(3, 16), 
    color(0, random(255), random(255), random(255)));
    
    //setDynamics(PVector spd, float gravity, float damping, float friction)
    polys[i].setDynamics(new PVector(random(-2.5, 2.5), 0), random(.03, .1), .67, .98);
  }
    
}

void draw(){
  //background(255);
  fill(255, 15);
  rect(0, 0, width, height);
  for(int i=0; i<polys.length; ++i){
    polys[i].move();
    polys[i].display();
  }
}

