import processing.core.PApplet;

public abstract class Shape {

	public PApplet p;
	public Vector3 pos, rot, size;

	public Vector3[] vecs;
	public Vector3[] vecs_orig;
	public Vector3[] transformedVecs;
	public Face[] faces;
	public Tuple[] indices;
	public float[] col = {.7f, .7f, .7f, 1};

	public Shape(){
	}
			
	public Shape(PApplet p, float[] col) {
		this.col = col;
		this.p = p;
	}

	public Shape(PApplet p, Vector3 pos, Vector3 rot, Vector3 size) {
		this.p = p;
		this.pos = pos;
		this.rot = rot;
		this.size = size;
	}

	// derived classes must implement this
	public abstract void init();


	// Requires separate model, view and projection matrices
	// AND order of vertices are multiplied by matrices is
	// in opposite order matrices are multiplied (concatenated) together
	public void display(Matrix4 m, Matrix4 v, Matrix4 pr) {
		transformedVecs = new Vector3[vecs.length];
		for(int i=0; i<vecs.length; ++i){

			
			Vector4 tv = m.mult(new Vector4(vecs[i]));
			System.out.println("tv.z 01 = " + tv.z);
			System.out.println("tv.w 01 = " + tv.w);
			tv = v.mult(tv);
			System.out.println("tv.z 02 = " + tv.z);
			System.out.println("tv.w 02 = " + tv.w);
			tv = pr.mult(tv);
			System.out.println("tv.z 03 = " + tv.z);
			System.out.println("tv.w 03 = " + tv.w);
			
			// convert to normalized screen space
			tv.x = tv.x/tv.w;
			tv.y = tv.y/tv.w;
			tv.z = tv.z/tv.w;
			
			tv.x = tv.x*.5f + .5f;
			tv.y = tv.y*.5f + .5f;
			tv.z = tv.z*.5f + .5f;
			
			// scale to viewport (usually window size)
			tv.x = tv.x*p.width + 0;
			tv.y = tv.y*p.height + 0;

			transformedVecs[i] = new Vector3(tv);
		}
		
		// update faces
		for (int i=0; i<faces.length; i++) {
			faces[i].v0 = transformedVecs[indices[i].elem0];
			faces[i].v1 = transformedVecs[indices[i].elem1];
			faces[i].v2 = transformedVecs[indices[i].elem2];
		}
		
		// sort depth based on normal.z
		depthSort();
		
		// draw individual faces
		for (int i = 0; i < faces.length; ++i) {
			faces[i].display(p, col);
		}
	}
	
	public void display(Matrix4 MVP, Light light0, float[] ambientLight) {
		// transform vecs and build faces
		transformedVecs = new Vector3[vecs.length];
		Vector3[] deviceNormalizedVecs = new Vector3[vecs.length];
		
		for(int i=0; i<vecs.length; ++i){
			Vector4 tv = MVP.mult(new Vector4(vecs[i]));
			transformedVecs[i] = new Vector3(tv); // vecs in world space
			
			tv.x = tv.x/tv.w;
			tv.y = tv.y/tv.w;
			tv.z = tv.z/tv.w;
			
			// convert to normalized screen space
			tv.x = tv.x*.5f + .5f;
			tv.y = tv.y*.5f + .5f;
			tv.z = tv.z*.5f + .5f;
			
			tv.x = tv.x*p.width + 0;
			tv.y = tv.y*p.height + 0;
			
			deviceNormalizedVecs[i] = new Vector3(tv); // vecs in device space
		}
		
		// update faces
		for (int i=0; i<faces.length; i++) {
			
			// lighting
			Face face = new Face(transformedVecs[indices[i].elem0], transformedVecs[indices[i].elem1], transformedVecs[indices[i].elem2]);
			Vector3 N = face.getNormal();
			Vector3 L = new Vector3();
			L.setTo(face.v0);
			L.sub(light0.pos);
			N.normalize();
			L.normalize();
			float diffuseIntensity = L.dot(N);
			

			faces[i].setLighting(diffuseIntensity, ambientLight, light0.col);
			
			// fill faces with normalized screen coords
			faces[i].v0 = deviceNormalizedVecs[indices[i].elem0];
			faces[i].v1 = deviceNormalizedVecs[indices[i].elem1];
			faces[i].v2 = deviceNormalizedVecs[indices[i].elem2];
		}
		
		// sort depth based on normal.z
		depthSort();
		
		// draw individual faces
		for (int i = 0; i < faces.length; ++i) {
			faces[i].display(p, col);
		}
	}
	
	// Requires separate model, view and projection matrices
		// AND order of vertices are multiplied by matrices is
		// in opposite order matrices are multiplied (concatenated) together
		public void display(Matrix4 m, Matrix4 v, Matrix4 pr, Light light0) {
			transformedVecs = new Vector3[vecs.length];
			for(int i=0; i<vecs.length; ++i){
				Vector4 tv = m.mult(new Vector4(vecs[i])); // model matrix
				tv = v.mult(tv); // view matrix
				tv = pr.mult(tv); // projection matrix
				
				// convert to normalized screen space
				tv.x = tv.x/tv.w;
				tv.y = tv.y/tv.w;
				tv.z = tv.z/tv.w;
				
				tv.x = tv.x*.5f + .5f;
				tv.y = tv.y*.5f + .5f;
				tv.z = tv.z*.5f + .5f;
				
				// scale to viewport (usually window size)
				tv.x = tv.x*p.width + 0;
				tv.y = tv.y*p.height + 0;

				transformedVecs[i] = new Vector3(tv);
			}
			
			// update faces
			for (int i=0; i<faces.length; i++) {
				faces[i].v0 = transformedVecs[indices[i].elem0];
				faces[i].v1 = transformedVecs[indices[i].elem1];
				faces[i].v2 = transformedVecs[indices[i].elem2];
			}
			
			// sort depth based on normal.z
			depthSort();
			
			// draw individual faces
			for (int i = 0; i < faces.length; ++i) {
				faces[i].display(p, col);
			}
		}


	public void transform(Matrix4 transform) {
		for (int i = 0; i < vecs.length; ++i) {
			Vector4 v = new Vector4(vecs[i]);
			v = transform.mult(v);
			vecs[i].x = v.x;
			vecs[i].y = v.y;
			vecs[i].z = v.z;
		}
	}

	public void reset(){
		for (int i = 0; i < vecs.length; ++i) {
			vecs[i].setTo(vecs_orig[i]);
		}
	}

	// bubble sort code from:
	// http://www.leepoint.net/notes-java/data/arrays/32arraybubblesort.html
	// http://stackoverflow.com/questions/14768010/simple-bubble-sort-c-sharp
	private void depthSort() {
		Face temp = new Face();
		for (int i = 0; i < faces.length; ++i) {
			for (int j = 0; j < faces.length-1; ++j) {
				if (faces[j].getNormal().z > faces[j+1].getNormal().z){
					temp = faces[j + 1];
					faces[j + 1] = faces[j];
					faces[j] = temp;
				}
			}
		}
	}

}
