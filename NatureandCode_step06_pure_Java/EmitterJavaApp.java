// Ira Greenberg
// Nature & Code
// Center of Creative Computation | SMU
// August 18, 2021

// Description:
// Simple particle system utilizing
// an image particle with
// orientation based on its
// movement vector.

// Note:
// Image removed due to P2D incompatibility
// with newer versions of Java (16). Arrow
// drawn with vertex() calls

// Step 06 - Pure Java, outside the Processing mothership

import processing.core.*;

public class EmitterJavaApp extends PApplet {
    static float gravity = .03f; // global environmental variable
    Emitter e;

    public void setup() {
        e = new Emitter(this, 10000, new PVector(2, 12), new PVector(width / 2, height / 8), new PVector(.5f, 2), 4);
    }

    public void draw() {
        // fading background for some sizzzle
        fill(0, 165);
        rect(-1, -1, width + 2, height + 2);
        e.run();
    }

    public void settings() {
        size(1024, 768);
    }

    static public void main(String[] passedArgs) {
        String[] appletArgs = new String[] { "EmitterJavaApp" };
        if (passedArgs != null) {
            PApplet.main(concat(appletArgs, passedArgs));
        } else {
            PApplet.main(appletArgs);
        }
    }
}
