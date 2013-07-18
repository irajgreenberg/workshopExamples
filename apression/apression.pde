/** 
 *
 ********************************
 *****REQUIRES Processing 1.5****
 ********************************
 *
 Verlet Sheet Example
 * Prototype for "Ripple in Time" App
 * By: Ira Greenberg 
 * December 2010
 */

import processing.opengl.*;
import oscP5.*;
import netP5.*;

VerletSurface surf;
VerletEngine eng;
int sphereCount = 30;
IGSphere[] spheres = new IGSphere[sphereCount];

// z = -100
float xShift = 850, yShift = -450, zShift = -6500; 
float xShiftSpd, yShiftSpd, zShiftSpd;

float rotX, rotY, rotZ, rotXTheta, rotYTheta, rotZTheta;

int counter = 0;

// osc stuff
OscP5 oscP5;
NetAddress myRemoteLocation;
String[] maxVarNames = {
  "noteID", "noteVel, noteFreq"
};
int noteID = 0;
float noteVel, noteFreq;

int surfRows = 20;
int surfCols = 20;
int noteCount = 225;
float nodeMappingRatio = surfRows*surfCols / noteCount;


void setup() {
  size(1200, 900, P3D);
  //background(255);
  //background(loadImage("sky_600.jpg"));
  rotX = -75*PI/180.0;

  noFill();
  stroke(200, 30);
  strokeWeight(4);
  boolean[] edgeFlags = {
    true, true, true, true
  };
  surf = new VerletSurfaceRect(new PVector(), new Dimension3D(8600, 0, 8500), surfRows, surfCols, edgeFlags, .999/*.45*/);
  for (int i=0; i<sphereCount; i++) {
    spheres[i] = new IGSphere(new PVector(random(-80, 80), -500+random(0, 15), -100+random(-80, 80)), random(3, 13), 8, .75 );
  }
  eng = new VerletEngine(surf, spheres);

  VerletBall[] vBalls = surf.getVBalls();
  for (int i=0; i<vBalls.length; i++) {
    //println(vBalls[i].pos);
  }

  //start oscP5
  //  oscP5 = new OscP5(this, 12002);
  //  myRemoteLocation = new NetAddress("127.0.0.1", 12000);
} 

void draw() {
  //background(loadImage("sky_600.jpg"));
  background(0);
  lights();
  xShift += xShiftSpd;
  yShift += yShiftSpd;
  zShift += zShiftSpd;
  translate(xShift, yShift, zShift);
  rotX += rotXTheta;
  rotY += rotYTheta;
  rotZ += rotZTheta;
  rotateX(rotX);
  rotateY(rotY);
  rotateZ(rotZ);
  eng.run();


  /* PVector[]  vNorms = surf.getVNorms();
   for(int i=0; i<vNorms.length; i++) {
   println(vNorms[i]);
   }
   */
  // if (millis()%10 == 0) {
  // 50, 20
  //surf.applyForce(int(random(width)), int(random(height)), 500, 2);
  //surf.applyForce(100, 100, 800, 5);
  //}
}

void keyPressed() {
  //surf.applyForce(800, 100, 1500, 2);
  // steer images
  if (key == CODED) {
    if (keyCode == LEFT)
      xShiftSpd-=.1;

    else  if (keyCode == UP)
      yShiftSpd-=.1;

    else  if (keyCode == RIGHT)
      xShiftSpd+=.1;

    else  if (keyCode == DOWN) 
      yShiftSpd+=.1;
  } 
  else if (key == '/') {
    zShiftSpd-=.1;
  } 
  else if (key == '.') {
    zShiftSpd+=.1;
  } 
  else if (key == 'q') {
    rotXTheta += .05*PI/180;
  } 
  else if (key == 'w') {
    rotXTheta -= .05*PI/180;
  }
  else if (key == 'a') {
    rotYTheta += .05*PI/180;
  } 
  else if (key == 's') {
    rotYTheta -= .05*PI/180;
  } 
  else if (key == 'z') {
    rotZTheta += .05*PI/180;
  } 
  else if (key == 'x') {
    rotZTheta -= .05*PI/180;
  }





  // change images
  if (key == '0') {
    surf.imgReset(0);
  } 
  else if (key == '1') {
    surf.imgReset(1);
  } 
  else if (key == '2') {
    surf.imgReset(2);
  } 
  else if (key == '3') {
    surf.imgReset(3);
  } 
  else if (key == '4') {
    surf.imgReset(4);
  }
  else if (key == '5') {
    surf.imgReset(5);
  }  
  else if (key == '6') {
    surf.imgReset(6);
  } 
  else if (key == '7') {
    surf.imgReset(7);
  }
  else if (key == '8') {
    surf.imgReset(8);
  }
  else if (key == '9') {
    surf.imgReset(9);
  }
}

void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.checkAddrPattern("/jamPactHiRes")==true) {
    if (counter++%223 ==0) {

      noteID = theOscMessage.get(1).intValue(); // 0-224
      noteFreq = theOscMessage.get(2).floatValue(); // 0-1 
      noteVel = theOscMessage.get(3).floatValue(); // 0-1
      println("noteID = " + noteID);
      println("noteFreq = "  + noteFreq);
      println("noteVel = " + noteVel);
    }
  } 


  //println("noteID = " + noteID);
  if (noteVel != 0) {
    //surfRows, surfCols
    int mappedNode = int(noteID*nodeMappingRatio);
    //println("mappedNode = " + mappedNode);
    float x = mappedNode/surfRows;
    float y = mappedNode/surfCols;
    // println("x = " + x);
    //println("y = " + y);
    float xCoord = width/surfCols * x;
    float yCoord = height/surfRows * y;

    /* println("noteID = " + noteID);
     println("noteVel = " + noteVel);
     println("noteFreq = " + noteFreq);
     println("xCoord = " + xCoord);
     println("yCoord = " + yCoord);*/

    surf.applyForce(int(xCoord), int(yCoord), noteVel*1500, noteFreq);

    /*isNoteOn[noteID] = true;
     keys[noteID].damping = 1.0;
     keys[noteID].freq = noteFreq;
     keys[noteID].vel = noteVel;*/
  } 
  else {
    //isNoteOn[noteID] = false;
    // keys[noteID].damping = .85;
  }
}

void mousePressed() {
  surf.applyForce(mouseX, mouseY, 5500, 200);
}

