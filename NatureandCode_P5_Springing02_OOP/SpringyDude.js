class SpringyDude {

    constructor(leader, follower, springing, damping, jitter) {
        this.leader = leader;
        this.follower = follower;
        this.springing = springing;
        this.damping = damping;
        this.jitter = jitter;
    }

    slither() {
        // jitter just adds some drama
        this.leader.spd.add(createVector(random(-this.jitter, this.jitter), random(-this.jitter, this.jitter)));
        this.leader.move();

        let deltaX = this.leader.pos.x - this.follower.pos.x;
        let deltaY = this.leader.pos.y - this.follower.pos.y;

        // create springing effect
        deltaX *= this.springing;
        deltaY *= this.springing;
        this.follower.spd.x += deltaX;
        this.follower.spd.y += deltaY;

        this.follower.move();

        // slow down springing
        this.follower.spd.x *= this.damping;
        this.follower.spd.y *= this.damping;

        this.leader.draw();
        this.follower.draw();

        stroke(150);
        line(this.leader.pos.x, this.leader.pos.y, this.follower.pos.x, this.follower.pos.y);
        noStroke();
    }

    checkBoundsCollision(bounds) {
        this.leader.checkBoundsCollision(bounds);
        this.follower.checkBoundsCollision(bounds);
    }
}