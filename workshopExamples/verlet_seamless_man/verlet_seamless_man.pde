/* notes
 f = gravity--
 g = gravity ++
 left, right, down, up = perturb dancers
 r or mouse press = rest
 */



import oscP5.*;
import netP5.*;

VerletMan[] vm = new VerletMan[2];
color[] fills = new color[2];
float xScale = 360.2;
float yScale = 360.2;


// osc stuff
OscP5 oscP5;
NetAddress myRemoteLocation;
//String[] maxVarNames = {
//"noteID", "noteVel, noteFreq"
//};
int noteID = -1;
float noteVel, noteFreq;


//String[] maxVarNames2 = {
// "noteID2", "noteVel2, noteFreq2"
//};
int noteID2 = -1;
float noteVel2, noteFreq2;

// event Control
int selectionID;

boolean isNetworked = true;

void setup() {
  size(1500, 1070, P3D);
  background(200, 0, 0);
  strokeWeight(1);
  //PVector loc, float w, float h, int bodyType
  fills[0] = color(105, 0, 0);
  fills[1] = color(255, 255, 0);
  for (int i=0; i<vm.length; i++) {
    vm[i] = new VerletMan(new PVector(-.25 +i*.5, 0), 1.0/5.0, 1.0, VerletMan.FLEXIBLE);
    vm[i].initRandomMotion();
    // vm[i].setArmatureVisible(true);
    vm[i].setBodyVisible(true);
    vm[i].setSkeletonVisible(true);
  }
  startOSC();
}

void draw() {
  //background(200, 200, 255);
  //background(200, 0, 0);
  fill(200, 0, 0, 75);
  rect(-1, -1, width+1, height+1);


  translate(width/2, height/2, 500);
  pushMatrix();
  scale(xScale, yScale);
  //rotateY(frameCount*PI/720);
  //noStroke();
  fill(105, 0, 0);
  //noFill();
  //noStroke();



  for (int i=0; i<vm.length; i++) {
    vm[i].run();
    fill(fills[i]);
    vm[i].draw();
    //vm[i].nudge(int(random(4)), random(.002));
    //vm[i].edgeCollide(xScale, yScale);
  }
  popMatrix();
}


void startOSC() {
  //start oscP5
  oscP5 = new OscP5(this, 12002);
  //myRemoteLocation = new NetAddress("127.0.0.1", 12000);
}

void oscEvent(OscMessage theOscMessage) {
 
  if (theOscMessage.checkAddrPattern("/jamPactL")==true) {
   println("In jamPactL");
    noteID = theOscMessage.get(0).intValue();
    noteVel = theOscMessage.get(1).intValue();
    noteFreq = theOscMessage.get(2).floatValue();

    vm[0].midiMapNudge(noteID, noteVel*.002);
  }

  if (theOscMessage.checkAddrPattern("/jamPactR")==true) {
    println("In jamPactR");
    noteID2 = theOscMessage.get(0).intValue();
    noteVel2 = theOscMessage.get(1).intValue();
    noteFreq2 = theOscMessage.get(2).floatValue();

    vm[1].midiMapNudge(noteID2, noteVel2*.005);
  }
  
}

 
 
void keyPressed() {
  if (key == 'r') {
    for (int i=0; i<vm.length; i++) {
      vm[i].reset();
    }
  } 
  else if (key =='v') {
    for (int i=0; i<vm.length; i++) {
      vm[i].setArmatureVisible(true);
    }
  } else if (key =='i') {
    for (int i=0; i<vm.length; i++) {
      vm[i].setArmatureVisible(false);
    }
  } 
  else if (key =='f') {
    for (int i=0; i<vm.length; i++) {
      vm[i].setGravity(0);
    }
  } 
  else if (key =='g') { 
    for (int i=0; i<vm.length; i++) {
      vm[i].setGravity(1);
    }
  }
  else if (key == CODED) {
    if (keyCode == RIGHT) {
      for (int i=0; i<vm.length; i++) {
        vm[i].nudge(0, .12);
      }
    } 
    else if (keyCode == LEFT) {
      for (int i=0; i<vm.length; i++) {
        vm[i].nudge(1, .12);
      }
    } 

    // zoom via scale
    else if (keyCode == UP) {
      for (int i=0; i<vm.length; i++) {
        //vm[i].nudge(2, .12);
        xScale = yScale *= 1.01;
      }
    } 
    else if (keyCode == DOWN) {

      for (int i=0; i<vm.length; i++) {
        //vm[i].nudge(3, .12);
        xScale = yScale *= .99;
      }
    }
  }
}

void mousePressed() {
  for (int i=0; i<vm.length; i++) {
    vm[i].reset();
  }
}

