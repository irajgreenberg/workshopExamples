/**
 * Emitter class
 * Particle Engine
 * By Ira Greenberg <br />
 * The Essential Guide to Processing for Flash Developers,
 * Friends of ED, 2009
 */

class Emitter {

  // Properties
  // emitter position
  PVector loc = new PVector(0, 0);
  // rate particles are created
  float birthRate;
  // 3D path particles are projected
  PVector birthPath;
  // keep track of particle lifespan
  float[] birthTime;
  float[] lifeTime;
  // frame rate of the sketch, default is 60fps
  float sketchFrameRate;
  // radius the particles spray from the emitter at birth 
  float sprayWidth;
  // ammo
  Particle[] p;

  // By default emitter runs infinitely
  boolean isInfinite = true;

  // Environment reference with default instantiation
  Environment environment = new Environment();

  // used to control particle birth rate
  float particleCounter = 0.0;

  // default constructor
  Emitter(){
  }

  // constructor for infinite emission
  Emitter(PVector loc, float sketchFrameRate, PVector birthPath, float sprayWidth, Particle[] p){
    println(frameRate);
    this.loc = loc;
    this.sketchFrameRate = sketchFrameRate;
    birthRate = p.length/((p[0].lifeSpan/1000.0) * (sketchFrameRate));
    this.birthPath = birthPath;
    this.sprayWidth = sprayWidth;
    birthTime = new float[p.length];
    lifeTime = new float[p.length];
    this.p = p;
    for (int i=0; i<p.length; i++){
      init(i);
    }
  }

  // constructor for single emission with birthRate param (good for explosions, etc)
  Emitter(PVector loc, PVector birthPath, float birthRate, float sprayWidth, Particle[] p){
    this.loc = loc;
    // ensure birthRate max is particleCount-1
    this.birthRate = min(birthRate, p.length-1);
    this.birthPath = birthPath;
    this.sprayWidth = sprayWidth;
    birthTime = new float[p.length];
    lifeTime = new float[p.length];
    this.p = p;
    for (int i=0; i<p.length; i++){
      init(i);
    }
    isInfinite = false;
  }

  // called at the beginning of each emission cyle (and initially by the constructor)
  void init(int i){
    float theta = random(TWO_PI);
    float r = random(sprayWidth);
    p[i].vel = new PVector(birthPath.x + cos(theta)*r, birthPath.y + sin(theta)*r);
  }

  void setEnvironment(Environment environment){
    this.environment = environment;
  }

  // general methods
  void emit(){
    for (int i=0; i<particleCounter; i++){
      pushMatrix();
      //move each particle to emitter location
      translate(loc.x, loc.y);
      // draw/move particle
      p[i].move();
      p[i].create();
      popMatrix();

      // capture time at particle birth
      if (birthTime[i] == 0.0){
        birthTime[i] = millis();
      }
      if (lifeTime[i] < p[i].lifeSpan){
        // accelerate based on gravity 
        p[i].vel.y += environment.gravity;
        p[i].vel.y += random(-environment.turbulence, environment.turbulence) + environment.wind.y;
        p[i].vel.x += random(-environment.turbulence, environment.turbulence) + environment.wind.x;
        p[i].vel.mult(environment.resistance);
        // fade particle
        p[i].createFade(p[i].initAlpha/(frameRate*(p[i].lifeSpan/1000)));
      }
      else {
        if (isInfinite){
          // keep emitter going
          p[i].loc.mult(0.0);
          init(i);
          birthTime[i] = millis();
          p[i].resetFade();
        }
      }
      lifeTime[i] = millis() - birthTime[i];
    } 

    // controls rate of emission
    if (particleCounter < p.length - birthRate){
      particleCounter += birthRate;
    }
  }

  // set methods
  void setLoc(PVector loc){
    this.loc = loc;
  }

  void setBirthRate(float birthRate){
    this.birthRate = birthRate;
  }
}






















































