// creates centered unit particle
// applying texture map to polygon

class ImageParticle {

  PImage img;

  ImageParticle() {
  }

  ImageParticle(PImage img) {
    this.img = img;
  }

  void create() {
    noStroke();
    textureMode(NORMAL);
    beginShape();
    texture(this.img);
    vertex(-.5, -.5, 0, 0);
    vertex(.5, -.5, 1, 0);
    vertex(.5, .5, 1, 1);
    vertex(-.5, .5, 0, 1);
    endShape(CLOSE);
  }
}
