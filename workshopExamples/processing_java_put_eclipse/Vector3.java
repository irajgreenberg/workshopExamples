public class Vector3 {
	
	public float x, y, z;

	// cstr
	public Vector3(){
	}
	
	// cstr
	public Vector3(float x, float y, float z){
		this.x=x;
		this.y=y;
		this.z=z;
	}
	
	// cstr
		public Vector3(Vector4 v){
			x=v.x;
			y=v.y;
			z=v.z;
		}
	
	public void add(Vector3 v){
		x+=v.x;
		y+=v.y;
		z+=v.z;
	}
	
	public void add(float s){
		x+=s;
		y+=s;
		z+=s;
	}
	
	public void sub(Vector3 v){
		x-=v.x;
		y-=v.y;
		z-=v.z;
	}
	
	public void sub(float s){
		x-=s;
		y-=s;
		z-=s;
	}
	
	public float mag(){
		return (float)Math.sqrt(x*x + y*y + z*z);
	}
	
	public void mult(float s){
		x*=s;
		y*=s;
		z*=s;
	}
	
	public float dot(Vector3 v){
		return x*v.x+y*v.y+z*v.z;
	}
	
	public Vector3 cross(Vector3 v){
		// unnormalized
		return new Vector3(y*v.z - z*v.y, z*v.x - x*v.z, x*v.y - y*v.x);
	}
	
	public void setTo(Vector3 v){
		x = v.x;
		y = v.y;
		z = v.z;
	}
	
	public float getAngle(Vector3 v){
		Vector3 t1 = new Vector3();
		Vector3 t2 = new Vector3();
		t1.setTo(this);
		t1.normalize();
		t2.setTo(v);
		t2.normalize();
		return (float)Math.acos(t1.dot(t2));
	}
	
	public void normalize(){
		float m = mag();
		x/=m;
		y/=m;
		z/=m;
	}
	
	public void invert(){
		mult(-1);
	}
	
}
