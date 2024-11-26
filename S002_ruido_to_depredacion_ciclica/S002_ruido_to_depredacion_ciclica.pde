int size;
int nx, ny;
color[] iros;
int[] mapa;
int[] new_mapa;
boolean running;

int nsatur;

void setup() {

  size(600, 501);
  background(255);
  running = false;

  iros = new color[3];
  iros[0] = color(0, 100, 200);
  iros[1] = color(200, 200, 250);
  iros[2] = color(255);

  frameRate(30);

  nsatur = 2;

  size = 3;
  nx = width/size;
  ny = height/size;

  mapa = new int[nx*ny];
  for (int k=0; k<mapa.length; k++) {
    float x = int((k%nx)*size-width/2);
    float y = int((k/nx)*size-height/2);
    float d = dist(x,y,0,0);

    
    mapa[k] = int(random(0, 3));
    
    
  }
  

  new_mapa = new int[nx*ny];
}

void keyReleased() {

  if (key == ' ') {
    running = !running;
  }
}

boolean get_vecinos(int k, int iro, int aim) {

  int con = 0;
  boolean[] t = new boolean[4];
  t[0] = (k%nx==0);
  t[1] = (k%nx==nx-1);
  t[2] = (k/nx==ny-1);
  t[3] = (k/nx==0);

  int[] iii = new int[8];
  iii[0] = k-nx-1;
  iii[1] = k-nx;
  iii[2] = k-nx+1;
  iii[3] = k-1;
  iii[4] = k+1;
  iii[5] = k+nx-1;
  iii[6] = k+nx;
  iii[7] = k+nx+1;


  if (t[0]) {  
    iii[0] = k-1;
    iii[3] = k+nx-1;
    iii[5] = k+2*nx-1;
  }
  if (t[1]) {  
    iii[2] = k-2*nx+1;
    iii[4] = k-nx+1;
    iii[7] = k+1;
  }
  if (t[2]) {  
    iii[5] = k%nx-1;
    iii[6] = k%nx;
    iii[7] = k%nx+1;
  }
  if (t[3]) {  
    iii[0] = nx*ny-1 -(nx+1) + (k%nx) -1;
    iii[1] = nx*ny-1 -(nx+1) + (k%nx) ;
    iii[2] = nx*ny-1 -(nx+1) + (k%nx) +1;
  }

  if ((t[0])&&(!t[1])&&(!t[2])&&(t[3])) {  //NW
    iii[0] = nx*ny-1;
  } else if ((t[0])&&(!t[1])&&(t[2])&&(!t[3])) { //SW  
    iii[5] = nx-1;
  } else if ((!t[0])&&(t[1])&&(!t[2])&&(t[3])) { //NE
    iii[2] = nx*ny-1-nx;
  } else if ((!t[0])&&(t[1])&&(t[2])&&(!t[3])) { //SE
    iii[7] = 0;
  }

  con += int(mapa[iii[0]] == aim);
  con += int(mapa[iii[1]] == aim);
  con += int(mapa[iii[2]] == aim);
  con += int(mapa[iii[3]] == aim);
  con += int(mapa[iii[4]] == aim);
  con += int(mapa[iii[5]] == aim);
  con += int(mapa[iii[6]] == aim);
  con += int(mapa[iii[7]] == aim);    



  return (con>nsatur);
}

void draw() {

  if (running) {

    background(255);

    for (int k=0; k<nx*ny; k++) {

      int i = k%nx;
      int j = k/nx;
      fill(iros[mapa[k]]);
      noStroke();
      rect(i*size, j*size, size, size);


      int aim = (mapa[k]+1)%3;

      if (get_vecinos(k, mapa[k], aim)) {
        new_mapa[k] = aim;
      } else {
        new_mapa[k] = mapa[k];
      }
    }


    mapa = new_mapa;
    new_mapa = new int[nx*ny];
  } else {

    for (int k=0; k<nx*ny; k++) {

      int i = k%nx;
      int j = k/nx;
      fill(iros[mapa[k]]);
      noStroke();
      rect(i*size, j*size, size, size);
    }
  }
}
