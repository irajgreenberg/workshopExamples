class VerletToroid {

    constructor(r1, r2, slices, connects) {
        this.r1 = r1; // number
        this.r2 = r2; // number
        this.slices = slices; // number
        this.connects = connects; // number

        this.nodes = []; // verlet nodes
        this.sticks = []; // verlet sticks
        //col; // Color

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
                z' = z*cos q - x*sin q
                x' = z*sin q + x*cos q
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
    }

    verlet() {
    }


    draw() {
        for (let i = 0; i < this.connects; i++) {
            for (let j = 0; j < this.slices; j++) {
                this.nodes[i][j].draw();
            }
        }
    }

    boundsCollide(bounds) {
    }

}