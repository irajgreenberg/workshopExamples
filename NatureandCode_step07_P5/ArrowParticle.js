// Creates centered drawn 
// unit arrow particle



class ArrowParticle {


  ArrowParticle() {
  }

  constructor(P) {
  }

  create() {
    noStroke();
    fill(255, 150);
    beginShape();
    vertex(-.5, -.175); 
    vertex(.2, -.175);
    vertex(.2, -.5);
    vertex(.5, 0);
    vertex(.2, .5);
    vertex(.2, .175);
    vertex(-.5, .175);
    endShape(CLOSE);
  }
}
