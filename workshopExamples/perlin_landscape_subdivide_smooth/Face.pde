class Face {
  PVector n;
  Vertex3D centroid = new Vertex3D();
  Vertex3D[] vecs = new Vertex3D[3];

  Face() {
  }

  Face(Vertex3D[]vecs) {
    this.vecs = vecs;
    calcNorms();
  }

  Face(Vertex3D v0, Vertex3D v1, Vertex3D v2) {
    vecs[0] = v0;
    vecs[1] = v1;
    vecs[2] = v2;
    calcNorms();
  }

  void calcNorms() {
    PVector temp0 = new PVector();
    PVector temp1 = new PVector();
    PVector temp2 = new PVector();
    temp0.set(vecs[0].loc);
    temp1.set(vecs[1].loc);
    temp2.set(vecs[2].loc);
    temp1.sub(temp0);
    temp2.sub(temp0);

    n = new PVector();
    n.x = temp2.y*temp1.z - temp2.z*temp1.y;
    n.y = temp2.z*temp1.x - temp2.x*temp1.z;
    n.z = temp2.x*temp1.y - temp2.y*temp1.x;

    n.normalize();
  }

  Vertex3D getCentroid() {
    centroid.loc.x = (vecs[0].loc.x + vecs[1].loc.x + vecs[2].loc.x)/3;
    centroid.loc.y = (vecs[0].loc.y + vecs[1].loc.y + vecs[2].loc.y)/3;
    centroid.loc.z = (vecs[0].loc.z + vecs[1].loc.z + vecs[2].loc.z)/3;
    return centroid;
  }

  boolean contains(Vertex3D v) {
    return v.loc==vecs[0].loc || v.loc==vecs[1].loc || v.loc==vecs[2].loc;
  }

  void display() {
    beginShape(TRIANGLES);
    normal(vecs[0].n.x, vecs[0].n.y, vecs[0].n.z);
    vertex(vecs[0].loc.x, vecs[0].loc.y, vecs[0].loc.z);
    normal(vecs[1].n.x, vecs[1].n.y, vecs[1].n.z);
    vertex(vecs[1].loc.x, vecs[1].loc.y, vecs[1].loc.z);
    normal(vecs[2].n.x, vecs[2].n.y, vecs[2].n.z);
    vertex(vecs[2].loc.x, vecs[2].loc.y, vecs[2].loc.z);
    endShape(CLOSE);
  }
}

