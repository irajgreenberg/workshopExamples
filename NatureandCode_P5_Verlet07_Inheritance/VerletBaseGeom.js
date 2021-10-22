class VerletBaseGeom {

    constructor(sz, elasticity) {
        this.sz = new sz;
        this.elasticity = elasticity;
        this.nodes = [];
        this.sticks = [];
    }

    verlet() {
        for (let i = 0; i < this.nodes.length; i++) {
            this.nodes[i].verlet();
        }

        for (let i = 0; i < this.sticks.length; i++) {
            this.sticks[i].constrainLen();
        }

    }

    //  subclass implements
   init(){ 
   }

}