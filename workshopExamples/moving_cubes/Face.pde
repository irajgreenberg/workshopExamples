class Face {
  Vertex[] verts;
  PVector faceN;
  PVector centroid;

  Face() {
  }

  Face(Vertex[] verts) {
    this.verts = verts;
    setFaceN();
  }

  Face(Vertex v0, Vertex v1, Vertex v2) {
    verts = new Vertex[3];
    verts[0] = v0;
    verts[1] = v1;
    verts[2] = v2;
    setFaceN();
  }

  void setFaceN() {
    PVector temp0 = new PVector();
    PVector temp1 = new PVector();
    PVector temp2 = new PVector();
    temp0.set(verts[0].loc);
    temp1.set(verts[1].loc);
    temp2.set(verts[2].loc);
    temp1.sub(temp0);
    temp2.sub(temp0);

    faceN = new PVector();
    /* this is what the cross product calculation looks like
     faceN.x = temp1.y*temp2.z - temp1.z*temp2.y;
     faceN.y = temp1.z*temp2.x - temp1.x*temp2.z;
     faceN.z = temp1.x*temp2.y - temp1.y*temp2.x;
     */
    faceN = temp2.cross(temp1);
    faceN.normalize();

    // set centroid
    centroid = new PVector((verts[0].loc.x + verts[1].loc.x + verts[2].loc.x)/3, 
    (verts[0].loc.y + verts[1].loc.y + verts[2].loc.y)/3, 
    (verts[0].loc.z + verts[1].loc.z + verts[2].loc.z)/3 
      );
  }

  void display() {
    beginShape();
    for (int i=0; i<3; i++) {
      normal(verts[i].n.x, verts[i].n.y, verts[i].n.z);
      //normal(faceN.x, faceN.y, faceN.z);
      fill(verts[i].c);
      vertex(verts[i].loc.x, verts[i].loc.y, verts[i].loc.z);
    }
    endShape(CLOSE);
  }

  void displayNormals(float len) {
    beginShape();
    vertex(centroid.x, centroid.y, centroid.z);
    vertex(centroid.x + faceN.x*len, centroid.y + faceN.y*len, centroid.z + faceN.z*len);
    endShape();
  }

  boolean contains(Vertex v) {
    if (v==verts[0] || v==verts[1] || v==verts[2]) {
      return true;
    }
    return false;
  }
}

