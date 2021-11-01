/**
 * Particle Engine  - Burst Test 01
 * By Ira Greenberg <br />
 * The Essential Guide to Processing for Flash Developers,
 * Friends of ED, 2009
 */
 
 // create particle populations
int particleCount = 200;
int colliderCount = 50;
int emitterCount = 18;

// instantiate particle multidimensional arrays
Particle[][] arrows = new Arrow[emitterCount][particleCount];
// instantiate collider arrays
Collider[] colliders = new Collider[colliderCount];
// instantiate emitter arrays
Emitter[] emitters = new Emitter[emitterCount];
// declare rest of global variables
Environment environment;
Engine engine;

void setup(){
  size(800, 600, P2D);
  background(0);
  smooth();
 
   // instantiate colliders
  for (int i=0; i<colliderCount; i++){
    colliders[i] = new Collider(new PVector(random(width), random(height)), 4, #323332, true);
  }
  float theta = 0;
  float px = 0, py = 0;
  // instantiate emitters
   for (int i=0; i<emitterCount; i++){
     // instantiate particles
    for (int j=0; j<particleCount; j++){
      //float w, color col, float lifeSpan, float damping, int tailFinCount
      arrows[i][j] = new Arrow(random(2, 10), color(255, random(255)), 12000, .99, 4);
    }
    px = width/2+cos(theta)*200;
    py = height/2+sin(theta)*200;
    emitters[i] = new Emitter(new PVector(px, py), 60, new PVector((-px+width/2)*.01, (-py+height/2)*.01+-2), .4, arrows[i]);
    theta += TWO_PI/emitterCount;
   }
  // instantiate Environment
  environment = new Environment(.02, .785, new PVector(.02, 0), .995, 0);
  // instantiate engine
  engine = new Engine(emitters, colliders, environment);
  
  //set boundary collisions
  boolean[] bounds =  {true, true, true, false};
  engine.setBoundaryCollision(true, bounds);
}

void draw(){
 // uncomment next line to see animated particles
 background(0);
  // required to make engine do its thing
  engine.run();
}

