// Creates centered unit particle
// applying texture map to polygon

// Requires import of Processing core classes
// when .java suffix is added
import processing.core.*;

class ImageParticle {

  PApplet pApp;
  PImage img;

  ImageParticle() {
  }

  ImageParticle(PApplet pApp, PImage img) {
    this.pApp = pApp;
    this.img = img;
  }

  void create() {
    pApp.noStroke();
    pApp.textureMode(pApp.NORMAL);
    pApp.beginShape();
    pApp.texture(this.img);
    pApp.vertex(-.5f, -.5f, 0, 0); // need to explicitley cast to floats now
    pApp.vertex(.5f, -.5f, 1, 0); 
    pApp.vertex(.5f, .5f, 1, 1);
    pApp.vertex(-.5f, .5f, 0, 1);
    pApp.endShape(pApp.CLOSE);
  }
}
