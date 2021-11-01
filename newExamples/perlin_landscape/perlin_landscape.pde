// Perlin Landscape

int rowDetail = 30, colDetail = 60;
PVector[][]vecs2D;
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
  vecs2D = new PVector[colDetail][rowDetail];
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
      vecs2D[j][i] = new PVector(-width/2 + colSpan*j+random(- noiseSpaceX, noiseSpaceX), -height/2 + rowSpan*i+random(- noiseSpaceY, noiseSpaceY), ht+noise(noiseSpaceZ, noiseSpaceZ, noiseSpaceZ)*noise(noiseSpaceZ)*ht);
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
  for (int i = 0; i<faces.size(); i++) {
    faces.get(i).display();
  }
}

