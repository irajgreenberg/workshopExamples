class VerletMan {
  final static int RIGID = 0;
  final static int FLEXIBLE = 1;
  final static int ELASTIC = 2;
  int bodyType = FLEXIBLE;
  float gravity = .0005;
  float tension = .08; //.08
  float ballRadius = .01;

  int resetCounter = 0;
  boolean isResetMode, isRunMode;
  int resetSteps = 15;

  PFont f;
  PVector loc = new PVector();
  float w;
  float h;

  float nodeSize = 1;
  int selectdBallID = 0;

  boolean isNodesVisible;
  boolean isBodyVisible;
  boolean isSkeletonVisible;
  boolean isArmatureVisible;
  boolean isStatsVisible;

  VerletBall[] balls = new VerletBall[41];
  PVector[] ballsInitPos = new PVector[41];
  PVector[] deltas = new PVector[41];
  VerletBall[] topAnchors = new VerletBall[2];
  VerletStick[] anchorSticks = new VerletStick[2];
  ArrayList<VerletStick> sticks;


  int[] leftNodes = {
    0, 3, 4, 7, 8, 29, 33, 37, 38, 34, 30, 13, 12, 14, 17, 21, 25, 26, 22, 18, 15
  };
  int[] rightNodes = {
    1, 2, 5, 6, 9, 31, 35, 39, 40, 36, 32, 10, 11, 16, 19, 23, 27, 28, 24, 20, 15
  };
  int[] topNodes = {
    12, 13, 30, 34, 38, 37, 33, 29, 8, 7, 4, 3, 0, 1, 2, 5, 6, 9, 31, 35, 39, 40, 36, 32, 10, 11
  };
  int[] bottomNodes = {
    14, 17, 21, 25, 26, 22, 18, 15, 20, 24, 28, 27, 23, 19, 16
  };
  int[] allNodes = {
    0, 1, 2, 5, 6, 9, 31, 35, 39, 40, 36, 32, 10, 11, 16, 19, 23, 27, 28, 24, 20, 15, 18, 22, 26, 25, 21, 17, 14, 12, 13, 30, 34, 38, 37, 33, 29, 8, 7, 4, 3
  };

  int currentNode = 0;
  float pushX = .09;
  float pushY = .09;
  float[][] midiNodeMap = 
  {
    { 
      25, -pushX, pushY
    }
    , 
    { 
      27, pushX, pushY
    }
    , 
    { 
      21, -pushX, pushY*.7
    }
    , 
    { 
      23, pushX, pushY*.7
    }
    , 
    { 
      17, -pushX, pushY*.4
    }
    , 
    { 
      19, pushX, pushY*.4
    }
    , 
    { 
      14, -pushX, pushY*.2
    }
    , 
    { 
      16, pushX, pushY*.2
    }
    , 
    { 
      12, -pushX, pushY
    }
    , 
    { 
      11, pushX, pushY
    }
    , 
    { 
      37, -pushX, pushY*.4
    }
    , 
    { 
      39, pushX, pushY*.4
    }
    , 
    { 
      33, -pushX, pushY*.2
    }
    , 
    { 
      35, pushX, pushY*.2
    }
    , 
    { 
      29, -pushX, -pushY*.4
    }
    , 
    { 
      31, pushX, -pushY*.4
    }
    , 
    { 
      8, -pushX, -pushY*.6
    }
    , 
    { 
      9, pushX, -pushY*.6
    }
    , 
    { 
      3, -pushX, -pushY*.8
    }
    , 
    { 
      2, pushX, -pushY*.8
    }
    , 
    { 
      0, -pushX, -pushY
    }
    , 
    { 
      1, pushX, -pushY
    }
  };


  VerletMan() {
    init();
  }

  VerletMan(PVector loc, float w, float h) {
    this.loc = loc;
    this.w = w;
    this.h = h;
    init();
    //
  }

  VerletMan(PVector loc, float w, float h, int bodyType) {
    this.loc = loc;
    this.w = w;
    this.h = h;
    this.bodyType = bodyType;
    init();
    //
  }

  void init() {
    f = loadFont("ArialMT-24.vlw");
    textFont(f, 2);
    setBalls();
    // copy initial ball positions
    for (int i=0; i<balls.length; i++) {
      ballsInitPos[i] = new PVector(balls[i].pos.x, balls[i].pos.y);
    }
    setSticks();
  }

  void setBalls() {

    // head
    float headW = h/5;
    float headH = headW;
    float headX = -headW/2;
    float headY = -h/2;
    balls[0] = new VerletBall(new PVector(headX, headY), ballRadius);
    balls[1] = new VerletBall(new PVector(headX+headW, headY), ballRadius);
    balls[2] = new VerletBall(new PVector(headX+headW, headY+headH), ballRadius);
    balls[3] = new VerletBall(new PVector(headX, headY+headH), ballRadius);

    // anchors
    topAnchors[0] = new VerletBall(new PVector(-headW/2-4.4, -h*20), ballRadius);
    topAnchors[1] = new VerletBall(new PVector(-headW/2+4.4, -h*20), ballRadius);


    // neck
    float neckW = headW/3.3;
    float neckH = neckW*1.5;
    float neckX = -neckW/2;
    float neckY = headY+headH;
    balls[4] = new VerletBall(new PVector(neckX, neckY), ballRadius);
    balls[5] = new VerletBall(new PVector(neckX+neckW, neckY), ballRadius);
    balls[6] = new VerletBall(new PVector(neckX+neckW, neckY+neckH), ballRadius);
    balls[7] = new VerletBall(new PVector(neckX, neckY+neckH), ballRadius);

    // torso
    float torsoW = headW;
    float torsoH = h/2-headH-neckH;
    float torsoX = -torsoW/2;
    float torsoY = neckY + neckH;
    float shoulderH = torsoH/3;
    float torsoTaper = torsoW*.15;
    balls[8] = new VerletBall(new PVector(torsoX, torsoY), ballRadius);
    balls[9] = new VerletBall(new PVector(torsoX+torsoW, torsoY), ballRadius);
    balls[10] = new VerletBall(new PVector(torsoW/2-torsoTaper*.4, torsoY+shoulderH*1.4), ballRadius);
    balls[11] = new VerletBall(new PVector(torsoX+torsoW-torsoTaper, torsoY+torsoH), ballRadius);
    balls[12] = new VerletBall(new PVector(torsoX+torsoTaper, torsoY+torsoH), ballRadius);
    balls[13] = new VerletBall(new PVector(-torsoW/2+torsoTaper*.4, torsoY+shoulderH*1.4), ballRadius);

    // pelvis
    float pelvisW = torsoW*.8;
    float pelvisH = pelvisW*.8;
    float pelvisX = -pelvisW/2;
    float pelvisY = torsoY + torsoH;
    float pelvisTaper = pelvisW*.02;
    balls[14] = new VerletBall(new PVector(pelvisX-pelvisTaper, pelvisY+pelvisH), ballRadius);
    balls[15] = new VerletBall(new PVector(pelvisX+pelvisW/2, pelvisY+pelvisH), ballRadius);
    balls[16] = new VerletBall(new PVector(pelvisX+pelvisW+pelvisTaper, pelvisY+pelvisH), ballRadius);

    // left femur
    float femurW = torsoW/2;
    float femurH = pelvisH*.85;
    float femurY = pelvisY + pelvisH;
    float femurTaper = femurW*.2;
    balls[17] = new VerletBall(new PVector(-(femurTaper+femurW), femurY+femurH), ballRadius);
    balls[18] = new VerletBall(new PVector(-femurTaper*2.5, femurY+femurH), ballRadius);

    // right femur
    balls[19] = new VerletBall(new PVector(femurTaper+femurW, femurY+femurH), ballRadius);
    balls[20] = new VerletBall(new PVector(femurTaper*2.5, femurY+femurH), ballRadius);

    // left tibia
    float tibiaW = femurW/2;
    float tibiaH = femurH*1.5;
    float tibiaY = femurY + femurH;
    float tibiaTaper = tibiaW*.2;
    balls[21] = new VerletBall(new PVector(-(tibiaTaper+tibiaW), tibiaY+tibiaH), ballRadius);
    balls[22] = new VerletBall(new PVector(-tibiaTaper*2.75, tibiaY+tibiaH), ballRadius);

    // right tibia
    balls[23] = new VerletBall(new PVector(tibiaTaper+tibiaW, tibiaY+tibiaH), ballRadius);
    balls[24] = new VerletBall(new PVector(tibiaTaper*2.75, tibiaY+tibiaH), ballRadius);

    // left foot
    float footW = tibiaW;
    float footH = tibiaH*.4;
    float footY = tibiaY + tibiaH;
    float footTaper = footW*.5;
    balls[25] = new VerletBall(new PVector(-(footTaper+footW*1.3), footY+footH), ballRadius);
    balls[26] = new VerletBall(new PVector(-footTaper*1.3, footY+footH), ballRadius);

    // right foot
    balls[27] = new VerletBall(new PVector(footTaper+footW*1.3, footY+footH), ballRadius);
    balls[28] = new VerletBall(new PVector(footTaper*1.3, footY+footH), ballRadius);

    // left humerus
    float humerW = torsoW/4;
    float humerH = torsoH/1.4;
    float humerX = balls[8].pos.x + cos(125*PI/180)*humerH;
    float humerY = balls[8].pos.y  + sin(125*PI/180)*humerH;
    balls[29] = new VerletBall(new PVector(humerX, humerY), ballRadius);
    humerX = balls[13].pos.x + cos(140*PI/180)*humerH*.7;
    humerY = balls[13].pos.y  + sin(140*PI/180)*humerH*.7;
    balls[30] = new VerletBall(new PVector(humerX, humerY), ballRadius);

    // right humerus
    humerX = balls[9].pos.x + cos(55*PI/180)*humerH;
    humerY = balls[9].pos.y  + sin(55*PI/180)*humerH;
    balls[31] = new VerletBall(new PVector(humerX, humerY), ballRadius);
    humerX = balls[10].pos.x + cos(40*PI/180)*humerH*.7;
    humerY = balls[10].pos.y  + sin(40*PI/180)*humerH*.7;
    balls[32] = new VerletBall(new PVector(humerX, humerY), ballRadius);

    // left ulna
    float ulnaW = torsoW/5;
    float ulnaH = torsoH/1.5;
    float ulnaX = balls[29].pos.x + cos(110*PI/180)*ulnaH;
    float ulnaY = balls[29].pos.y  + sin(110*PI/180)*ulnaH;
    balls[33] = new VerletBall(new PVector(ulnaX, ulnaY), ballRadius);
    ulnaX = balls[30].pos.x + cos(111*PI/180)*ulnaH*.8;
    ulnaY = balls[30].pos.y  + sin(111*PI/180)*ulnaH*.8;
    balls[34] = new VerletBall(new PVector(ulnaX, ulnaY), ballRadius);

    // right ulna;
    ulnaX = balls[31].pos.x + cos(70*PI/180)*ulnaH;
    ulnaY = balls[31].pos.y  + sin(70*PI/180)*ulnaH;
    balls[35] = new VerletBall(new PVector(ulnaX, ulnaY), ballRadius);
    ulnaX = balls[32].pos.x + cos(69*PI/180)*ulnaH*.8;
    ulnaY = balls[32].pos.y  + sin(69*PI/180)*ulnaH*.8;
    balls[36] = new VerletBall(new PVector(ulnaX, ulnaY), ballRadius);



    // left hand
    float handW = ulnaW/2;
    float handH = ulnaH/1.65;
    float handX = balls[33].pos.x + cos(78*PI/180)*handH;
    float handY = balls[33].pos.y  + sin(78*PI/180)*handH;
    balls[37] = new VerletBall(new PVector(handX, handY), ballRadius);
    handX = balls[34].pos.x + cos(79*PI/180)*handH*.8;
    handY = balls[34].pos.y  + sin(79*PI/180)*handH*.8;
    balls[38] = new VerletBall(new PVector(handX, handY), ballRadius);

    // right hand
    handX = balls[35].pos.x + cos(103*PI/180)*handH;
    handY = balls[35].pos.y  + sin(103*PI/180)*handH;
    balls[39] = new VerletBall(new PVector(handX, handY), ballRadius);
    handX = balls[36].pos.x + cos(101*PI/180)*handH*.8;
    handY = balls[36].pos.y  + sin(101*PI/180)*handH*.8;
    balls[40] = new VerletBall(new PVector(handX, handY), ballRadius);
  }



  void setSticks() {
    sticks = new ArrayList<VerletStick>();
    // top anchors
    anchorSticks[0] = new VerletStick(topAnchors[0], balls[0], 1, VerletStick.ARMATURE);
    anchorSticks[1] = new VerletStick(topAnchors[1], balls[1], 1, VerletStick.ARMATURE);

    // sticks - head
    sticks.add(new VerletStick(balls[0], balls[1], tension, VerletStick.BODY));
    sticks.add(new VerletStick(balls[1], balls[2], tension, VerletStick.BODY));
    sticks.add(new VerletStick(balls[2], balls[5], tension, VerletStick.BODY));
    sticks.add(new VerletStick(balls[5], balls[4], tension, VerletStick.BODY));
    sticks.add(new VerletStick(balls[4], balls[3], tension, VerletStick.BODY));
    sticks.add(new VerletStick(balls[3], balls[0], tension, VerletStick.BODY));

    // sticks - head(armature)
    sticks.add(new VerletStick(balls[0], balls[2], tension, VerletStick.ARMATURE));
    sticks.add(new VerletStick(balls[1], balls[3], tension, VerletStick.ARMATURE));
    sticks.add(new VerletStick(balls[3], balls[7], tension, VerletStick.ARMATURE));
    sticks.add(new VerletStick(balls[2], balls[6], tension, VerletStick.ARMATURE));

    // sticks - neck
    //sticks.add(new VerletStick(balls[4], balls[5], tension, VerletStick.BODY));
    sticks.add(new VerletStick(balls[5], balls[6], tension, VerletStick.BODY));
    sticks.add(new VerletStick(balls[6], balls[7], tension, VerletStick.BODY));
    sticks.add(new VerletStick(balls[7], balls[4], tension, VerletStick.BODY));

    // sticks - neck to top
    sticks.add(new VerletStick(balls[0], balls[5], tension, VerletStick.ARMATURE));
    sticks.add(new VerletStick(balls[1], balls[4], tension, VerletStick.ARMATURE));

    // sticks - neck (armature)
    sticks.add(new VerletStick(balls[4], balls[2], tension, VerletStick.ARMATURE));
    sticks.add(new VerletStick(balls[5], balls[7], tension, VerletStick.ARMATURE));
    sticks.add(new VerletStick(balls[4], balls[6], tension, VerletStick.ARMATURE));
    sticks.add(new VerletStick(balls[8], balls[3], tension, VerletStick.ARMATURE));
    sticks.add(new VerletStick(balls[9], balls[2], tension, VerletStick.ARMATURE));
    sticks.add(new VerletStick(balls[8], balls[4], tension, VerletStick.ARMATURE));
    sticks.add(new VerletStick(balls[9], balls[5], tension, VerletStick.ARMATURE));

    // sticks - torso
    sticks.add(new VerletStick(balls[8], balls[7], tension, VerletStick.BODY));
    //sticks.add(new VerletStick(balls[7], balls[6], tension, VerletStick.BODY));
    sticks.add(new VerletStick(balls[6], balls[9], tension, VerletStick.BODY));
    sticks.add(new VerletStick(balls[9], balls[10], tension, VerletStick.BODY));
    sticks.add(new VerletStick(balls[10], balls[11], tension, VerletStick.BODY));
    sticks.add(new VerletStick(balls[11], balls[12], tension, VerletStick.BODY));
    sticks.add(new VerletStick(balls[12], balls[13], tension, VerletStick.BODY));
    sticks.add(new VerletStick(balls[13], balls[8], tension, VerletStick.BODY));

    // sticks - torso (armature)
    sticks.add(new VerletStick(balls[8], balls[10], tension, VerletStick.ARMATURE));
    sticks.add(new VerletStick(balls[9], balls[13], tension, VerletStick.ARMATURE));
    sticks.add(new VerletStick(balls[8], balls[11], tension, VerletStick.ARMATURE));
    sticks.add(new VerletStick(balls[9], balls[12], tension, VerletStick.ARMATURE));
    sticks.add(new VerletStick(balls[10], balls[12], tension, VerletStick.ARMATURE));
    sticks.add(new VerletStick(balls[13], balls[11], tension, VerletStick.ARMATURE));

    // sticks - pelvis
    //sticks.add(new VerletStick(balls[12], balls[11], tension, VerletStick.BODY));
    sticks.add(new VerletStick(balls[11], balls[16], tension, VerletStick.BODY));
    sticks.add(new VerletStick(balls[16], balls[15], tension, VerletStick.BODY));
    sticks.add(new VerletStick(balls[15], balls[14], tension, VerletStick.BODY));
    sticks.add(new VerletStick(balls[14], balls[12], tension, VerletStick.BODY));

    // sticks - pelvis (armature)
    sticks.add(new VerletStick(balls[12], balls[16], tension, VerletStick.ARMATURE));
    sticks.add(new VerletStick(balls[11], balls[14], tension, VerletStick.ARMATURE));
    sticks.add(new VerletStick(balls[12], balls[15], tension, VerletStick.ARMATURE));
    sticks.add(new VerletStick(balls[11], balls[15], tension, VerletStick.ARMATURE));

    // sticks - left femur
    //sticks.add(new VerletStick(balls[14], balls[15], tension, VerletStick.BODY));
    sticks.add(new VerletStick(balls[15], balls[18], tension, VerletStick.BODY));
    sticks.add(new VerletStick(balls[18], balls[17], tension, VerletStick.BODY));
    sticks.add(new VerletStick(balls[17], balls[14], tension, VerletStick.BODY));

    // sticks - left femur  (armature)
    sticks.add(new VerletStick(balls[14], balls[18], tension, VerletStick.ARMATURE));
    sticks.add(new VerletStick(balls[15], balls[17], tension, VerletStick.ARMATURE));

    // sticks - right femur
    //sticks.add(new VerletStick(balls[15], balls[16], tension, VerletStick.BODY));
    sticks.add(new VerletStick(balls[16], balls[19], tension, VerletStick.BODY));
    sticks.add(new VerletStick(balls[19], balls[20], tension, VerletStick.BODY));
    sticks.add(new VerletStick(balls[20], balls[15], tension, VerletStick.BODY));

    // sticks - right femur  (armature)
    sticks.add(new VerletStick(balls[15], balls[19], tension, VerletStick.ARMATURE));
    sticks.add(new VerletStick(balls[16], balls[20], tension, VerletStick.ARMATURE));


    // sticks - left tibia
    //sticks.add(new VerletStick(balls[17], balls[18], tension, VerletStick.BODY));
    sticks.add(new VerletStick(balls[18], balls[22], tension, VerletStick.BODY));
    sticks.add(new VerletStick(balls[22], balls[21], tension, VerletStick.BODY));
    sticks.add(new VerletStick(balls[21], balls[17], tension, VerletStick.BODY));

    // sticks - left tibia  (armature)
    sticks.add(new VerletStick(balls[17], balls[22], tension, VerletStick.ARMATURE));
    sticks.add(new VerletStick(balls[18], balls[21], tension, VerletStick.ARMATURE));

    // sticks - right tibia
    //sticks.add(new VerletStick(balls[19], balls[20], tension, VerletStick.BODY));
    sticks.add(new VerletStick(balls[20], balls[24], tension, VerletStick.BODY));
    sticks.add(new VerletStick(balls[24], balls[23], tension, VerletStick.BODY));
    sticks.add(new VerletStick(balls[23], balls[19], tension, VerletStick.BODY));

    // sticks - right tibia  (armature)
    sticks.add(new VerletStick(balls[19], balls[24], tension, VerletStick.ARMATURE));
    sticks.add(new VerletStick(balls[20], balls[23], tension, VerletStick.ARMATURE));

    // sticks - left foot
    sticks.add(new VerletStick(balls[21], balls[25], tension, VerletStick.BODY));
    sticks.add(new VerletStick(balls[25], balls[26], tension, VerletStick.BODY));
    sticks.add(new VerletStick(balls[26], balls[22], tension, VerletStick.BODY));

    // sticks - left foot  (armature)
    sticks.add(new VerletStick(balls[21], balls[26], tension, VerletStick.ARMATURE));
    sticks.add(new VerletStick(balls[22], balls[25], tension, VerletStick.ARMATURE));
    sticks.add(new VerletStick(balls[17], balls[25], tension, VerletStick.ARMATURE));
    sticks.add(new VerletStick(balls[18], balls[26], tension, VerletStick.ARMATURE));

    // sticks - right foot
    sticks.add(new VerletStick(balls[23], balls[27], tension, VerletStick.BODY));
    sticks.add(new VerletStick(balls[27], balls[28], tension, VerletStick.BODY));
    sticks.add(new VerletStick(balls[28], balls[24], tension, VerletStick.BODY));

    // sticks - right foot  (armature)
    sticks.add(new VerletStick(balls[23], balls[28], tension, VerletStick.ARMATURE));
    sticks.add(new VerletStick(balls[24], balls[27], tension, VerletStick.ARMATURE));
    sticks.add(new VerletStick(balls[19], balls[27], tension, VerletStick.ARMATURE));
    sticks.add(new VerletStick(balls[20], balls[28], tension, VerletStick.ARMATURE));

    // sticks - legs together  (armature)
    sticks.add(new VerletStick(balls[17], balls[19], tension, VerletStick.ARMATURE));
    sticks.add(new VerletStick(balls[18], balls[20], tension, VerletStick.ARMATURE));

    sticks.add(new VerletStick(balls[40], balls[27], tension, VerletStick.ARMATURE));


    //sticks.add(new VerletStick(balls[21], balls[23], .003, VerletStick.ARMATURE));
    /*sticks.add(new VerletStick(balls[20], balls[22], .003, VerletStick.ARMATURE));
     sticks.add(new VerletStick(balls[22], balls[28], .003, VerletStick.ARMATURE));
     sticks.add(new VerletStick(balls[24], balls[26], .003, VerletStick.ARMATURE));*/


    // sticks - left humerus
    sticks.add(new VerletStick(balls[8], balls[29], tension, VerletStick.BODY));
    sticks.add(new VerletStick(balls[29], balls[30], tension, VerletStick.BODY));
    sticks.add(new VerletStick(balls[30], balls[13], tension, VerletStick.BODY));

    // sticks - left humerus  (armature)
    sticks.add(new VerletStick(balls[8], balls[30], tension, VerletStick.ARMATURE));
    sticks.add(new VerletStick(balls[13], balls[29], tension, VerletStick.ARMATURE));
    sticks.add(new VerletStick(balls[3], balls[29], tension, VerletStick.ARMATURE));

    // sticks - right humerus
    sticks.add(new VerletStick(balls[9], balls[31], tension, VerletStick.BODY));
    sticks.add(new VerletStick(balls[31], balls[32], tension, VerletStick.BODY));
    sticks.add(new VerletStick(balls[32], balls[10], tension, VerletStick.BODY));

    // sticks - right humerus  (armature)
    sticks.add(new VerletStick(balls[9], balls[32], tension, VerletStick.ARMATURE));
    sticks.add(new VerletStick(balls[10], balls[31], tension, VerletStick.ARMATURE));
    sticks.add(new VerletStick(balls[2], balls[31], tension, VerletStick.ARMATURE));

    // sticks - left ulna
    sticks.add(new VerletStick(balls[29], balls[33], tension, VerletStick.BODY));
    sticks.add(new VerletStick(balls[33], balls[34], tension, VerletStick.BODY));
    //sticks.add(new VerletStick(balls[34], balls[30], tension, VerletStick.BODY));

    // sticks - left ulna  (armature)
    sticks.add(new VerletStick(balls[29], balls[34], tension, VerletStick.ARMATURE));
    sticks.add(new VerletStick(balls[30], balls[33], tension, VerletStick.ARMATURE));

    // sticks - right ulna
    sticks.add(new VerletStick(balls[31], balls[35], tension, VerletStick.BODY));
    sticks.add(new VerletStick(balls[35], balls[36], tension, VerletStick.BODY));
    sticks.add(new VerletStick(balls[36], balls[32], tension, VerletStick.BODY));

    // sticks - right ulna  (armature)
    sticks.add(new VerletStick(balls[31], balls[36], tension, VerletStick.ARMATURE));
    sticks.add(new VerletStick(balls[32], balls[35], tension, VerletStick.ARMATURE));

    // both arms together
    sticks.add(new VerletStick(balls[29], balls[31], tension, VerletStick.ARMATURE));
    sticks.add(new VerletStick(balls[34], balls[36], tension, VerletStick.ARMATURE));
    sticks.add(new VerletStick(balls[33], balls[35], tension, VerletStick.ARMATURE));

    // sticks - left hand
    sticks.add(new VerletStick(balls[33], balls[37], tension, VerletStick.BODY));
    sticks.add(new VerletStick(balls[37], balls[38], tension, VerletStick.BODY));
    sticks.add(new VerletStick(balls[38], balls[34], tension, VerletStick.BODY));

    // sticks - left hand  (armature)
    sticks.add(new VerletStick(balls[33], balls[38], tension, VerletStick.ARMATURE));
    sticks.add(new VerletStick(balls[34], balls[37], tension, VerletStick.ARMATURE));
    sticks.add(new VerletStick(balls[30], balls[38], tension, VerletStick.ARMATURE));

    // sticks - right hand
    sticks.add(new VerletStick(balls[35], balls[39], tension, VerletStick.BODY));
    sticks.add(new VerletStick(balls[39], balls[40], tension, VerletStick.BODY));
    sticks.add(new VerletStick(balls[40], balls[36], tension, VerletStick.BODY));

    // sticks - right hand  (armature)
    sticks.add(new VerletStick(balls[35], balls[40], tension, VerletStick.ARMATURE));
    sticks.add(new VerletStick(balls[36], balls[39], tension, VerletStick.ARMATURE));


    // linkages
    sticks.add(new VerletStick(balls[38], balls[17], tension, VerletStick.ARMATURE));
    sticks.add(new VerletStick(balls[40], balls[32], tension, VerletStick.ARMATURE));
  }


  void initRandomMotion() {
    for (int i=0; i<balls.length; i++) {
      if (balls[i] != null) {
        balls[i].pos.y += random(-.01, .01);
      }
    }
  }

  void draw() {
    pushMatrix();
    translate(loc.x, loc.y);
    if (isBodyVisible) {
      // head
      beginShape();
      vertex(balls[0].pos.x, balls[0].pos.y);
      vertex(balls[1].pos.x, balls[1].pos.y);
      vertex(balls[2].pos.x, balls[2].pos.y);
      vertex(balls[5].pos.x, balls[5].pos.y);
      vertex(balls[4].pos.x, balls[4].pos.y);
      vertex(balls[3].pos.x, balls[3].pos.y);
      endShape(CLOSE);

      // neck
      beginShape(); 
      vertex(balls[4].pos.x, balls[4].pos.y);
      vertex(balls[5].pos.x, balls[5].pos.y);
      vertex(balls[6].pos.x, balls[6].pos.y);
      vertex(balls[7].pos.x, balls[7].pos.y);
      endShape(CLOSE);

      // torso
      beginShape(); 
      vertex(balls[8].pos.x, balls[8].pos.y);
      vertex(balls[7].pos.x, balls[7].pos.y);
      vertex(balls[6].pos.x, balls[6].pos.y);
      vertex(balls[9].pos.x, balls[9].pos.y);
      vertex(balls[10].pos.x, balls[10].pos.y);
      vertex(balls[11].pos.x, balls[11].pos.y);
      vertex(balls[12].pos.x, balls[12].pos.y);
      vertex(balls[13].pos.x, balls[13].pos.y);
      endShape(CLOSE);

      // pelvis
      beginShape(); 
      vertex(balls[12].pos.x, balls[12].pos.y);
      vertex(balls[11].pos.x, balls[11].pos.y);
      vertex(balls[16].pos.x, balls[16].pos.y);
      vertex(balls[15].pos.x, balls[15].pos.y);
      vertex(balls[14].pos.x, balls[14].pos.y);
      endShape(CLOSE);

      // left femur
      beginShape(); 
      vertex(balls[14].pos.x, balls[14].pos.y);
      vertex(balls[15].pos.x, balls[15].pos.y);
      vertex(balls[18].pos.x, balls[18].pos.y);
      vertex(balls[17].pos.x, balls[17].pos.y);
      endShape(CLOSE);

      // right femur
      beginShape(); 
      vertex(balls[16].pos.x, balls[16].pos.y);
      vertex(balls[15].pos.x, balls[15].pos.y);
      vertex(balls[20].pos.x, balls[20].pos.y);
      vertex(balls[19].pos.x, balls[19].pos.y);
      endShape(CLOSE);

      // left tibia
      beginShape(); 
      vertex(balls[17].pos.x, balls[17].pos.y);
      vertex(balls[18].pos.x, balls[18].pos.y);
      vertex(balls[22].pos.x, balls[22].pos.y);
      vertex(balls[21].pos.x, balls[21].pos.y);
      endShape(CLOSE);

      // right tibia
      beginShape(); 
      vertex(balls[19].pos.x, balls[19].pos.y);
      vertex(balls[20].pos.x, balls[20].pos.y);
      vertex(balls[24].pos.x, balls[24].pos.y);
      vertex(balls[23].pos.x, balls[23].pos.y);
      endShape(CLOSE);

      // left foot
      beginShape(); 
      vertex(balls[21].pos.x, balls[21].pos.y);
      vertex(balls[22].pos.x, balls[22].pos.y);
      vertex(balls[26].pos.x, balls[26].pos.y);
      vertex(balls[25].pos.x, balls[25].pos.y);
      endShape(CLOSE);

      // right foot
      beginShape(); 
      vertex(balls[23].pos.x, balls[23].pos.y);
      vertex(balls[24].pos.x, balls[24].pos.y);
      vertex(balls[28].pos.x, balls[28].pos.y);
      vertex(balls[27].pos.x, balls[27].pos.y);
      endShape(CLOSE);

      // left humerous
      beginShape(); 
      vertex(balls[8].pos.x, balls[8].pos.y);
      vertex(balls[29].pos.x, balls[29].pos.y);
      vertex(balls[30].pos.x, balls[30].pos.y);
      vertex(balls[13].pos.x, balls[13].pos.y);
      endShape(CLOSE);

      // right humerous
      beginShape(); 
      vertex(balls[9].pos.x, balls[9].pos.y);
      vertex(balls[31].pos.x, balls[31].pos.y);
      vertex(balls[32].pos.x, balls[32].pos.y);
      vertex(balls[10].pos.x, balls[10].pos.y);
      endShape(CLOSE);

      // left ulna
      beginShape(); 
      vertex(balls[29].pos.x, balls[29].pos.y);
      vertex(balls[30].pos.x, balls[30].pos.y);
      vertex(balls[34].pos.x, balls[34].pos.y);
      vertex(balls[33].pos.x, balls[33].pos.y);
      endShape(CLOSE);

      // right ulna
      beginShape(); 
      vertex(balls[31].pos.x, balls[31].pos.y);
      vertex(balls[32].pos.x, balls[32].pos.y);
      vertex(balls[36].pos.x, balls[36].pos.y);
      vertex(balls[35].pos.x, balls[35].pos.y);
      endShape(CLOSE);

      // left hand
      beginShape(); 
      vertex(balls[33].pos.x, balls[33].pos.y);
      vertex(balls[37].pos.x, balls[37].pos.y);
      vertex(balls[38].pos.x, balls[38].pos.y);
      vertex(balls[34].pos.x, balls[34].pos.y);
      endShape(CLOSE);

      // right hand
      beginShape(); 
      vertex(balls[35].pos.x, balls[35].pos.y);
      vertex(balls[39].pos.x, balls[39].pos.y);
      vertex(balls[40].pos.x, balls[40].pos.y);
      vertex(balls[36].pos.x, balls[36].pos.y);
      endShape(CLOSE);

      //balls[selectdBallID].render();
    }
    if (isArmatureVisible) {
      stroke(255, 0, 0);
      for (int i=0; i<sticks.size(); i++) {
        sticks.get(i).render();
      }

      for (int i=0; i<anchorSticks.length; i++) {
        anchorSticks[i].render();
      }
    }
    popMatrix();
  }

  void createSkeleton() {
    // verlet balls
    // sticks
  }



  void create() {
  }

  void run() {
    // in normal verlet mode
    if (!isResetMode) {
      for (int i=0; i<balls.length; i++) {
        //println("in verlet mode");//
        balls[i].verlet();
        balls[i].pos.y += gravity;
      }
      for (int i=0; i<sticks.size(); i++) {
        sticks.get(i).constrainLen();
      }
    } 
    else {  // in reset mode
      //println("resetCounter = " + resetCounter);
      if (resetCounter<resetSteps-1) {
        for (int i=0; i<balls.length; i++) {
          ///println("resetCounter = " + resetCounter);
          balls[i].pos.add(deltas[i]);
        }
        resetCounter++;
      } 
      else {
        for (int i=0; i<balls.length; i++) {
          balls[i].reset();
          resetCounter=0;
          isResetMode = false;
        }
        //setSticks();
      }
    }// end for
    /* for (int i=0; i<sticks.size(); i++) {
     sticks.get(i).constrainLen();
     }*/

    // void constrainLenCustom(float constraintB1, float constraintB2)
    anchorSticks[0].constrainLenCustom(0, 1);
    anchorSticks[1].constrainLenCustom(0, 1);
  }


  void edgeCollide(float xScale, float yScale) {
    for (int i=0; i<balls.length; i++) {
      if (balls[i] != null) {
        if (balls[i].pos.y > height/(2*yScale)) {
          //for (int j=0; j<balls.length; j++) {
          //balls[j].pos.y = balls[j].posOld.y;
          //}
          balls[i].pos.y = balls[i].posOld.y;
          //balls[i].pos.y = 0;
        } 
        else if (balls[i].pos.y < -height/(2*yScale)) {

          balls[i].pos.y = balls[i].posOld.y;
        }
        if (balls[i].pos.x > width/(2*xScale)) {

          balls[i].pos.x = balls[i].posOld.x;
        } 
        else if (balls[i].pos.x < -width/(2*xScale)) {

          balls[i].pos.x = balls[i].posOld.x;
        }
      }
    }
  }


  /* void nudge(int id) {
   float val = .07;
   switch (id) {
   case 0:
   balls[0].pos.x+=val;
   break;
   case 1:
   balls[0].pos.x-=val;
   break;
   case 2:
   balls[0].pos.y-=val;
   break;
   case 3:
   balls[0].pos.y+=val;
   break;
   }
   }*/

  void nudge(int id) {
    float val = .07;
    balls[id].pos.x+=random(-val, val);
  }

  void nudge(int id, float val) {
    int b = int(random(balls.length));
    selectdBallID = b;
    if (balls[b] != null) {
      switch (id) {
      case 0:
        balls[b].pos.x+=val;
        break;
      case 1:
        balls[b].pos.x-=val;
        break;
      case 2:
        balls[b].pos.y-=val;
        break;
      case 3:
        balls[b].pos.y+=val;
        break;
      }
    }
  }

  void midiMapNudge(int id, float vel) {
    int ballID =  (int)midiNodeMap[id][0];
    float pushX =  midiNodeMap[int(id)][1];
    float pushY =  midiNodeMap[int(id)][2];
    if (balls[ballID] != null && !isResetMode ) {
      selectdBallID = ballID;
      balls[ballID].pos.x += pushX*vel;
      balls[ballID].pos.y += pushY*vel;
      //balls[ballID].render();
      // get ball to illuminate
      //ellipse(balls[ballID].pos.x, balls[ballID].pos.y, .02, .02);
    }
  }

  void setBodyVisible(boolean isBodyVisible) {
    this.isBodyVisible = isBodyVisible;
  }

  void setSkeletonVisible(boolean isSkeletonVisible) {
    this.isSkeletonVisible = isSkeletonVisible;
  }

  void setArmatureVisible(boolean isArmatureVisible) {
    this.isArmatureVisible = isArmatureVisible;
  }

  void setStatsVisible(boolean isStatsVisible) {
    this.isStatsVisible = isStatsVisible;
  }

  void setGravity(int g){
    if (g==0){
      gravity += .0001;
    } else {
      gravity -= .0001;
    }
  }
  
  
  void reset() {
    isResetMode = true;
    resetCounter = 0;
    for (int i=0; i<balls.length; i++) {
      // reset mode
      deltas[i] = PVector.sub(ballsInitPos[i].get(), balls[i].pos);
      deltas[i].div(resetSteps);
    }
  }
}

