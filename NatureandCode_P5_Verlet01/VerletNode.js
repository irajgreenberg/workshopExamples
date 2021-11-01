// Verlet Node class
class VerletNode {

	// expects a vector and a number
	constructor(pos, radius) {
		this.pos = pos;
		this.radius = radius;
		this.radiusOld = this.radius; //no side-effect
		this.posOld = new p5.Vector(pos.x, pos.y); // creating a new address
		//this.posOld = pos; // problem we would have a side-effect
		console.log("pos = ", pos);
	}

	nudge(offset) {
		this.offset = offset;
		this.pos.add(this.offset);
	}

	//this is where the motion is calculated
	verlet() {
		let posTemp = new p5.Vector(this.pos.x, this.pos.y);

		this.pos.x += (this.pos.x - this.posOld.x);
		this.pos.y += (this.pos.y - this.posOld.y);

		this.posOld.set(posTemp);
	}

	display() {
		ellipse(this.pos.x, this.pos.y, this.radius * 2, this.radius * 2);
	}

	boundsCollide(bounds) {
		if (this.pos.x > bounds.x / 2 - this.radius) {
			this.pos.x = bounds.x / 2 - this.radius;
			this.pos.x -= this.offset.x;
		}
		else if (this.pos.x < -bounds.x / 2 + this.radius) {
			this.pos.x = -bounds.x / 2 + this.radius;
			this.pos.x += this.offset.x;
		}

		if (this.pos.y > bounds.y / 2 - this.radius) {
			this.pos.y = bounds.y / 2 - this.radius;
			this.pos.y -= this.offset.y;
		}
		else if (this.pos.y < -bounds.y / 2 + this.radius) {
			this.pos.y = -bounds.y / 2 + this.radius;
			this.pos.y += this.offset.y;
		}
	}
} // closes class

