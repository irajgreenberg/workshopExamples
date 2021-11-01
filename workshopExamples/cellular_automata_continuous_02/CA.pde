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
  color[] pixls;
  color[] nextPixls;
  int[] state;

  // default start colors
  color onC = 0xffffffff;
  color offC = 0xffff00ff;

  // default constructor
  CA(){
    super(200.0, 200.0);
    initCA();
  }

  // constructor
  CA(float w, float h, int cellScale){
    super(w, h);
    this.cellScale = cellScale;
    rows = ceil(h/cellScale);
    cols = ceil(w/cellScale);
    initCA();
  }

  // initialize
  void initCA(){
    pixls = new color[rows*cols];
    nextPixls = new color[rows*cols];
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
    p = createImage(int(w), int(h), RGB);
  }

  // set starting state (single pixel)
  void setInitState(int id){
    resetState();
    // turn initial pixel on 
    pixls[id] = onC;
    recordState();
    paintInitState(); 
  }

  // set starting state (array of pixels)
  void setInitState(int[] ids){
    resetState();
    for (int i=0; i<ids.length; i++){
      pixls[ids[i]] = onC;
    }
    recordState();
    paintInitState(); 
  }

  // set starting state (single pixel using 2D coord)
  void setInitState(int row, int col){
    resetState();
    pixls[row*(cols-1) + (col-1)] = onC;
    recordState();
    paintInitState(); 
  }

  // record pixel state in integer array (1 = on, 0 = off)
  void recordState(){
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
  void updateState(){
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
  void paintInitState(){
    arrayCopy(pixls, nextPixls);
    paint();
  }

  // reset all pixels to off
  void resetState(){
    for (int i=0; i<pixls.length; i++){
      pixls[i] = offC;
    }
  }

  // paint "dem perty" cells
  void paint(){
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
  abstract void init();
  abstract void createGeneration();

}


