/**
 * Particle Engine
 * By Ira Greenberg <br />
 * The Essential Guide to Processing for Flash Developers,
 * Friends of ED, 2009
 */
 
 // This class should be extended by other particle types
class Particle extends Sprite{

 // color components to calculate fade
  float colR;
  float colG;
  float colB;
  float colA;
  // capture inital alpha value
  float initAlpha;
 
  // particle dynamics
  float lifeSpan = 1000;
  float damping = .825;
  float fade = 1.0;
  // velocity
  PVector vel = new PVector();

  // default constructor
  Particle(){
    super();
    setColComponents();
  }

  // constructor
  Particle(float radius, color col, float lifeSpan, float damping, float fade){
    super(radius, col);
    this.lifeSpan = lifeSpan;
    this.damping = damping;
    this.fade = fade;
    // get color component values
    setColComponents();
  }

  // constructor
  Particle(color col, float lifeSpan, float damping, float fade){
    super(col);
    this.lifeSpan = lifeSpan;
    this.damping = damping;
    this.fade = fade;
    // get color component values
    setColComponents();
  }

  // instance methods
  void setColComponents(){
    // collects color component values
    colR = red(col);
    colG = green(col);
    colB = blue(col);
    colA = initAlpha = alpha(col);
  }

  // overrides method in Sprite class
  // allowing custom particle to be created
  // in Sprite descendant classes
  void create(){
    fill(col);
    noStroke();
    ellipse(0, 0, radius*2, radius*2);
  }

  void move(){
    loc.add(vel);
    translate(loc.x, loc.y);
  }

  // decreases alpha component
  void createFade(float val){
    colA -= val;
    col = color(colR, colG, colB, colA);
  }

  // resets alpha component
  void resetFade(){
    // put alpha back to original value
    colA = initAlpha;
    col = color(colR, colG, colB, colA);
  }

  void setFade(float fade){
    this.fade = fade;
  }

  void setVel(PVector vel){
    this.vel = vel;
  }

  // used by engine for collision detection
  Particle getClone(){
    Particle p = new Particle();
    p.loc.set(loc);
    p.vel.set(vel);
    p.radius = radius;
    p.damping = damping;
    return p;
  }

}








