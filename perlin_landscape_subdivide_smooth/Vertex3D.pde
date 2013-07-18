class Vertex3D {
  PVector loc = new PVector();
  PVector n = new PVector();
  color col;
  
  Vertex3D(){
  }
  
  Vertex3D(PVector loc){
    this.loc = loc;
  }
  
  Vertex3D(PVector loc, color col){
    this.loc = loc;
    this.col = col;
  }
  
  void setNorm(PVector n){
    this.n = n;
    n.normalize();
  }
}
