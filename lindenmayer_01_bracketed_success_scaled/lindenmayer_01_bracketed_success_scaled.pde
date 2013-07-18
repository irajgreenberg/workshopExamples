/*******************************
 * Lindenmayer System Example 01
 * Bracketed Tree
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
 * Rule: F -> F+F-F-FF+F+F-F
 * 
 * =============================
 * Ira Greenberg, May 22, 2007 
 ******************************/
int subDivideLimit = 5;
int subdivideCount = 0;

// axiom
char[] chars = {
  'F'};
// temp char array
char[] temp = new char[chars.length];

float[] xx = new float[0];
float[] yy = new float[0];


// substitution rule
char[] rule = {
  'F', '[', '+', 'F', ']', 'F', '[', '-', 'F', ']', 'F' };


// shape diameter
float totalWidth = 180.0;
float totalHeight = 380.0;

// initial angle
float angle = PI/2.0;

// initial angle
float rotAngle = PI/6.0;

float turtleX, turtleY;


void setup(){
  size(600, 600);
  background(255);
  smooth();
  translate(width/2, height/2);

  //fill temp array with initial chars
  turtleX = 0;
  turtleY = height/2.0;
  strokeWeight(.75);
  arraycopy(chars, temp);
  generate(chars);
}

void generate(char[] chars){
  println("");
  println("chars");
  if (subdivideCount++ < subDivideLimit){
    // clear temp each iteration
    temp = subset(temp, 0, 0);
    for (int i=0, j=0; i<chars.length; i++){
      print(chars[i]);
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
      case '[':
        temp = append(temp, '[');
        j++;
        break;
      case ']':
        temp = append(temp, ']');
        j++;
        break;
      }
    }
    generate(temp);
  } 
  else {
    for (int i=0; i<chars.length; i++){
      //print(chars[i]);
    }
    parse(turtleX, turtleY, temp, angle);
  }
}


// recursively called to parse string and draw 
void parse(float x, float y, char[] chars, float angle){
  char[][] tempChars = new char[0][0];
  float[] tempX = {
  }
  , tempY = {
  }
  , tempAngle = {
  };
  int openBracketCount = 0, closeBracketCount = 0;
  int bracketPairCount = 0;
  boolean isBracketed = false;
  beginShape();
 // vertex(x, y);
  xx = append(xx, x);
  yy = append(yy, y);
  for (int i=0; i<chars.length; i++){
    switch (chars[i]){
    case 'F':
      if(!isBracketed){
        x+=cos(angle)*random(1, 5)+random(-2, 2);
        y-=sin(angle)*random(1, 2)+random(-2, 2);
      //  vertex(x, y);
          xx = append(xx, x);
          yy = append(yy, y);
      } 
      else {
        tempChars[bracketPairCount] = append(tempChars[bracketPairCount], 'F');
      }
      break;
    case 'f':
      break;
    case '+':
      if(!isBracketed){
        angle += rotAngle;
      } 
      else {
        tempChars[bracketPairCount] = append(tempChars[bracketPairCount], '+');
      }
      break;
    case '-':
      if(!isBracketed){
        angle -= rotAngle;
      } 
      else {
        tempChars[bracketPairCount] = append(tempChars[bracketPairCount], '-');
      }
      break;
    case '[':
      ++openBracketCount;
      if (openBracketCount == 1){
        isBracketed = true;
        tempX = append(tempX, x);
        tempY = append(tempY, y);
        tempAngle = append(tempAngle, angle);
        tempChars = (char[][])append(tempChars, new char[]{
        }
        );
      }
      else {
        tempChars[bracketPairCount] = append(tempChars[bracketPairCount], '[');
      }
      break;
    case ']':
      ++closeBracketCount;
      if (openBracketCount == closeBracketCount){
        isBracketed = false;
        ++bracketPairCount;
        // reset
        closeBracketCount = openBracketCount = 0;
      } 
      else {
        tempChars[bracketPairCount] = append(tempChars[bracketPairCount], ']');
      }
      break;
    }
  }
  endShape();
  for (int i=0; i<bracketPairCount; i++){
    if (tempChars[i].length>0){
      parse(tempX[i], tempY[i], tempChars[i], tempAngle[i]);
    }
  }
  drawToScale();
}


void drawToScale(){
  beginShape();
  for (int i=0; i<xx.length; i++){
    vertex(xx[i], yy[i]);
  }
  endShape();
}
