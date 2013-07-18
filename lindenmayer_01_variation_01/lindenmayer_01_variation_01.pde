/****************************
 * Lindenmayer System Example 01
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
 ****************************/
int subDivideLimit = 2;
int subdivideCount = 0;

char[] rule = {'F', '+', 'F', '-', 'f', '+','f', '-', 'f', '-', 'f', '+', 'f',  '-', 'F', '+', 'F'};

// initial char
char[] chars = {'F', '-', 'F', '-', 'F', '-', 'F'};
// temp char array
char[] temp = new char[chars.length];

// shape diameter
float totalWidth = 380.0;

// initial angle
float angle = 0;

void setup(){
  size(400, 400);
  background(255);
 //fill(127);
  //noStroke();
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
        temp = append(temp, 'f');
        j++;
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
  // starting point (default n=0)
  float x = -totalWidth/2.0;
  float y = -totalWidth/2.0;
  // segment Length
  float segmentLen = totalWidth;

  // starting point (n>0)
  if (subDivideLimit>0){
    segmentLen = totalWidth/((4*pow(3, subDivideLimit)-2)/2);
    x = -(totalWidth/4.0+segmentLen/4.0);
    y = -(totalWidth/4.0+segmentLen/4.0);
  } 

  beginShape();
  vertex(x, y);
  for (int i=0; i<chars.length; i++){
    switch (chars[i]){
    case 'F':
      x += cos(angle)*segmentLen;
      y += sin(angle)*segmentLen;
      vertex(x, y);
      break;
    case 'f':
      x += cos(angle)*segmentLen/2.0;
      y += sin(angle)*segmentLen/2.0;
      vertex(x, y);
      break;
    case '+':
      angle -= PI/2.0;
      break;
    case '-':
      angle += PI/2.0;
      break;
    }
  }

  endShape(POLYGON);
}

