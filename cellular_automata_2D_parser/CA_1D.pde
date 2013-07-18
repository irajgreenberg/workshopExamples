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
  color[][] table = new color[8][4];

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

  // REQUIRED implementation – initiatlizes stuff
  void init(){
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
  void initRules(){
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
  void buildTable() {
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
  void createGeneration(){
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
  void setRules(boolean[] rules) {
    this.rules = rules;
    buildTable();
  }

  void setOnColor(color onC){
    this.onC = onC;
    buildTable();
    updateState();
    paintInitState(); 
  }

  void setOffColor(color offC){
    this.offC = offC;
    buildTable();
    updateState();
    paintInitState();
  }

}

























