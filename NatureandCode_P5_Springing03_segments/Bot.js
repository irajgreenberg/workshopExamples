class Bot {
    constructor(r, col, pos, spd) {
        this.r = r; // radius
        this.col = col;
        this.pos = pos;
        this.spd = spd;
    }

    move() {
        this.pos.add(this.spd);
    }

    draw() {
        push();
        translate(this.pos.x, this.pos.y);
        fill(this.col);
        ellipse(0, 0, this.r * 2, this.r * 2);
        pop();
    }

    checkBoundsCollision(bounds) {
        if (this.pos.x > bounds.x / 2 - this.r) {
            this.pos.x = bounds.x / 2 - this.r;
            this.spd.x *= -1;
        }
        else if (this.pos.x < -bounds.x / 2 + this.r) {
            this.pos.x = -bounds.x / 2 + this.r;
            this.spd.x *= -1;
        }

        if (this.pos.y > bounds.y / 2 - this.r) {
            this.pos.y = bounds.y / 2 - this.r;
            this.spd.y *= -1;
        }
        else if (this.pos.y < -bounds.y / 2 + this.r) {
            this.pos.y = -bounds.y / 2 + this.r;
            this.spd.y *= -1;
        }
    }
}