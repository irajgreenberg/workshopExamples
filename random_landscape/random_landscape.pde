int rowDetail = 55, colDetail = 55;
PVector[][]vecs2D;
//color[][]cols2D;
ArrayList<Face> faces;
float ht = 20;

void setup() {
  size(1080, 800, P3D);

  fill(200, 200, 255);
 //noStroke();

  vecs2D = new PVector[rowDetail][colDetail];
 // cols2D = new color[rowDetail][colDetail];
  faces = new ArrayList<Face>();

  float rowSpan = height/rowDetail;
  float colSpan = width/colDetail;

  // calculate vecs
  for (int i=0; i<rowDetail; i++) {
    for (int j=0; j<colDetail; j++) {
      ht = (sqrt((width/2*width/2)+(height/2*height/2))-dist(0, 0, -width/2 + colSpan*j, -height/2 + rowSpan*i))*.5;
      vecs2D[j][i] = new PVector(-width/2 + colSpan*j, -height/2 + rowSpan*i, ht); //+random(-ht*.3));
     // cols2D[j][i] = color(50, 25, 10);
    }
  }

  // calculate faces
  PVector[] tempVecs = new PVector[4];
  for (int i=0; i<rowDetail-1; i++) {
    for (int j=0; j<colDetail-1; j++) {
      faces.add(new Face(vecs2D[j][i], vecs2D[j][i+1], vecs2D[j+1][i+1]));
      faces.add(new Face(vecs2D[j][i], vecs2D[j+1][i+1], vecs2D[j+1][i]));
    }
  }
}

void draw() {
  background(0);
  lights();
  translate(width/2, height/2, -50);
  rotateX(PI/3.2);
  rotateZ(frameCount*PI/720);
  for ( int i = 0; i<faces.size(); i++) {
    faces.get(i).display();
  }
}

