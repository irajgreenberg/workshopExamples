class Vertex {
  PVector loc = new PVector();
  PVector n = new PVector();
  color c;
  
  // constructors
  Vertex(){
  }
  
  Vertex(PVector loc, color c){
    this.loc = loc;
    this.c = c;
  }
  
}
