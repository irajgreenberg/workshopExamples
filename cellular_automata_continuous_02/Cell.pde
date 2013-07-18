/**
 * Cellular Automata
 * Cell class
 * - encapuslates drawing to pixel buffer
 * By Ira Greenberg <br />
 * The Essential Guide to Processing for Flash Developers,
 * Friends of ED, 2009
 */

class Cell extends Shape{

  color c;
  // reference to CA obj
  CA ca;

  Cell(float x, float y, float w, float h, CA ca){
    super(x, y, w, h);
    this.ca = ca;
  }

  void setColor(color c){
    this.c = c;
  }

  // draw to pixels buffer
  void create(){
    float origin = int(loc.y) * ca.w + int(loc.x);
    for (int i=0; i<w; i++){
      for (int j=0; j<h; j++){
          // - pretty nasty pixls[index] expression
        ca.p.pixels[int(min(origin + j*ca.w + i, ca.w*ca.h))] = c;
      }
    }
  }
}


