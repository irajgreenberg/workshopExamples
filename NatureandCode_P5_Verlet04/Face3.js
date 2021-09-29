class Face3 {

    constructor(vec1, vec2, vec3, col) {
        this.vec1 = vec1;
        this.vec2 = vec2;
        this.vec3 = vec3;
        this.col = col;
    }

    // for later perhaps
    getCentroid() {
        let vec = createVector(this.vec1.x, this.vec1.y, this.vec1.z);
        vec.add(this.vec2);
        vec.add(this.vec3);
        return vec.div(3);
    }

    // for later perhaps
    getNormal() {
        let vecA = createVector(this.vec2.x, this.vec2.y, this.vec2.z);
        vecA.sub(this.vec1);
        let vecB = createVector(this.vec3.x, this.vec3.y, this.vec3.z);
        vecB.sub(this.vec1);
        // returns line perpendicular to the face
        return vecA.cross(vecB);
    }

    draw() {
        noStroke();
       // stroke(0);
        fill(this.col);
        beginShape();
        vertex(this.vec1.x, this.vec1.y, this.vec1.z);
        vertex(this.vec2.x, this.vec2.y, this.vec2.z);
        vertex(this.vec3.x, this.vec3.y, this.vec3.z);
        endShape(CLOSE);
    }
    
}