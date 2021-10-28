class VerletToroid {

    constructor(r1, r2, slices, connects, springiness, rigidity) {
        this.r1 = r1; // number
        this.r2 = r2; // number
        this.slices = slices; // number
        this.connects = connects; // number
        this.springiness = springiness; // number
        rigidity = abs(5 - rigidity) + 1; // inverse
        this.rigidity = constrain(rigidity, 1, 5); // number

        this.nodeCol = color(175, 185, 90);
        this.stickCol = color(145, 145, 145);
        this.skinCol = color(165, 83, 5, 255);

        this.nodes = []; // 2d array verlet nodes
        this.nodes1D = []; // 1d array for convenience
        this.sliceNodes = []; //conveninence array for calculating slice cross-ssupports

        this.sticks = []; // verlet sticks
        this.crossSupportSticks = [];
        this.hairs = [];
        this.hairLen = 30;

        this.ctr = 0;

        // create nodes
       

        // the unique drawing algorithm
        this.init();


        // create cross-supports and hairs
        let randNodeindex = 0;
        for (let i = 0, k = 0, l = 0; i < this.nodes1D.length; i++) {
            // cross-supports
            let val = Math.floor(Math.random() * (this.nodes1D.length - 1));
            if (i % this.rigidity === 0 && i !== val) {
                this.crossSupportSticks[k++] = new VerletStick(this.nodes1D[i], this.nodes1D[val], 1, 0, this.stickCol);
            }
            // hairs
            // to do
        }
    } // end cstr

    init(){
        let theta = 0;
        // calculate nodes
        for (let i = 0, k = 0; i < this.connects; i++) {
            // create tube profile (based on # of connects)

            /* Z-rotation to calculate connects
            x' = x*cos q - y*sin q
            y' = x*sin q + y*cos q
            z' = z
            */
            let x = this.r1 + Math.cos(theta) * this.r2;
            let y = Math.sin(theta) * this.r2;
            let z = 0;

            // create new connects arrays
            let connectNodes = [];

            let phi = 0;
            for (let j = 0; j < this.slices; j++) {
                // create copies of tube profiles (based on # of slices)
                /* Y-rotation to sweep connects, creating slices
                z' = z*cos p - x*sin p
                x' = z*sin p + x*cos p
                y' = y
                */
                let z2 = z * Math.cos(phi) - x * Math.sin(phi);
                let x2 = z * Math.sin(phi) + x * Math.cos(phi);

                if (j % 2 == 0) {
                    this.nodes1D[k++] = connectNodes[j] = new VerletNode(createVector(x2 * .85, y * .85, z2 * .85), 1.2, this.nodeCol);
                } else {
                    this.nodes1D[k++] = connectNodes[j] = new VerletNode(createVector(x2, y, z2), 1.2, this.nodeCol);
                }
                // this.nodes1D[k++] = connectNodes[j] = new VerletNode(createVector(x2, y, z2), 1.2, this.nodeCol);

                phi += Math.PI * 2 / this.slices;
            }
            // add each connectNodes array to nodes 2D array
            this.nodes[i] = connectNodes;

            theta += Math.PI * 2 / this.connects;
        }
        
        // create sticks
        for (let i = 0, k = 0; i < this.connects; i++) {
            for (let j = 0; j < this.slices; j++) {
                if (i < this.connects - 1 && j < this.slices - 1) {
                    this.sticks[k++] = new VerletStick(this.nodes[i][j], this.nodes[i][j + 1], this.springiness, 0, this.stickCol)
                    this.sticks[k++] = new VerletStick(this.nodes[i][j + 1], this.nodes[i + 1][j + 1], this.springiness, 0, this.stickCol)
                    this.sticks[k++] = new VerletStick(this.nodes[i + 1][j + 1], this.nodes[i + 1][j], this.springiness, 0, this.stickCol)
                    this.sticks[k++] = new VerletStick(this.nodes[i + 1][j], this.nodes[i][j], this.springiness, 0, this.stickCol)
                } else if (i == this.connects - 1 && j < this.slices - 1) {
                    this.sticks[k++] = new VerletStick(this.nodes[i][j], this.nodes[i][j + 1], this.springiness, 0, this.stickCol);
                    this.sticks[k++] = new VerletStick(this.nodes[i][j + 1], this.nodes[0][j + 1], this.springiness, 0, this.stickCol);
                    this.sticks[k++] = new VerletStick(this.nodes[0][j + 1], this.nodes[0][j], this.springiness, 0, this.stickCol);
                    this.sticks[k++] = new VerletStick(this.nodes[0][j], this.nodes[i][j], this.springiness, 0, this.stickCol);
                } else if (i < this.connects - 1 && j == this.slices - 1) {
                    beginShape();
                    this.sticks[k++] = new VerletStick(this.nodes[i][j], this.nodes[i][0], this.springiness, 0, this.stickCol);
                    this.sticks[k++] = new VerletStick(this.nodes[i][0], this.nodes[i + 1][0], this.springiness, 0, this.stickCol);
                    this.sticks[k++] = new VerletStick(this.nodes[i + 1][0], this.nodes[i + 1][j], this.springiness, 0, this.stickCol);
                    this.sticks[k++] = new VerletStick(this.nodes[i + 1][j], this.nodes[i][j], this.springiness, 0, this.stickCol);
                }
            }
        }
    }
    
    setColor(skinCol) {
        this.skinCol = skinCol;
    }

    nudge(index, offset) {
        if (index === -1) {
            let ind = Math.floor(Math.random() * (this.nodes1D.length - 1));
            this.nodes1D[ind].pos.add(offset);
        } else {
            this.nodes1D[index].pos.add(offset);
        }
    }


    verlet() {
        for (let i = 0; i < this.nodes1D.length; i++) {
            this.nodes1D[i].verlet();
        }

        // constrain Toroid sticks
        for (let i = 0; i < this.sticks.length; i++) {
            this.sticks[i].constrainLen();
        }

        //constrain cross-supports 
        for (let i = 0; i < this.crossSupportSticks.length; i++) {
            this.crossSupportSticks[i].constrainLen();
        }
    }

    draw(areNodesDrawable = true, areSticksDrawable = true, isSkinDrawable = true) {
        // draw nodes
        if (areNodesDrawable) {
            for (let i = 0; i < this.nodes1D.length; i++) {
                this.nodes1D[i].draw();
            }
        }

        // draw verlet sticks
        if (areSticksDrawable) {
            for (let i = 0; i < this.sticks.length; i++) {
                this.sticks[i].draw();
            }
        }

        // draw skin
        if (isSkinDrawable) {
            for (let i = 0; i < this.connects; i++) {
                for (let j = 0; j < this.slices; j++) {
                    fill(this.skinCol);
                    noStroke();
                    if (i < this.connects - 1 && j < this.slices - 1) {
                        beginShape();
                        vertex(this.nodes[i][j].pos.x, this.nodes[i][j].pos.y, this.nodes[i][j].pos.z);
                        vertex(this.nodes[i][j + 1].pos.x, this.nodes[i][j + 1].pos.y, this.nodes[i][j + 1].pos.z);
                        vertex(this.nodes[i + 1][j + 1].pos.x, this.nodes[i + 1][j + 1].pos.y, this.nodes[i + 1][j + 1].pos.z);
                        vertex(this.nodes[i + 1][j].pos.x, this.nodes[i + 1][j].pos.y, this.nodes[i + 1][j].pos.z);
                        endShape(CLOSE);
                    } else if (i == this.connects - 1 && j < this.slices - 1) {
                        beginShape();
                        vertex(this.nodes[i][j].pos.x, this.nodes[i][j].pos.y, this.nodes[i][j].pos.z);
                        vertex(this.nodes[i][j + 1].pos.x, this.nodes[i][j + 1].pos.y, this.nodes[i][j + 1].pos.z);
                        vertex(this.nodes[0][j + 1].pos.x, this.nodes[0][j + 1].pos.y, this.nodes[0][j + 1].pos.z);
                        vertex(this.nodes[0][j].pos.x, this.nodes[0][j].pos.y, this.nodes[0][j].pos.z);
                        endShape(CLOSE);
                    } else if (i < this.connects - 1 && j == this.slices - 1) {
                        beginShape();
                        vertex(this.nodes[i][j].pos.x, this.nodes[i][j].pos.y, this.nodes[i][j].pos.z);
                        vertex(this.nodes[i][0].pos.x, this.nodes[i][0].pos.y, this.nodes[i][0].pos.z);
                        vertex(this.nodes[i + 1][0].pos.x, this.nodes[i + 1][0].pos.y, this.nodes[i + 1][0].pos.z);
                        vertex(this.nodes[i + 1][j].pos.x, this.nodes[i + 1][j].pos.y, this.nodes[i + 1][j].pos.z);
                        endShape(CLOSE);
                    }
                }
            }
        }

        for (let i = 0; i < this.crossSupportSticks.length; i++) {
            // this.crossSupportSticks[i].draw();
        }
    }

    boundsCollide(bounds) {
        for (let i = 0; i < this.nodes1D.length; i++) {
            this.nodes1D[i].boundsCollide(bounds);
        }
    }

}