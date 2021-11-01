import java.util.ArrayList;

import processing.core.PApplet;



// singleton pattern
// From: http://www.javaworld.com/article/2073352/core-java/simply-singleton.html
public class Renderer {

	private static PApplet p;
	public int ctr;
	private static Renderer renderer = null;

	private static Matrix4 scaleMatrix;
	private static Matrix4 rotateMatrix;
	private static Matrix4 translateMatrix;
	private static Matrix4 modelMatrix;
	private static float[] viewport = {0, 0, 800, 600};

	// matrix stack
	private static ArrayList<Matrix4> matrixStack;
	private static ArrayList<Shape> shapes;
	private static boolean isStackActive = false;
	
	private static Light light0 = new Light();
	private static float[] ambientLight = {.2f, .2f, .2f};
	
	// triangle for testing
//	Vector4[] vecs = { new Vector4((float)(Math.cos(0)*1.5), (float)(Math.sin(0)*1.5), 0, 1), 
//						new Vector4((float)(Math.cos(120*Math.PI/180.0)*1.5), (float)(Math.sin(120*Math.PI/180.0)*1.5), 0, 1),
//						new Vector4((float)(Math.cos(240*Math.PI/180.0)*1.5), (float)(Math.sin(240*Math.PI/180.0)*1.5), 0, 1) };

	// avoid instantiation
	protected Renderer() {
	}

	public static void add(Light light){
		Renderer.light0 = light0;
	}
	
	public static Renderer getInstance(PApplet p) {
		
		Renderer.p = p;
		if(renderer == null) {
			renderer = new Renderer();
			
			// initialize stacks;
			matrixStack = new ArrayList<Matrix4>();
			
			initMatrices();
		}
		
		return renderer;
	}
	
	public static void setViewport(float x, float y, float w, float h){
		viewport[0] = x;
		viewport[1] = y;
		viewport[2] = w;
		viewport[3] = h;
	}
	
	// overloaded
	public static void setViewport(float[] viewport){
		Renderer.viewport = viewport;
	}
	
	
	// set all matrices to identity
	private static void initMatrices(){
		scaleMatrix = Matrix4.getIdentity();
		rotateMatrix = Matrix4.getIdentity();
		translateMatrix = Matrix4.getIdentity();
		modelMatrix = Matrix4.getIdentity();
	}

	public void push(){	
		isStackActive = true;
		//if(isStackActive){
			Matrix4 tm = new Matrix4();
			tm.setTo(modelMatrix);
			matrixStack.add(tm);
		//}
	}

	public void pop(){
		if(isStackActive){
			modelMatrix.setTo(matrixStack.get(matrixStack.size()-1));
			matrixStack.remove(matrixStack.size()-1);
		}
		isStackActive = false;
		initMatrices();
	}

	public void scale(Vector3 v){
		scaleMatrix = Matrix4.getScale(v);
		updateTransform();
	}
	
	public void rotate(Vector3 v){
		rotateMatrix = Matrix4.getRotate(v);
		updateTransform();
	}
	
	public void translate(Vector3 v){
		translateMatrix = Matrix4.getTranslate(v);
		updateTransform();
	}
	
	private void updateTransform(){
		Matrix4 T = translateMatrix.mult(rotateMatrix);
		modelMatrix = T.mult(scaleMatrix);
	}
	
	public void setAmbientLight(float[] ambientLight){
		Renderer.ambientLight = ambientLight;
	}
	
	public void display(Shape shape){
		
		// create view Matrix
		Matrix4 viewMatrix = Matrix4.getLookAt(new Vector3(0, 0, 100), new Vector3(0, 0, 0), new Vector3(0, 1, 0));
		//viewMatrix.printMatrix("View");
		// create perspective matrix
		Matrix4 perspectiveMatrix = Matrix4.getPerspective(65, p.width/p.height, .1f, 500); // use degrees for fov
		// other option is to use Frustum
		//Matrix4 perspectiveMatrix = Matrix4.getFrustum(-2, 2, -1.5f, 1.5f, 1, 40, Matrix4.Projection.PERSPECTIVE);		
		
		// concatenated MVP matrix no lighting
		Matrix4 MVP = new Matrix4(1); // create new matrix set to identity
		MVP = MVP.mult(perspectiveMatrix);
		MVP = MVP.mult(viewMatrix);
		MVP = MVP.mult(modelMatrix);
		shape.display(MVP, light0, ambientLight);
		
		// 3 separate matrices no lighting
		// this should be refactored!!
		//shape.display(modelMatrix, viewMatrix, perspectiveMatrix, light0);
	}

}












