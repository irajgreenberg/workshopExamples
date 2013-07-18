/**
 * Arrow class
 * Particle Engine
 * By Ira Greenberg <br />
 * The Essential Guide to Processing for Flash Developers,
 * Friends of ED, 2009
 */
 
 class Arrow extends Particle{
  // properties with defaults
  int tailFinCount = 4;
  float len = 20.0;

  // default constructor
  Arrow(){
    // pass some defaults
    super(#0000DD, 1.0, 5000, .875);
    // required for accurate collision detection
    radius = len/2;
  }

  // constructor
  Arrow(float w, color col, float lifeSpan, float damping, float fade, int tailFinCount){
    super(w, col, lifeSpan, damping, fade);
    len = w;
    this.tailFinCount = tailFinCount;
    // required for accurate collision detection
    radius = len/2;
  }

  // overrides Particle create()
  // draw arrow
  void create(){
    float gap = 0.0;
    stroke(col);
    noFill();
    // draw arrow at 0 degrees on unit circle (facing right)
    // arrow shaft
    beginShape();
    vertex(-len/2, 0);
    vertex(len/2, 0);
    // tail
    if (tailFinCount > -1){
      // add tail feathers to last quarter of arrow shaft
      if (tailFinCount > 1){
        gap = len*.25/(tailFinCount-1);
      }
      for (int i=0; i<tailFinCount; i++){
        // top
        vertex(-len/2 + gap*i, 0);
        vertex(-len/2 - len/10.0 + gap*i, -len/10.0);
        //bottom
        vertex(-len/2 + gap*i, 0);
        vertex(-len/2 - len/10.0 + gap*i, len/10.0);
      }
      endShape();
      // head
      float theta = 0;
      float radius = len/8.0;
      fill(col);
      beginShape();
      for (int i=0; i<3; i++){
        vertex(len/2.0 + cos(theta)*radius, sin(theta)*radius);
        theta += PI/1.5;
      }
      endShape(CLOSE);
    }
  }

  // override Particle move() 
  // - arrow requires rotation alignment
  void move(){
    loc.add(vel);
    translate(loc.x, loc.y);
    rotate(atan2(vel.y, vel.x));
  }
  
  // setters
  void setTailFinCount(int tailFinCount){
    this.tailFinCount = tailFinCount;
  }
  
  void setLen(float len){
    this.len = len;
    radius = len/2;
  }

}









