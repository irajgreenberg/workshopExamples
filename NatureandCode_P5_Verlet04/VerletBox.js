// Ira Greenberg
// Nature & Code
// Center of Creative Computation | SMU
// Fall, 2021

// Description:
// Creating an organism
// based on a Verlet Box

/*
4*-------5*\
| \       | \
|  \*1----|-*0
|   |     |  |
7*--|---6*\  |
  \ |      \ |
   *2-------*3
*/
// Box indexing
// 12 Triangle faces
// CCW winding




class VerletBox {
    constructor(pos, sz, springiness, col) {
        this.pos = pos;
        this.sz = sz;
        this.springiness = springiness;
        this.col = col;

        this.indicies = [
            [0, 5, 1],
            [1, 5, 4],
            [2, 1, 4],
            [7, 2, 4],
            [0, 1, 3],
            [2, 3, 1],
            [0, 3, 6],
            [0, 6, 5],
            [4, 5, 6],
            [4, 6, 7],
            [3, 6, 7],
            [3, 7, 2],
        ];

        this.stickIndices = [
            //F
            [0,1],
            [1,2],
            [2,3],
            [3,0],
            //L
            [1,4],
            [4,7],
            [7,2],
            [2,1],
            //B
            [4,5],
            [5,6],
            [6,7],
            [7,4],
            //R
            [5,0],
            [0,3],
            [3,6],
            [6,5],
            //T
            [5,4],
            [4,1],
            [1,0],
            [0,5],
            //B
            [7,6],
            [6,3],
            [3,2],
            [2,7]
        ];

        this.vecs = [
            createVector(this.sz/2, -this.sz/2, this.sz/2),
            createVector(-this.sz/2, -this.sz/2, this.sz/2),
            createVector(-this.sz/2, this.sz/2, this.sz/2),
            createVector(this.sz/2, this.sz/2, this.sz/2),
            createVector(-this.sz/2, -this.sz/2, -this.sz/2),
            createVector(this.sz/2, -this.sz/2, -this.sz/2),
            createVector(this.sz/2, this.sz/2, -this.sz/2),
            createVector(-this.sz/2, this.sz/2, -this.sz/2)
        ]
        
        this.faces = [];
        for (let i = 0; i < this.indicies.length; i++) {
            this.faces[i] = new Face3(this.vecs[this.indicies[i][0]], 
                                    this.vecs[this.indicies[i][1]], 
                                    this.vecs[this.indicies[i][2]], this.col);
        }

        // verlet guts below
        this.nodes = [];
        for(let i=0; i<this.vecs.length; i++){
            this.nodes[i] = new VerletNode(this.vecs[i], 1, color(100, 100, 200));
        }

        this.sticks = [];
        for(let i=0; i<this.stickIndices.length; i++){
            this.sticks[i] = new VerletStick(this.nodes[this.stickIndices[i][0]], this.nodes[this.stickIndices[i][1]],
                .05, 0, this.col);
        }
    }

    nudge(index, offset) {
        this.nodes[index].pos.add(offset);
    }

    verlet() {
        
        for(let i=0; i<this.nodes.length; i++){
            this.nodes[i].verlet();
        }
     
        for(let i=0; i<this.sticks.length; i++){
            this.sticks[i].constrainLen();
        }

    }

    draw(){
        for(let i=0; i<this.faces.length; i++){
            this.faces[i].draw();
        }

        for(let i=0; i<this.nodes.length; i++){
            this.nodes[i].draw();
        }
        
        for(let i=0; i<this.sticks.length; i++){
            this.sticks[i].draw();
        }
    }

    boundsCollide(bounds){
        for(let i=0; i<this.nodes.length; i++){
            this.nodes[i].boundsCollide(bounds);
         }
    }
}
