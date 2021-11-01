/**
 * Particle Engine  - Burst Test 01
 * By Ira Greenberg <br />
 * The Essential Guide to Processing for Flash Developers,
 * Friends of ED, 2009
 */
 
 // create particle populations
int particleCount = 5000;

// instantiate particle arrays
Particle[] particles = new Particle[particleCount];

// instantiate collider arrays
int colliderCount = 1;
Collider[] colliders = new Collider[colliderCount];
// instantiate emitter arrays
int emitterCount = 1;
Emitter[] emitters = new Emitter[emitterCount];
// declare rest of global variables
Environment environment;
Engine engine;

void setup(){
  size(800, 600, P2D);
  background(0);
  smooth();
  // instantiate base particles
  for (int i=0; i<particleCount; i++){
    particles[i] = new Particle(random(1, 2), color(255, random(80, 150), 10, random(255)), 25000, .15, int(random(1, 13)));
  }

   // instantiate colliders
  for (int i=0; i<colliderCount; i++){
    colliders[i] = new Collider(new PVector(width/2, height), 20, #323332, false);
  }
  // instantiate emitters
  emitters[0] = new Emitter(new PVector(width/2, height), new PVector(0, 0), particles.length, 5, particles);

  // instantiate Environment
  environment = new Environment(.04, .785, new PVector(0, -.1), .935, .69);
  // instantiate engine
  engine = new Engine(emitters, colliders, environment);
  
  //set boundary collisions
  boolean[] bounds =  {true, true, true, false};
  engine.setBoundaryCollision(true, bounds);
}

void draw(){
 // uncomment next line to see animated particles
 //background(0);
 fill(0, 5);
 rect(-1, -1, width+1, height+1);
  // required to make engine do its thing
  engine.run();
}







