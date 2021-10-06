class VerletToroid {

    constructor(pos, r1, r2, slices, connects) {
        this.pos = pos; // Vector
        this.r1 = r1; // number
        this.r2 = r2; // number
        this.slices = slices; // number
        this.connects = connects; // number

        nodes = []; // verlet nodes
        sticks = []; // verlet sticks
        col; // Color

        let theta = 0;
        // calculate nodes
        for (let i = 0; i < this.connects; i++) {
            // create tube profile (based on # of connects)
            // create new connects arrays

            /* Z-rotation to calculate connects
            x' = x*cos q - y*sin q
            y' = x*sin q + y*cos q
            z' = z
            */
            let x = pos.x + Math.cos(theta) * r2;
            let y = pos.y + Math.sin(theta) * r2;
            let connectNodes = [];
            theta += Math.PI * 2 / this.connects;

            for (let j = 0; j < this.slices; j++) {
                // create copies of tube profiles (based on # of slices)
                /* Y-rotation to sweep connects, creating slices
                z' = z*cos q - x*sin q
                x' = z*sin q + x*cos q
                y' = y
                */
                nodes[j] = connectNodes;
            }
        }
    }

    verlet() {
    }


    draw() {
    }

    boundsCollide(bounds) {
    }

}