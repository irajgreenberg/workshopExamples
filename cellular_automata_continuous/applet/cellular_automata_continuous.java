import processing.core.*; 
import processing.xml.*; 

import java.applet.*; 
import java.awt.*; 
import java.awt.image.*; 
import java.awt.event.*; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class cellular_automata_continuous extends PApplet {

/**
 * Continuous Cellular Automata Main Tab - 01
 * By Ira Greenberg <br />
 * The Essential Guide to Processing for Flash Developers,
 * Friends of ED, 2009
 */

CA_1DC[] cacs = new CA_1DC[16];
float threshMin = 75, threshMax = 175;
float constMin = 1, constMax = 130;

int seedCount = 1;
int[] seeds = new int[seedCount];
int[] cols = new int[seedCount];

public void setup(){
  size(800, 800);
  background(127);
  noStroke();
  for (int i=0; i<cacs.length; i++){
    cacs[i] = new CA_1DC(200, 200, 1);
    for (int j=0; j<seeds.length; j++){
      seeds[j] = PApplet.parseInt((cacs[i].rows-1)*cacs[i].cols + PApplet.parseInt(random(cacs[i].cols)));
     cols[j] = color(random(255), random(255), random(255));
    }
    float t1 = random(threshMin, threshMax);
    float t2 = random(threshMin, threshMax);
    float t3 = random(threshMin, threshMax);
    float c1 = random(constMin, constMax);
    float c2 = random(constMin, constMax);
    float c3 = random(constMin, constMax);
    cacs[i].setThresholds( new float[] {t1, t2, t3});
    cacs[i].setconsts( new float[] {c1, c2, c3});
    cacs[i].setInitState(seeds, cols);
  }
}

public void draw(){
  translate(cacs[0].w/2, cacs[0].h/2);
  int step = cacs.length/4;
  for (int i=0; i<step; i++){
    for (int j=0; j<step; j++){
      pushMatrix();
      translate(cacs[step*i + j].w*i, cacs[step*i + j].h*j);
      cacs[step*i + j].createGeneration();
      popMatrix();
    }
  }
}



/**
 * Cellular Automata 
 * CA class (base class)
 * By Ira Greenberg <br />
 * The Essential Guide to Processing for Flash Developers,
 * Friends of ED, 2009
 */

abstract class CA extends Shape{
  // instance properties, including default values
  int cellScale = 3;
  int rows = 10, cols = 10;
  float rowSpan, colSpan; 
  Cell[][] cells;
  PImage p;
  int[] pixls;
  int[] nextPixls;
  int[] state;

  // default start colors
  int onC = 0xffffffff;
  int offC = 0xffff00ff;

  // default constructor
  CA(){
    super(200.0f, 200.0f);
    initCA();
  }

  // constructor
  CA(float w, float h, int cellScale){
    super(w, h);
    rows = ceil(h/cellScale);
    cols = ceil(w/cellScale);
    initCA();
  }

  // initialize
  public void initCA(){
    pixls = new int[rows*cols];
    nextPixls = new int[rows*cols];
    // record current pixel on/off state as integer array
    state = new int[pixls.length];
    colSpan = w/cols;
    rowSpan = h/rows;

    cells = new Cell[rows][cols];
    for (int i=0; i<rows; i++){
      for (int j=0; j<cols; j++){
        // instantiate cells
        cells[i][j] = new Cell(colSpan*j, rowSpan*i, colSpan, rowSpan, this);
      }
    }
    p = createImage(PApplet.parseInt(w), PApplet.parseInt(h), RGB);
  }

  // set starting state (single pixel)
  public void setInitState(int id){
    resetState();
    // turn initial pixel on 
    pixls[id] = onC;
    recordState();
    paintInitState(); 
  }

  // set starting state (array of pixels)
  public void setInitState(int[] ids){
    resetState();
    for (int i=0; i<ids.length; i++){
      pixls[ids[i]] = onC;
    }
    recordState();
    paintInitState(); 
  }

  // set starting state (single pixel using 2D coord)
  public void setInitState(int row, int col){
    resetState();
    pixls[row*(cols-1) + (col-1)] = onC;
    recordState();
    paintInitState(); 
  }

  // record pixel state in integer array (1 = on, 0 = off)
  public void recordState(){
    for (int i=0; i<pixls.length; i++){
      if (pixls[i] == onC){
        state[i] = 1;
      } 
      else {
        state[i] = 0;
      }
    }
  }

  // update pixels based on state integer array
  public void updateState(){
    for (int i=0; i<state.length; i++){
      if (state[i] == 1){
        pixls[i] = onC;
      } 
      else {
        pixls[i] = offC;
      }
    }
  }

  // ensure starting pixel state is rendered
  public void paintInitState(){
    arrayCopy(pixls, nextPixls);
    paint();
  }

  // reset all pixels to off
  public void resetState(){
    for (int i=0; i<pixls.length; i++){
      pixls[i] = offC;
    }
  }

  // paint "dem perty" cells
  public void paint(){
    p.loadPixels();
    for (int i=0; i<rows; i++){
      for (int j=0; j<cols; j++){
        cells[i][j].setColor(nextPixls[cols*i + j]);
        cells[i][j].create();
      }
    } 
    p.updatePixels();
    image(p, -w/2+loc.x, -h/2+loc.y);
    arrayCopy(nextPixls, pixls); 
  }

  // must be implemented in subclass (or subclass will be abstract)
  public abstract void init();
  public abstract void createGeneration();

}


/**
 * Cellular Automata
 * CA_1D class
 * neighborhood:   | ? | 
 *               * | * | *
 * By Ira Greenberg <br />
 * The Essential Guide to Processing for Flash Developers,
 * Friends of ED, 2009
 */

class CA_1D extends CA{
  // instance properties

  // CA rules
  boolean[] rules = new boolean[8];
  int[][] table = new int[8][4];

  // default constructor
  CA_1D(){
    super();
    init();
  }

  // constructor
  CA_1D(int w, int h, int cellScale){
    super(w, h, cellScale);
    init();
  }

  // REQUIRED implementation \u2013 initiatlizes stuff
  public void init(){
    // initialize 1D rules
    initRules();
    // build rules table
    buildTable();
    //set default pixel starting state - bottom center pixel set to on
    int middleBottomCell = (rows-1)*(cols) + (cols)/2;
    setInitState(middleBottomCell);
    // record pixel on/off state in integer state table
  }

  // initialize rules
  public void initRules(){
    rules[0] = false;
    rules[1] = true;
    rules[2] = true;
    rules[3] = true;
    rules[4] = true;
    rules[5] = true;
    rules[6] = true;
    rules[7] = false;
  }

  // build rules table
  public void buildTable() {
    table[0][0] = offC; 
    table[0][1] = offC; 
    table[0][2] = offC; 
    table[0][3] = rules[0] ? onC : offC;
    table[1][0] = offC; 
    table[1][1] = offC; 
    table[1][2] = onC; 
    table[1][3] = rules[1] ? onC : offC;
    table[2][0] = offC; 
    table[2][1] = onC; 
    table[2][2] = offC; 
    table[2][3] = rules[2] ? onC : offC;
    table[3][0] = offC; 
    table[3][1] = onC; 
    table[3][2] = onC; 
    table[3][3] = rules[3] ? onC : offC;
    table[4][0] = onC; 
    table[4][1] = offC; 
    table[4][2] = offC; 
    table[4][3] = rules[4] ? onC : offC;
    table[5][0] = onC; 
    table[5][1] = offC; 
    table[5][2] = onC; 
    table[5][3] = rules[5] ? onC : offC;
    table[6][0] = onC; 
    table[6][1] = onC; 
    table[6][2] = offC; 
    table[6][3] = rules[6] ? onC : offC;
    table[7][0] = onC; 
    table[7][1] = onC; 
    table[7][2] = onC; 
    table[7][3] = rules[7] ? onC : offC;
  }

  // REQUIRED implementation
  public void createGeneration(){
    for (int i=0; i<rows-1; i++){
      for (int j=0; j<cols; j++){
        for (int k=0; k<rules.length; k++){
          // 1st and last columns use each other as neighbors in calculation
          int firstCol = (j==0) ? cols-1 : j-1;
          int endCol = (j>0 && j<cols-1) ? j+1 : 0;
          // rules determined by binary table: 0 = offCol, 1 = onC.
          // [111][110][101][100][011][010][001][000]
          if (pixls[cols*(i+1) + firstCol] == table[k][0] &&
            pixls[cols*(i+1) + j] == table[k][1] &&
            pixls[cols*(i+1) + endCol] ==  table[k][2]){
            nextPixls[(cols)*i + j] = table[k][3];
          }
        }
      }
    }
    // paint pixels on screen
    paint();
  }

  // update rules - requires 8 boolean values
  public void setRules(boolean[] rules) {
    this.rules = rules;
    buildTable();
  }

  public void setOnColor(int onC){
    this.onC = onC;
    buildTable();
    updateState();
    paintInitState(); 
  }

  public void setOffColor(int offC){
    this.offC = offC;
    buildTable();
    updateState();
    paintInitState();
  }

}

























/**
 * Cellular Automata
 * CA_1DC class
 * neighborhood:   | ? | 
 *               * | * | *
 * By Ira Greenberg <br />
 * The Essential Guide to Processing for Flash Developers,
 * Friends of ED, 2009
 */

class CA_1DC extends CA{

  //instance properties
  float[] consts = {
    0, 0, 0  };
  float[] thresholds = {
    255, 255, 255  };

  // default constructor
  CA_1DC(){
    super();
    init();
  }

  // constructor
  CA_1DC(int w, int h, int cellScale){
    super(w, h, cellScale);
    init();
  }

  public void init(){
    int middleBottomCell = rows-1*(cols) + (cols)/2;
    setInitState(middleBottomCell, onC);
  }

  // set starting state (single pixel)
  public void setInitState(int id, int c){
    resetState();
    pixls[id] = c;
    paintInitState(); 
  }

  // set starting state (array of pixels)
  public void setInitState(int[] ids, int[] c){
    // reset();
    for (int i=0; i<ids.length; i++){
      pixls[ids[i]] = c[i];
    }
    paintInitState(); 
  }

  // set starting state
  public void setInitState(int row, int col, int c){
    // reset pixels
    resetState();
    pixls[row*(cols-1) + (col-1)] = c;
    paintInitState(); 
  }

  /* rules:
   1. average 3 neighboring colors, e.g. (c[j-1] + c[j] + c[j+1])/3 
   2. add a constant, e.g. c + const
   3. if color components > 255 subtract 255 */
  public void createGeneration(){
    for (int i=0; i<rows-1; i++){
      for (int j=0; j<cols; j++){
        // use 1st colum as j+1, for end pixel in each column
        int firstCol = (j==0) ? cols-1 : j-1;
        int endCol = (j>0 && j<cols-1) ? j+1 : 0;
        int row = cols*(i+1);
        float r =  ((pixls[row + firstCol] >> 16 & 0xFF) + (pixls[row + j] >> 16 & 0xFF) + (pixls[row + endCol] >> 16 & 0xFF))/3 + consts[0];
        float g =  ((pixls[row + firstCol] >> 8 & 0xFF) + (pixls[row + j] >> 8 & 0xFF) + (pixls[row + endCol] >> 8 & 0xFF))/3 + consts[1];
        float b =  ((pixls[row + firstCol] & 0xFF) + (pixls[row + j] & 0xFF) + (pixls[row + endCol] & 0xFF))/3 + consts[2];
        if (r>thresholds[0]){
          r-=thresholds[0];
        }

        if (g>thresholds[1]){
          g-=thresholds[1];
        }

        if (b>thresholds[2]){
          b-=thresholds[2];
        }
        nextPixls[(cols)*i + j] = PApplet.parseInt(r) << 16 | PApplet.parseInt(g) << 8 | PApplet.parseInt(b);
      }
    }
    // paint pixels on screen
    paint();
  }

  // pass custom rules
  public void setconsts(float[] consts) {
    this.consts = consts;
  }

  public void setThresholds(float[] thresholds) {
    this.thresholds = thresholds;
  }
}




















/**
 * Cellular Automata
 * Cell class
 * - encapuslates drawing to pixel buffer
 * By Ira Greenberg <br />
 * The Essential Guide to Processing for Flash Developers,
 * Friends of ED, 2009
 */

class Cell extends Shape{

  int c;
  // reference to CA obj
  CA ca;

  Cell(float x, float y, float w, float h, CA ca){
    super(x, y, w, h);
    this.ca = ca;
  }

  public void setColor(int c){
    this.c = c;
  }

  // draw to pixels buffer
  public void create(){
    float origin = PApplet.parseInt(loc.y) * ca.w + PApplet.parseInt(loc.x);
    for (int i=0; i<w; i++){
      for (int j=0; j<h; j++){
          // - pretty nasty pixls[index] expression
        ca.p.pixels[PApplet.parseInt(min(origin + j*ca.w + i, ca.w*ca.h))] = c;
      }
    }
  }
}


/**
 * Cellular Automata
 * Shape class - convenience class
 * By Ira Greenberg <br />
 * The Essential Guide to Processing for Flash Developers,
 * Friends of ED, 2009
 */

class Shape {

  // instance properties
  PVector loc = new PVector();
  float w;
  float h;
  

  // default constructor
  Shape(){
  }

  Shape(float w, float h){
    this.w = w;
    this.h = h;
  }

  // constructor
  Shape(float x, float y, float w, float h){
    loc.x = x;
    loc.y = y;
    this.w = w;
    this.h = h;
  }

  // setters
  public void setLoc(float x, float y){
    loc.x = x;
    loc.y = y;
  }

  public void setLoc(PVector loc){
    this.loc = loc;
  }

  public void setSize(float w, float h){
    this.w = w;
    this.h = h;
  }

}


  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#FFFFFF", "cellular_automata_continuous" });
  }
}
