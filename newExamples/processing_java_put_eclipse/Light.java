
public class Light {
	
	Vector3 pos = new Vector3();
	float[] col = {1, 1, 1};
	
	public Light(){	
	}
			
	public Light(Vector3 pos, float[] col){
		this.pos = pos;
		this.col = col;
	}

}
