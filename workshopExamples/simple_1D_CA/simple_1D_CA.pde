/**
 * Simple 1D Cellular Automata
 * By Ira Greenberg <br />
 * The Essential Guide to Processing for Flash Developers,
 * Friends of ED, 2009
 * 
 * Good CS article
 * http://www.generation5.org/content/2003/caIntro.asp
 */

// array for bit values
int[] bits;
/* CA rules, 4th val is new bit state 
(0=off, 1 = 0n), based on each rule */
int[][] rules = {
    {0,0,0,0},
    {1,0,0,1},
    {0,1,0,1},
    {0,0,1,1},
    {1,1,0,1},
    {0,1,1,1},
    {1,0,1,1},
    {1,1,1,0} 
};

void setup(){
  size(400, 400);
  // map color values between 0-1.0
  colorMode(RGB, 1.0);
  // access pixels array of sketch window
  loadPixels(); 
  // instantiate bits array to size of sketch
  bits = new int[width*height];
  // initialize starting bit state
  initNeighborhood();
}


// create inital state
void initNeighborhood(){
  // turn bottom middle bit on
    bits[width*(height-1) + width/2] = 1;
}

// update bits based on CA rules
void createGeneration(){
  for(int i=0; i<height-1; i++){
    for(int j=0; j<width; j++){
      
       // 1st and last columns use each other as neighbors in calculation
          int firstCol = (j==0) ? width-1 : j-1;
          int endCol = (j>0 && j<width-1) ? j+1 : 0;
          
      // check rules
      for(int k=0; k<rules.length; k++){
        if (bits[width*(i+1)+firstCol] == rules[k][0] &&
          bits[width*(i+1)+j] == rules[k][1] &&
          bits[width*(i+1)+endCol] == rules[k][2]){
          bits[width*i+j] = rules[k][3];
        } 
      }
    }
  }
}

// paint screen pixels based on stored values in bits
void setCells(){
  for (int i=0; i<bits.length; i++){
    // casts int to color data type for pixel value
    pixels[i] = color(bits[i]);
  }
    // call whenever changing pixels array
  updatePixels();
}

void draw(){
  // calculates CA
  createGeneration();
  // copies bit values to PImage pixels[]
  setCells();
}













