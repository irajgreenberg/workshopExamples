// Creates centered drawn 
// unit arrow particle


// Requires import of Processing core classes
// when .java suffix is added
import processing.core.*;

class ArrowParticle {

  PApplet pApp;

  ArrowParticle() {
  }

  ArrowParticle(PApplet pApp) {
    this.pApp = pApp;
  }

  void create() {
    pApp.noStroke();
    pApp.fill(255, 150);
    pApp.beginShape();
    pApp.vertex(-.5f, -.175f); // need to explicitly cast to floats now
    pApp.vertex(.2f, -.175f);
    pApp.vertex(.2f, -.5f);
    pApp.vertex(.5f, 0);
    pApp.vertex(.2f, .5f);
    pApp.vertex(.2f, .175f);
    pApp.vertex(-.5f, .175f);
    pApp.endShape(PConstants.CLOSE);
  }
}
