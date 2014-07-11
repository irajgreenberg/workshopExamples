import processing.core.PApplet;


public class Cube extends Shape{

	public Cube(PApplet p, float[] col){
		super(p, col);
		init();
	}

	public Cube(PApplet p,  Vector3 pos, Vector3 rot, Vector3 size){
		super(p, pos, rot, size);
		init();
	}
	public void init(){
		vecs = new Vector3[8];
		vecs[0] = new Vector3(-.5f, .5f, -.5f);
		vecs[1] = new Vector3(.5f, .5f, -.5f);
		vecs[2] = new Vector3(.5f, .5f, .5f);
		vecs[3] = new Vector3(-.5f, .5f, .5f);
		vecs[4] = new Vector3(-.5f, -.5f, -.5f);
		vecs[5] = new Vector3(.5f, -.5f, -.5f);
		vecs[6] = new Vector3(.5f, -.5f, .5f);
		vecs[7] = new Vector3(-.5f, -.5f, .5f);
		
		vecs_orig = new Vector3[8];
		for(int i=0; i<vecs.length; ++i){
			vecs_orig[i] = new Vector3();
			// for resetting transformation state
			vecs_orig[i].setTo(vecs[i]);
		}
		
		indices = new Tuple[12];
		// front left
	    indices[0] = new Tuple(7, 3, 6);
	    // front right
	    indices[1] = new Tuple(6, 3, 2);
	    // right left
	    indices[2] = new Tuple(5, 6, 2);
	    // right right
	    indices[3] = new Tuple(5, 2, 1);
	    // back left
	    indices[4] = new Tuple(4, 5, 1);
	    // back right
	    indices[5] = new Tuple(4, 1, 0);
	    // left left
	    indices[6] = new Tuple(7, 4, 0);
	    // left right
	    indices[7] = new Tuple(7, 0, 3);
	    // top left
	    indices[8] = new Tuple(4, 7, 5);
	    // top right
	    indices[9] = new Tuple(5, 7, 6);
	    // bottom left
	    indices[10] = new Tuple(2, 3, 0);
	    // bottom right
	    indices[11] = new Tuple(0, 1, 2);

	    faces = new Face[12];
	    for (int i=0; i<faces.length; i++) {
	      faces[i] = new Face(vecs[indices[i].elem0], vecs[indices[i].elem1], vecs[indices[i].elem2]);
	    }
	}

}
