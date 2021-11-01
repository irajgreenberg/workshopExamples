/**
 * Cellular Automata
 * CA_2D class
 * neighborhood: * | * | *
 *               * | ? | *
 *               * | * | *
 * By Ira Greenberg <br />
 * The Essential Guide to Processing for Flash Developers,
 * Friends of ED, 2009
 */

class CA_2D extends CA{
  // instance properties

  // default constructor
  CA_2D(){
    super();
    init();
  }

  // constructor
  CA_2D(int w, int h, int cellScale){
    super(w, h, cellScale);
    init();
  }

  // REQUIRED implementation – initiatlizes stuff
  void init(){
    // set default starting state
    /* R-pentomino pattern
     **
     **
     *
     */
    int[] initState = {   
      ((rows)/2-1)*(cols) + (cols-1)/2+1,
      ((rows)/2-1)*(cols) + (cols-1)/2, 
      (rows)/2*(cols) + (cols-1)/2, 
      (rows)/2*(cols) + (cols-1)/2-1,
      ((rows)/2+1)*(cols) + (cols-1)/2
    };
    setInitState(initState);
  }

  // set starting state (array of pixels)
  void setInitState(int[] ids){
    resetState();
    for (int i=0; i<ids.length; i++){
      pixls[ids[i]] = onC;
    }
    paintInitState(); 
  }

  // set starting state (single pixel)
  void setInitState(int row, int col){
    resetState();
    pixls[row*(cols-1) + (col-1)] = onC;
    paintInitState(); 
  }

  // REQUIRED implementation
  void createGeneration(){
    for (int i=0; i<rows; i++){
      for (int j=0; j<cols; j++){
        // 1st and last columns use each other as neighbors in calculation
        int firstCol = (j==0) ? cols-1 : j-1;
        int endCol = (j>0 && j<cols-1) ? j+1 : 0;
        // 1st and last rows use each other as neighbors in calculation
        int firstRow = (i==0) ? rows-1 : i-1;
        int endRow = (i>0 && i<rows-1) ? i+1 : 0;

        int sum = 0;
        if (pixls[cols*(firstRow) + firstCol] == onC){
          sum+=1;
        } 
        if (pixls[cols*(firstRow) + j] == onC){
          sum+=1;
        } 
        if (pixls[cols*(firstRow) + endCol] == onC){
          sum+=1;

        } 
        if (pixls[cols*i + endCol] == onC){
          sum+=1;

        } 
        if (pixls[cols*(endRow) + endCol] == onC){
          sum+=1;

        } 
        if (pixls[cols*(endRow) + j] == onC){
          sum+=1;

        } 
        if (pixls[cols*(endRow) + firstCol] == onC){
          sum+=1;
        } 
        if (pixls[cols*i + firstCol] == onC){
          sum+=1;
        } 

        if (pixls[cols*i + j] == onC){
          if (sum < 2 || sum > 3){
            nextPixls[cols*i + j] = offC;
          } 
          // if sum is 2 or 3
          else {
            nextPixls[cols*i + j] = onC;
          }
        } 
        // if pixel is offC
        else {
          if (sum == 3){
            nextPixls[cols*i + j] = onC;
          }
        }
      }
    }
    // paint pixels on screen
    paint();
  }

  void setOnColor(color onC){
    this.onC = onC;
  }

  void setOffColor(color offC){
    this.offC = offC;
  }

  // put pattern array into pixls as initial on/off state
  void setPattern(LIF_Parser lp){
    resetState();
    float deltaW = (cols - lp.w)/2.0;
    float deltaH = (rows - lp.h)/2.0;
    int ctr = 0;
    for (int i=0; i<rows; i++){
      for (int j=0; j<cols; j++){
        if (i >= deltaH && i < lp.h+deltaH && 
          j >= deltaW && j < lp.w+deltaW){
          if (lp.bits[ctr] == 0){
            pixls[int(i*cols+j)] = offC;
          } 
          else if (lp.bits[ctr] == 1){
            pixls[int(i*cols+j)] = onC;
          }
          // pixls[int(i*cols+j)] = lp.pixls[ctr];
          ctr++;
        }

      }
    }
    paintInitState(); 
  }

}
































