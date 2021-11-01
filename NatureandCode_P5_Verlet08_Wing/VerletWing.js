class VerletWing extends VerletBaseGeom {
    constructor(sz, elasticity){
        super(sz, elasticity);
        this.init();
    }

    init(){
      nodes[0] = new VerletNode(createVector(0, -this.sz.y/2, 0), .1, color(100));
      nodes[1] = new VerletNode(createVector(0, -this.sz.y/2, 0), .1, color(100));
      nodes[2] = new VerletNode(createVector(0, -this.sz.y/2, 0), .1, color(100));
      nodes[3] = new VerletNode(createVector(0, -this.sz.y/2, 0), .1, color(100));

    }

    flap(){

    }
    
}