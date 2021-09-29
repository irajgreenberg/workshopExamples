// Verlet Node class
class VerletNode {

	// expects a vector and a number
	constructor(pos, radius, color) {
		this.pos = pos;
		this.radius = radius;
		this.color = color;
		this.radiusOld = this.radius; // no side-effect for primitive variable
		this.posOld = new p5.Vector(pos.x, pos.y, pos.z); // creating a new address for reference variable
	}

	nudge(offset) {
		this.offset = offset;
		this.pos.add(this.offset);
	}

	//this is where the motion is calculated
	verlet() {
		var posTemp = new p5.Vector(this.pos.x, this.pos.y, this.pos.z);

		this.pos.x += (this.pos.x - this.posOld.x);
		this.pos.y += (this.pos.y - this.posOld.y);
		this.pos.z += (this.pos.z - this.posOld.z);

		this.posOld.set(posTemp);
	}

	draw() {
		fill(this.color);
		noStroke();
		push();
		translate(this.pos.x, this.pos.y, this.pos.z);
		sphere(this.radius * 2)
		pop();
	}
	
	setStyle(radius, color){
		this.color = color;
		this.radius = radius;
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

		if (this.pos.z > bounds.z / 2 - this.radius) {
			this.pos.z = bounds.z / 2 - this.radius;
			this.pos.z -= 1;
		}
		else if (this.pos.z < -bounds.z / 2 + this.radius) {
			this.pos.z = -bounds.z / 2 + this.radius;
			this.pos.z += 1;
		}
	}
} // closes class

