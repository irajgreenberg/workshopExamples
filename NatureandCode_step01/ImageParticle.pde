
class ImageParticle {

  PImage img;
  PVector dim;
  PVector pos;
  PVector spd;

  ImageParticle() {
  }

  ImageParticle(PImage img, PVector dim, PVector pos, PVector spd) {
    this.img = img;
    this.dim = dim;
    this.pos = pos;
    this.spd = spd;
    img.resize(int(dim.x), int(dim.y)); // lossy 
  }

  void move() {
    spd.y+=gravity;
    pos.add(spd);
  }

  void create() {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(atan2(pos.y-height/2, pos.x-width/2));
    image(img, -img.width/2, -img.height/2); // align ith image center
    popMatrix();
  }
}
