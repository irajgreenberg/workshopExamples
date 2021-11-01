void subdivide (int subLevel) {
  
  // conditional controls recursion level
  if (subLevel-- > 0) {

    // local ArrayList collects new vertices
    ArrayList<PVector> vertsNew = new ArrayList<PVector>();

    // calc new radius for equalateral tri
    PVector segDistV = new PVector();
    float theta60 = PI/3;

    PVector v0 = new PVector();
    PVector vM = new PVector();
    PVector v1 = new PVector();


    for (int i=0; i<verts.size(); ++i) {
      // add initial point
      vertsNew.add(new PVector(verts.get(i).x, verts.get(i).y)); 

      
      if (i<verts.size()-1) {
         // curve until last section
         segDistV.set(verts.get(i+1));
         v1.set(verts.get(i+1));
      } else {
         // use 1st vert as last vert since curve is closed 
        segDistV.set(verts.get(0));
        v1.set(verts.get(0));
      }

        // segment vector
        segDistV.sub(verts.get(i));
        segDistV.div(3);

        // base corners of new equalateral triangle
        v0.set(verts.get(i));
        v0.add(segDistV);
        // v1 set above
        v1.sub(segDistV);

        // rotate to get tip of equalateral triangles
        vM.x = v0.x + cos(-theta60)*segDistV.x - sin(-theta60)*segDistV.y;
        vM.y = v0.y + sin(-theta60)*segDistV.x + cos(-theta60)*segDistV.y; 
     

      // add new vertices to local ArrayList
      vertsNew.add(new PVector(v0.x, v0.y)); // add point
      vertsNew.add(new PVector(vM.x, vM.y)); // add point
      vertsNew.add(new PVector(v1.x, v1.y)); // add point
    }

    // update global vertex ArrayList
    verts = vertsNew;

    // recursive call
    subdivide(subLevel);
  }
}

