class Face {
  PVector n;
  PVector[] vecs = new PVector[3];
  
  Face(){
  }
  
  Face(PVector[]vecs){
    this.vecs = vecs;
    calcNorms();
  }
  
   Face(PVector v0, PVector v1, PVector v2){
    vecs[0] = v0;
    vecs[1] = v1;
    vecs[2] = v2;
    calcNorms();
  }
  
  void calcNorms(){
    PVector temp0 = new PVector();
    PVector temp1 = new PVector();
    PVector temp2 = new PVector();
    temp0.set(vecs[0]);
    temp1.set(vecs[1]);
    temp2.set(vecs[2]);
    temp1.sub(temp0);
    temp2.sub(temp0);
   
    n = new PVector();
    n.x = temp1.y*temp2.z - temp1.z*temp2.y;
    n.y = temp1.z*temp2.x - temp1.x*temp2.z;
    n.z = temp1.x*temp2.y - temp1.y*temp2.x;
    
    n.normalize();
  }
  
  void display() {
    beginShape(TRIANGLES);
    normal(n.x, n.y, n.z);
    vertex(vecs[0].x, vecs[0].y, vecs[0].z);
    vertex(vecs[1].x, vecs[1].y, vecs[1].z);
    vertex(vecs[2].x, vecs[2].y, vecs[2].z);
    endShape(CLOSE);
  }
}
