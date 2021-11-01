/*******************************
 * Lindenmayer System Example 01
 * Auto sizing and centering
 * =============================
 * Rules:
 * f : Move forward pen UP
 * F : Move Forward pen DOWN 
 * + : Turn right 90 degs
 * - : Turn left 90 degs
 * 
 * Axiom F
 * initial angle 0 degs
 * initial string: F-F-F-F
 * Rule: F -> F+F-F-F+F
 * 
 * =============================
 * Ira Greenberg, May 14, 2007 
 ******************************/
int subDivideLimit = 2;
int subdivideCount = 0;

char[] rule = {
  'F', '+', 'F', '-', 'F', '-', 'F', '+',  'F'};

// initial char
char[] chars = {
  'F', '-', 'F', '-', 'F', '-', 'F'};
// temp char array
char[] temp = new char[chars.length];

// shape diameter
float totalWidth = 380.0;

// initial angle
float angle = 0;

void setup(){
  size(400, 400);
  background(0);
  fill(255);
  //noStroke();
  strokeWeight(.25);
  smooth();
  translate(width/2, height/2);
  //fill temp array with initial chars
  arraycopy(chars, temp);
  generate(chars);
}

void generate(char[] chars){
  if (subdivideCount++ < subDivideLimit){
    temp = subset(temp, 0, 0);
    for (int i=0, j=0; i<chars.length; i++){
      switch (chars[i]){
      case 'F':
        temp = splice(temp, rule, j);
        j+=rule.length;
        break;
      case 'f':
        break;
      case '+':
        temp = append(temp, '+');
        j++;
        break;
      case '-':
        temp = append(temp, '-');
        j++;
        break;
      }
    }
    generate(temp);
  } 
  else {
    parse(temp);
  }
}


void parse(char[] chars){
  float tempX = 0, tempY = 0;
  float[] x = {};
  float[] y = {};

  beginShape();
  for (int i=0; i<chars.length; i++){
    switch (chars[i]){
    case 'F':
      tempX += cos(angle);
      tempY += sin(angle);
      x = append(x, tempX);
      y = append(y, tempY);
      break;
    case 'f':
      break;
    case '+':
      angle -= PI/2.0;
      break;
    case '-':
      angle += PI/2.0;
      break;
    }
  }

  plot(x, y);
}

void plot( float[] x,  float[] y){
  float[] tempX = new float[x.length];
  float[] tempY = new float[x.length];
  tempX = sort(x);
  tempY = sort(y);
  
  // resize to screen
  float w = tempX[tempX.length-1]-tempX[0];
  float h = tempY[tempY.length-1]-tempY[0];
  float scaleX = totalWidth/w;
  float scaleY = totalWidth/h;
  // center on screen
  float cx = (tempX[tempX.length-1]+tempX[0])/2.0;
  float cy = (tempY[tempY.length-1]+tempY[0])/2.0;

  beginShape();
  for (int i=0; i<x.length; i++){
    vertex((x[i]-cx)*scaleX, (y[i]-cy)*scaleY);
  }
  endShape();
}

