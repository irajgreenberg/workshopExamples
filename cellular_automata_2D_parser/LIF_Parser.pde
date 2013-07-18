/**
 * Cellular Automata
 * LIF_Parser class
 * By Ira Greenberg <br />
 * The Essential Guide to Processing for Flash Developers,
 * Friends of ED, 2009
 */
class LIF_Parser{
  // stores symbols (. *)
  String[] symbs = {};
  // path to .lif file
  String url;
  // stores all lines in .lif file
  String[] lines;
  // stores number of lines of symbols within each coord group
  int[] indices;
  // utility counter to increment coords[][] array
  int coordsCounter = 0;
  // stores origin in a sense of each symbol group
  int[][] coords;
  // bits buffer for pattern
  int[] bits;
  // bits array size (w, h)
  int w, h;


  // constructor
  LIF_Parser(String url){
    this.url = url;
    // load .lif file
    lines = loadStrings(url);
    // get numbers of lines within each coord group
    indices = getIndices();
    // instantiate coords array values of where to draw each part of pattern
    coords = new int[indices.length][2];
    // isolate coords and reformat as int[][]
    parseCoords();
    //shift coords to remove negative values and isolate symbols
    shiftCoords();
    // create bits array based on pattern
    calcBits();
  }

  /* parses initial line strings, creating
   int[][] of coord data and isolates symbols*/
  void parseCoords(){
    for (int i=0; i<lines.length; i++){
      String tempStr = "";
      // detect coords
      if (lines[i].charAt(0) == '#' && lines[i].charAt(1) == 'P'){
        // collect coord locs
        for (int j = 2; j<lines[i].length(); j++){
          tempStr += lines[i].charAt(j);
        }
        String tempStr2 = "";
        for (int j=0; j<tempStr.length(); j++){
          if (j>0 && tempStr.charAt(j) == ' '){
            tempStr2 += ',';
          } 
          else if (tempStr.charAt(j) != ' '){
            tempStr2 += tempStr.charAt(j);
          }
        }
        coords[coordsCounter][0] = int(split(tempStr2, ','))[0];
        coords[coordsCounter][1] = int(split(tempStr2, ','))[1];
        coordsCounter ++; 
      } 
      else {
        // collect symbols
        if (lines[i].charAt(0) != '#'){
          symbs = append(symbs, lines[i]);
        }
      }
    }
  }


  /* add offset to x and y coords, based on lowest 
   values, to avoid negative values */
  void shiftCoords(){
    int xMin = 0, yMin = 0;
    // get lowest values
    for (int i=0; i<coords.length; i++){
      if (coords[i][0] < xMin){
        xMin = coords[i][0];
      }
      if (coords[i][1] < yMin){
        yMin = coords[i][1];
      }
    }
    // shift all coords
    for (int i=0; i<coords.length; i++){
      coords[i][0] += abs(xMin);
      coords[i][1] += abs(yMin);
    }
  }

  /* structure of data
   * stores number of symbols within each group
   * defined by #P coordX coordY  in .lif file */
  int[] getIndices(){
    int j = 0;
    int[] indices = {
    };

    for (int i=0; i<lines.length; i++){
      if(lines[i].charAt(0) != '#'){
        j++;
      } 
      else {
        if (j!= 0){
          indices = append(indices, j);
        }
        j = 0;
      } 
    }
    // get last group
    indices = append(indices, j);
    return indices;
  }

  // calculate bits
  void calcBits(){
    // counter
    int ctr = 0;
    for (int i=0; i<indices.length; i++){
      for (int j=0; j<indices[i]; j++){
        // caclulate max horizontal dimension
        if (coords[i][0] + symbs[ctr].length() > w){
          w = coords[i][0] + symbs[ctr].length();
        }
        // caclulate max vertical dimension
        if (coords[i][1] + indices[i] > h){
          h = coords[i][1] + indices[i];
        }
        ctr++;
      }
    }
    // instantiate bits array
    bits = new int[w*h];
    // reset counter
    ctr = 0;
    //fill bits array
    for (int i=0; i<indices.length; i++){
      for (int j=0; j<indices[i]; j++){
        for (int k=0; k<symbs[ctr].length(); k++){
          if (symbs[ctr].charAt(k) == '.'){
            bits[w*(coords[i][1] + j) + (coords[i][0]+k)] = 0;
          } 
          else if (symbs[ctr].charAt(k) == '*'){
            bits[w*(coords[i][1] + j) + (coords[i][0]+k)] = 1;
          }
        }
        ctr++;
      }
    }
  }

}






































