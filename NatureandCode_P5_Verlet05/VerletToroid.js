class VerletToroid {

    constructor(r1, r2, slices, connects) {
        this.r1 = r1; // number
        this.r2 = r2; // number
        this.slices = slices; // number
        this.connects = connects; // number

        // 2D array
        this.nodes = []; // verlet nodes

        this.sticks = []; // verlet sticks
        //col; // Color

        // create nodes
        let theta = 0;
        // calculate nodes
        for (let i = 0; i < this.connects; i++) {
            // create tube profile (based on # of connects)

            /* Z-rotation to calculate connects
            x' = x*cos q - y*sin q
            y' = x*sin q + y*cos q
            z' = z
            */
            let x = this.r1 + Math.cos(theta) * r2;
            let y = Math.sin(theta) * r2;
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
                let x2 = z * Math.sin(phi) + x * Math.cos(phi)

                connectNodes[j] = new VerletNode(createVector(x2, y, z2), .88, color(255, 255, 255))

                phi += Math.PI * 2 / this.slices;
            }
            // add each connectNodes array to nodes 2D array
            this.nodes[i] = connectNodes;

            theta += Math.PI * 2 / this.connects;
        }

        stroke(255);
        // create sticks


    }

    verlet() {
    }


    draw() {
        for (let i = 0; i < this.connects; i++) {
            for (let j = 0; j < this.slices; j++) {
                this.nodes[i][j].draw();

                fill(200, 100, 100, 150);
                if (i < this.connects - 1 && j < this.slices - 1) {
                    beginShape();
                    vertex(this.nodes[i][j].pos.x, this.nodes[i][j].pos.y, this.nodes[i][j].pos.z);
                    vertex(this.nodes[i][j + 1].pos.x, this.nodes[i][j + 1].pos.y, this.nodes[i][j + 1].pos.z);
                    vertex(this.nodes[i + 1][j + 1].pos.x, this.nodes[i + 1][j + 1].pos.y, this.nodes[i + 1][j + 1].pos.z);
                    vertex(this.nodes[i + 1][j].pos.x, this.nodes[i + 1][j].pos.y, this.nodes[i + 1][j].pos.z);
                    endShape(CLOSE);
                }
            }

        }
    }

    boundsCollide(bounds) {
    }

}