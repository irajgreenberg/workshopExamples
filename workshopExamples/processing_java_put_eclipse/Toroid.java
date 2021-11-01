import processing.core.PApplet;


public class Toroid extends Shape{

	private int slices, detail;
	private float ringRadius, toroidRadius;

	public Toroid(){
	}

	public Toroid(PApplet p,  float[] col, int slices, int detail, float ringRadius, float toroidRadius){
		super(p, col);
		this.slices = slices;
		this.detail = detail;
		this.ringRadius = ringRadius;
		this.toroidRadius = toroidRadius;
		init();
	}
	public void init(){
		vecs = new Vector3[slices*detail];
		vecs_orig = new Vector3[slices*detail];
		float theta = 0;
		float phi = 0;
		for(int i=0; i<detail; ++i){
			float x = (float)(toroidRadius + Math.cos(theta)*ringRadius);
			float y = (float)(0 + Math.sin(theta)*ringRadius);
			float z = 0;
			for(int j=0; j<slices; ++j){
				/*
				 * z' = z*cos q - x*sin q
				 * x' = z*sin q + x*cos q
				 */
				vecs[i*slices+j] = new Vector3((float)(z*Math.sin(phi) + x*Math.cos(phi)),  y, (float)(z*Math.cos(phi) - x*Math.sin(phi)));
				phi += Math.PI*2.0f/slices;
			}
			theta += Math.PI*2.0f/detail;
		}

		for(int i=0; i<vecs.length; ++i){
			vecs_orig[i] = new Vector3();
			// for resetting transformation state
			vecs_orig[i].setTo(vecs[i]);
		}

		int faceCount = slices*detail*2;
		indices = new Tuple[faceCount];

		for(int i=0, ctr = 0; i<detail; ++i){
			for(int j=0; j<slices; ++j){
				int k = i*slices+j;
				int l = i*slices+j+1;
				int m = (i+1)*slices+j;
				int n = (i+1)*slices+j+1;
				if (i<detail-1) {
					if(j<slices-1){
						indices[ctr++] = new Tuple(k, n, l);
						indices[ctr++] = new Tuple(k, m, n);
					} else {
						indices[ctr++] = new Tuple(k, (i+1)*slices, i*slices);
						indices[ctr++] = new Tuple(k, m, (i+1)*slices);
					}
				} else {
					if(j<slices-1){
						indices[ctr++] = new Tuple(k, 0*slices+j+1, l);
						indices[ctr++] = new Tuple(k, 0*slices+j, 0*slices+j+1);
					} else {
						indices[ctr++] = new Tuple(k, 0, i*slices);
						indices[ctr++] = new Tuple(k, 0*slices+j, 0);
					}
				}
			}
		}

		faces = new Face[indices.length];
		for (int i=0; i<faces.length; i++) {
			faces[i] = new Face(vecs[indices[i].elem0], vecs[indices[i].elem1], vecs[indices[i].elem2]);
		}
	}

}
