/**
 * Particle Engine  - Burst Test 01
 * By Ira Greenberg <br />
 * The Essential Guide to Processing for Flash Developers,
 * Friends of ED, 2009
 */
 
 // create particle populations
int particleCount = 500;
int colliderCount = 150;
int emitterCount = 5;

// instantiate particle multidimensional arrays
Particle[][] particles = new Particle[emitterCount][particleCount];
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
    colliders[i] = new Collider(new PVector(random(width), random(height)), random(2, 15), #323332, true);
  }
  // instantiate emitters
   for (int i=0; i<emitterCount; i++){
     // instantiate particles
    for (int j=0; j<particleCount; j++){
      particles[i][j] = new Particle(random(1, 2), color(255-(20*i), random(80, 150)-(40*i), 10+(20*i), random(255)), 20000, .85);
    }
    emitters[i] = new Emitter(new PVector(75+(width/emitterCount)*i, 80), 60, new PVector(0, -2.2), .4, particles[i]);
   }
  // instantiate Environment
  environment = new Environment(.05, .785, new PVector(0, 0), .995, .06);
  // instantiate engine
  engine = new Engine(emitters, colliders, environment);
  
  //set boundary collisions
  boolean[] bounds =  {true, true, true, false};
  engine.setBoundaryCollision(true, bounds);
}

void draw(){
 // uncomment next line to see animated particles
 //background(0);
  // required to make engine do its thing
  engine.run();
}

