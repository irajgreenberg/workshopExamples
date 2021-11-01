/**
 * Cellular Automata
 * Shape class - convenience class
 * By Ira Greenberg <br />
 * The Essential Guide to Processing for Flash Developers,
 * Friends of ED, 2009
 */

class Shape {

  // instance properties
  PVector loc = new PVector();
  float w;
  float h;
  

  // default constructor
  Shape(){
  }

  Shape(float w, float h){
    this.w = w;
    this.h = h;
  }

  // constructor
  Shape(float x, float y, float w, float h){
    loc.x = x;
    loc.y = y;
    this.w = w;
    this.h = h;
  }

  // setters
  void setLoc(float x, float y){
    loc.x = x;
    loc.y = y;
  }

  void setLoc(PVector loc){
    this.loc = loc;
  }

  void setSize(float w, float h){
    this.w = w;
    this.h = h;
  }

}

