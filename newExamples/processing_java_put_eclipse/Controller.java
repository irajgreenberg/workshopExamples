

import processing.core.PApplet;

import java.util.Arrays;

public class Controller extends PApplet {


	Shape cube, cube2;
	Toroid toroid, toroid2;
	Light light0;
	Renderer renderer;

	public void setup() {
		size(800, 600, P2D);
		smooth(8);
		noStroke();
		fill(.5f, 1);
		cube = new Cube(this, new float[]{.4f, .4f, .4f});
		cube2 = new Cube(this, new float[]{.4f, .4f, .4f});


		toroid = new Toroid(this, new float[]{.7f, .4f, .4f}, 25, 25,.2f, .2f);
		toroid2 = new Toroid(this, new float[]{.0f, .4f, .8f}, 16, 16,.1f, .4f);
		
		
		light0 = new Light(new Vector3(-5, 0, 100), new float[]{.3f, .6f, .6f});
		renderer = Renderer.getInstance(this);
		renderer.setAmbientLight(new float[]{0, 0, 0});
	}

	public void draw(){
		background(0);
//		renderer.translate(new Vector3(2, 3, -40));
//		renderer.rotate(new Vector3(0, -frameCount*PI/180, -frameCount*PI/360));
//		renderer.scale(new Vector3(5, 5, 5));
//		renderer.display(cube2);
		
//		renderer.translate(new Vector3(2, 3, 40));
//		renderer.rotate(new Vector3(0, -frameCount*PI/180, frameCount*PI/360));
//		renderer.scale(new Vector3(20, 30, 20));
//		renderer.display(toroid2);
		
		renderer.add(light0); // no implemented
		renderer.translate(new Vector3(2, 3, 40));
		renderer.rotate(new Vector3(0, frameCount*PI/180, -frameCount*PI/360));
		renderer.scale(new Vector3(30, 40, 30));
		renderer.display(toroid);
		
		
		
		
	}

	public static void main(String args[]) {
		PApplet.main(new String[] {"Controller" });

	}


}
