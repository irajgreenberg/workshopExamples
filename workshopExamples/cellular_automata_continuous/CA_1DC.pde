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

  void init(){
    int middleBottomCell = (rows-1)*cols + cols/2;
    setInitState(middleBottomCell, onC);
  }

  // set starting state (single pixel)
  void setInitState(int id, color c){
    resetState();
    pixls[id] = c;
    paintInitState(); 
  }

  // set starting state (array of pixels)
  void setInitState(int[] ids, color[] c){
    // reset();
    for (int i=0; i<ids.length; i++){
      pixls[ids[i]] = c[i];
    }
    paintInitState(); 
  }

  // set starting state
  void setInitState(int row, int col, color c){
    // reset pixels
    resetState();
    pixls[row*(cols-1) + (col-1)] = c;
    paintInitState(); 
  }

  /* rules:
   1. average 3 neighboring colors, e.g. (c[j-1] + c[j] + c[j+1])/3 
   2. add a constant, e.g. c + const
   3. if color components > 255 subtract 255 */
  void createGeneration(){
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
        nextPixls[(cols)*i + j] = int(r) << 16 | int(g) << 8 | int(b);
      }
    }
    // paint pixels on screen
    paint();
  }

  // pass custom rules
  void setconsts(float[] consts) {
    this.consts = consts;
  }

  void setThresholds(float[] thresholds) {
    this.thresholds = thresholds;
  }
}




















