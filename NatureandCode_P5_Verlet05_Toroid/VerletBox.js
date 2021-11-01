// Ira Greenberg
// Nature & Code
// Center of Creative Computation | SMU
// Fall, 2021

// Description:
// Creating an organism
// based on a Verlet Box

// To Do;
// Add diagnol supports for cube

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
        console.log("typeof springiness = ", typeof this.springiness);

        // initialize styloe properties
        this.nodeRadius = 1;
        this.nodeCol = color(150, 34, 150);
        this.stickCol = color(150, 150, 0);


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
            [3, 7, 2]
        ];

        this.stickIndices = [
            //F
            [0, 1],
            [1, 2],
            [2, 3],
            [3, 0],
            //L
            [1, 4],
            [4, 7],
            [7, 2],
            [2, 1],
            //B
            [4, 5],
            [5, 6],
            [6, 7],
            [7, 4],
            //R
            [5, 0],
            [0, 3],
            [3, 6],
            [6, 5],
            //T
            [5, 4],
            [4, 1],
            [1, 0],
            [0, 5],
            //B
            [7, 6],
            [6, 3],
            [3, 2],
            [2, 7]
        ];

        this.vecs = [
            createVector(this.sz / 2, -this.sz / 2, this.sz / 2),
            createVector(-this.sz / 2, -this.sz / 2, this.sz / 2),
            createVector(-this.sz / 2, this.sz / 2, this.sz / 2),
            createVector(this.sz / 2, this.sz / 2, this.sz / 2),
            createVector(-this.sz / 2, -this.sz / 2, -this.sz / 2),
            createVector(this.sz / 2, -this.sz / 2, -this.sz / 2),
            createVector(this.sz / 2, this.sz / 2, -this.sz / 2),
            createVector(-this.sz / 2, this.sz / 2, -this.sz / 2)
        ]

        this.faces = [];
        for (let i = 0; i < this.indicies.length; i++) {
            this.faces[i] = new Face3(this.vecs[this.indicies[i][0]],
                this.vecs[this.indicies[i][1]],
                this.vecs[this.indicies[i][2]], this.col);
        }

        // verlet guts below
        this.nodes = [];
        for (let i = 0; i < this.vecs.length; i++) {
            this.nodes[i] = new VerletNode(this.vecs[i], this.nodeRadius, color(235, 235, 255));
        }

        this.sticks = [];
        for (let i = 0; i < this.stickIndices.length; i++) {
            this.sticks[i] = new VerletStick(this.nodes[this.stickIndices[i][0]], this.nodes[this.stickIndices[i][1]],
                this.springiness, 0, this.col);
        }

        // add diagonal support Lines
        this.sticks.push(new VerletStick(this.nodes[1], this.nodes[6],
            .01, 0, this.col));
        this.sticks.push(new VerletStick(this.nodes[4], this.nodes[3],
            .01, 0, this.col));
        this.sticks.push(new VerletStick(this.nodes[7], this.nodes[0],
            .01, 0, this.col));
        this.sticks.push(new VerletStick(this.nodes[2], this.nodes[5],
            .01, 0, this.col));

    }

    nudge(index, offset) {
        this.nodes[index].pos.add(offset);
    }

    verlet() {

        for (let i = 0; i < this.nodes.length; i++) {
            this.nodes[i].verlet();
        }

        for (let i = 0; i < this.sticks.length; i++) {
            this.sticks[i].constrainLen();
        }

    }

    setStyles(nodeRadius, nodeCol, stickCol) {
        this.nodeRadius = nodeRadius;
        this.nodeCol = nodeCol;
        this.stickCol = stickCol;

        for (let i = 0; i < this.nodes.length; i++) {
            this.nodes[i].setStyle(this.nodeRadius, this.nodeCol);
        }

        // Stick colors
        for (let i = 0; i < this.sticks.length; i++) {
            this.sticks[i].setColor(stickCol);
        }
    }

    draw() {
        for (let i = 0; i < this.faces.length; i++) {
            this.faces[i].draw();
        }

        for (let i = 0; i < this.nodes.length; i++) {
            this.nodes[i].draw();
        }

        for (let i = 0; i < this.sticks.length; i++) {
            this.sticks[i].draw();
        }
    }

    boundsCollide(bounds) {
        for (let i = 0; i < this.nodes.length; i++) {
            this.nodes[i].boundsCollide(bounds);
        }
    }
}
