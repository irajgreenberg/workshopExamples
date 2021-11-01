class SpringyDude {

    constructor(leader, followers, springing, damping, jitter) {
        this.leader = leader;
        this.followers = followers;
        this.springing = springing;
        this.damping = damping;
        this.jitter = jitter;
    }

    slither() {

        // jitter just adds some drama
        this.leader.spd.add(createVector(random(-this.jitter, this.jitter), random(-this.jitter, this.jitter)));
        this.leader.move();
        //console.log(this.followers.length);
        for (let i = 0; i < this.followers.length; i++) {
            if (i == 0) {
                let deltaX = this.leader.pos.x - this.followers[i].pos.x;
                let deltaY = this.leader.pos.y - this.followers[i].pos.y;

                // create springing effect
                deltaX *= this.springing;
                deltaY *= this.springing;
                this.followers[i].spd.x += deltaX;
                this.followers[i].spd.y += deltaY;

                this.followers[i].move();

                // slow down springing
                this.followers[i].spd.x *= this.damping;
                this.followers[i].spd.y *= this.damping;
                
                noStroke();
                this.leader.draw();
                this.followers[i].draw();

                stroke(150);
                line(this.leader.pos.x, this.leader.pos.y, this.followers[i].pos.x, this.followers[i].pos.y);
                noStroke();
            } else {
                let deltaX = this.followers[i - 1].pos.x - this.followers[i].pos.x;
                let deltaY = this.followers[i - 1].pos.y - this.followers[i].pos.y;

                // create springing effect
                deltaX *= this.springing;
                deltaY *= this.springing;
                this.followers[i].spd.x += deltaX;
                this.followers[i].spd.y += deltaY;

                this.followers[i].move();

                // slow down springing
                this.followers[i].spd.x *= this.damping;
                this.followers[i].spd.y *= this.damping;

                //this.leader.draw();
                this.followers[i].draw();

                stroke(150);
                line(this.followers[i - 1].pos.x, this.followers[i - 1].pos.y, this.followers[i].pos.x, this.followers[i].pos.y);
                noStroke();

            }
        }
    }

    checkBoundsCollision(bounds) {
        this.leader.checkBoundsCollision(bounds);
        for (let i = 0; i < this.followers.length; i++) {
            this.followers[i].checkBoundsCollision(bounds);
        }
    }
}
