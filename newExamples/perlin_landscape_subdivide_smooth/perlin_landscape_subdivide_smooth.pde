// Perlin Landscape

int rowDetail = 30, colDetail = 60;
Vertex3D[][]vecs2D;
ArrayList<Face> faces;
float ht = 170;

//float noiseFactor = .59;
float noiseSpaceX = 0, noiseSpaceY = 0, noiseSpaceZ = 0;
int octaves = 20;
float fallOff = .5;

void setup() {
  size(1080, 800, P3D);
  background(0);
  fill(200, 200, 255);
  //noStroke();
  lights();
  vecs2D = new Vertex3D[colDetail][rowDetail];
  faces = new ArrayList<Face>();

  float rowSpan = height/rowDetail;
  float colSpan = width/colDetail;

  //noiseDetail(octaves, fallOff);
  // calculate vecs
  for (int i=0; i<rowDetail; i++) {
    noiseSpaceX =  noiseSpaceY =  noiseSpaceZ = random(-1, 1);
    for (int j=0; j<colDetail; j++) {
      //ht = dist(width/2, height/2, -width/2 + colSpan*j, -height/2 + rowSpan*i)*.4;
      ht = (sqrt((width/2*width/2)+(height/2*height/2))-dist(0, 0, -width/2 + colSpan*j, -height/2 + rowSpan*i))*.35;
      noiseSpaceX += .02;
      noiseSpaceY += .02;
      noiseSpaceZ += .55;
      vecs2D[j][i] = new Vertex3D( 
      new PVector(-width/2 + colSpan*j+random(- noiseSpaceX, noiseSpaceX), 
      -height/2 + rowSpan*i+random(- noiseSpaceY, noiseSpaceY), 
      ht+noise(noiseSpaceZ, noiseSpaceZ, noiseSpaceZ)*noise(noiseSpaceZ)*ht)
        );
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
  subdivide(1);
  vertexNorms();
}


void draw() {
  background(0);
  lights();
  translate(width/2, height/1.75, -300);
  scale(2.3, 1, 2.3);
  rotateX(PI/3.2);
  rotateZ(frameCount*PI/720);

  for (int i = 0; i<faces.size(); i++) {
    faces.get(i).display();
  }
}

void subdivide(int subLim) {
  if (subLim-- > 0) {
    ArrayList<Face> tempFaces = new ArrayList<Face>();
    for (int i = 0; i<faces.size(); i++) {
      Vertex3D centroid = faces.get(i).getCentroid();
      //centroid.loc.mult(1+random(-.005, .005));
      tempFaces.add(new Face(faces.get(i).vecs[0], faces.get(i).vecs[1], centroid));
      tempFaces.add(new Face(faces.get(i).vecs[1], faces.get(i).vecs[2], centroid));
      tempFaces.add(new Face(faces.get(i).vecs[2], faces.get(i).vecs[0], centroid));
    }
    faces = tempFaces;
    tempFaces = null;
    subdivide(subLim);
  }
}

void vertexNorms() {

  for (int i=0; i<vecs2D.length; i++) {
    for (int j=0; j<vecs2D[i].length; j++) {
      for (int k=0; k<faces.size(); k++) {
        if (faces.get(k).contains(vecs2D[i][j]) ) {
          vecs2D[i][j].n.add(faces.get(k).n);
        }
      }
    }
  }
}

