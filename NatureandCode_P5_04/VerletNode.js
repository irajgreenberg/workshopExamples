// Verlet Node class
class VerletNode {

	// expects a vector and a number
	constructor(pos, radius, color) {
		this.pos = pos;
		this.radius = radius;
		this.color = color;
		this.radiusOld = this.radius; // no side-effect for primitive variable
		this.posOld = new p5.Vector(pos.x, pos.y); // creating a new address for reference variable
	}

	nudge(offset) {
		this.offset = offset;
		this.pos.add(this.offset);
	}

	//this is where the motion is calculated
	verlet() {
		var posTemp = new p5.Vector(this.pos.x, this.pos.y);

		this.pos.x += (this.pos.x - this.posOld.x);
		this.pos.y += (this.pos.y - this.posOld.y);

		this.posOld.set(posTemp);
	}

	draw() {
		fill(this.color);
		noStroke();
		ellipse(this.pos.x, this.pos.y, this.radius * 2, this.radius * 2);
	}

	boundsCollide(bounds) {
		if (this.pos.x > bounds.x / 2 - this.radius) {
			this.pos.x = bounds.x / 2 - this.radius;
			this.pos.x -= 1;
		}
		else if (this.pos.x < -bounds.x / 2 + this.radius) {
			this.pos.x = -bounds.x / 2 + this.radius;
			this.pos.x += 1;
		}

		if (this.pos.y > bounds.y / 2 - this.radius) {
			this.pos.y = bounds.y / 2 - this.radius;
			this.pos.y -= 1;
		}
		else if (this.pos.y < -bounds.y / 2 + this.radius) {
			this.pos.y = -bounds.y / 2 + this.radius;
			this.pos.y += 1;
		}
	}
} // closes class

