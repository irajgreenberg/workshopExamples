class Cube{
  PVector loc;
  Dimension dim;

  Vertex[] verts = new Vertex[8];
  Face[] faces = new Face[12];
  Tuple[] indices = new Tuple[12];

  Cube() {
  }

  Cube(PVector loc, Dimension dim) {
    this.loc = loc;
    this.dim = dim;

    initialize();
  }

  void initialize() {
    verts[0] = new Vertex(new PVector(-.5, .5, -.5), color(random(255), random(255), random(255)));
    verts[1] = new Vertex(new PVector(.5, .5, -.5), color(random(255), random(255), random(255)));
    verts[2] = new Vertex(new PVector(.5, .5, .5), color(random(255), random(255), random(255)));
    verts[3] = new Vertex(new PVector(-.5, .5, .5), color(random(255), random(255), random(255)));
    verts[4] = new Vertex(new PVector(-.5, -.5, -.5), color(random(255), random(255), random(255)));
    verts[5] = new Vertex(new PVector(.5, -.5, -.5), color(random(255), random(255), random(255)));
    verts[6] = new Vertex(new PVector(.5, -.5, .5), color(random(255), random(255), random(255)));
    verts[7] = new Vertex(new PVector(-.5, -.5, .5), color(random(255), random(255), random(255)));

    // front left
    indices[0] = new Tuple(7, 3, 6);
    // front right
    indices[1] = new Tuple(6, 3, 2);
    // right left
    indices[2] = new Tuple(5, 6, 2);
    // right right
    indices[3] = new Tuple(5, 2, 1);
    // back left
    indices[4] = new Tuple(4, 5, 1);
    // back right
    indices[5] = new Tuple(4, 1, 0);
    // left left
    indices[6] = new Tuple(7, 4, 0);
    // left right
    indices[7] = new Tuple(7, 0, 3);
    // top left
    indices[8] = new Tuple(4, 7, 5);
    // top right
    indices[9] = new Tuple(5, 7, 6);
    // bottom left
    indices[10] = new Tuple(2, 3, 0);
    // bottom right
    indices[11] = new Tuple(0, 1, 2);

    for (int i=0; i<faces.length; i++) {
      faces[i] = new Face(verts[indices[i].elem0], verts[indices[i].elem1], verts[indices[i].elem2]);
    }

    // vertex normals
    for (int i=0; i<verts.length; i++) {
      for (int j=0; j<faces.length; j++) {
        if ( faces[j].contains(verts[i]) ) {
          verts[i].n.add(faces[j].faceN);
        }
      }
      verts[i].n.normalize();
    }
  }

  void display() {
    noStroke();
    pushMatrix();
    translate(loc.x, loc.y, loc.z);
    scale(dim.w, dim.h, dim.d);
      for (int i=0; i<faces.length; i++) {
        faces[i].display();
      }
    popMatrix();
  }
}

