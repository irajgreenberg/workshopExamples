import processing.core.*;

public class Polygon {
  //fields
  private PVector pos;
  private int sides;
  private double radius;
  //private color fillCol;
  private double[] fillCol = {
    255.0f, 255.0f, 255.0f, 255.0f
  };
  private PVector[] vecs;

  private PVector spd;
  private double gravity, damping, friction;

  private PApplet p;

  private double phi = 0;
  private PVector waveAmp;
  private double waveFreq;

  //cstrs
  public Polygon(PApplet p) {
    this.p = p;
  }


  public Polygon(PApplet p, PVector pos, int sides, double radius, double[] fillCol) {
    this.p = p;
    this.pos = pos;
    this.sides = sides;
    this.radius = radius;
    this.fillCol = fillCol;
    vecs = new PVector[sides];
    _init();
  }

  private void _init() {
    double theta = 0;
    for (int i=0; i<sides; ++i) {
      vecs[i] = new PVector((float)(p.cos((float)theta)*radius), (float)(p.sin((float)theta)*radius));
      theta += p.TWO_PI/sides;
    }
    waveAmp = new PVector(p.random(-2.9f, 2.9f), p.random(-2.9f, 2.9f));
    waveFreq = p.random(p.PI/180, p.PI/15);
  }

  public void setDynamics(PVector spd, double gravity, double damping, double friction) {
    this.spd = spd;
    this.gravity = gravity;
    this.damping = damping;
    this.friction = friction;
  }

  public void move() {
    spd.y += gravity;
    // spd.add(new PVector( p.sin(phi)*p.random(-.9f, .9f), 0 ));
    pos.add(new PVector((float)(spd.x + p.sin((float)phi)*waveAmp.x), (float)(spd.y)));
    phi += waveFreq;


    if (pos.x > p.width-radius) {
      pos.x = (float)(p.width-radius);
      spd.x *= -1;
    } else if (pos.x < radius) {
      pos.x = (float)radius;
      spd.x *=-1;
    }

    if (pos.y > p.height-radius) {
      pos.y = (float)(p.height-radius);
      spd.y *= -1;

      // impose damping/friction
      spd.y *= damping;
      spd.x *= friction;
      waveAmp.x *= friction;
    } else if (pos.y < radius) {
      pos.y = (float)radius;
      spd.y *=-1;
    }
  }

  public void display() {
    p.fill((float)fillCol[0], (float)fillCol[1], (float)fillCol[2], (float)fillCol[3]);
    p.pushMatrix();
    p.translate(pos.x, pos.y);
    p.beginShape();
    {
      for (int i=0; i<vecs.length; ++i) {
        p.vertex(vecs[i].x, vecs[i].y);
      }
    }
    p.endShape(p.CLOSE);
    p.popMatrix();
  }
}

