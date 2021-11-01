
public class Vector4 {
	
	public float x, y, z, w;
	
	// cstr
	public Vector4(){
	}
	
	// cstr
	public Vector4(float x, float y, float z, float w){
		this.x = x;
		this.y = y;
		this.z = z;
		this.w = w;
	}
	
	// cstr
	public Vector4(Vector3 v){
		x = v.x;
		y = v.y;
		z = v.z;
		w = 1;
	}

}
