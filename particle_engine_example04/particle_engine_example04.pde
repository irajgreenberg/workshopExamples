/**
 * Particle Engine  - Burst Test 01
 * By Ira Greenberg <br />
 * The Essential Guide to Processing for Flash Developers,
 * Friends of ED, 2009
 */
 
 // create particle populations
int particleCount = 100;
int colliderCount = 1;
int emitterCount = 24;

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
    colliders[i] = new Collider(new PVector(width/2, height/2), 250, #323332, false);
  }
  float theta = 0;
  float px = 0, py = 0;
  // instantiate emitters
   for (int i=0; i<emitterCount; i++){
     // instantiate particles
    for (int j=0; j<particleCount; j++){
      particles[i][j] = new Particle(random(1, 2), color(max(0, 255-(20*i)), max(0, random(80, 150)-(40*i)), min(10+(20*i), 255), 255), 20000, .85);
    }
    px = width/2+cos(theta)*200;
    py = height/2+sin(theta)*200;
    emitters[i] = new Emitter(new PVector(px, py), 60, new PVector((-px+width/2)*.01, (-py+height/2)*.01), .4, particles[i]);
    theta += TWO_PI/emitterCount;
   }
  // instantiate Environment
  environment = new Environment(.0, .785, new PVector(0, 0), .995, .06);
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

