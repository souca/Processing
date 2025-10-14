float a0;
PVector a1, a2;
float offx, offy;
float scale;
int nx,ny;
float t;

void setup() {

  size(500, 500);
  t = 0;
  scale = 0.4;
  
  a0 = 170;
  float a = a0* scale;
  a1 = new PVector(a*sin(PI/3.), a*cos(PI/3.));
  a2 = new PVector(a*sin(PI/3.), -a*cos(PI/3.));
  
  float w = 2*a1.x;
  float h = 2*a1.y;
  
  nx = int(width/w)*2;
  ny = int(height/h)*2;
  
}


void draw() {

  background(10, 10, 50);
  //debuxar_ollo(width/2, height/2, 1.0);
  
  float a = a0 * scale;
  a1 = new PVector(a*sin(PI/3.), a*cos(PI/3.));
  a2 = new PVector(a*sin(PI/3.), -a*cos(PI/3.));  

  offx = width/2;//map(mouseX,0,width,0,80);
  offy = height/2;//map(mouseY,0,height,0,80)+height/2;
  

  noStroke();
  fill(255);
  for (int i=-nx; i<nx; i++) {
    for (int j=-ny; j<ny; j++) {
      float x = i*a1.x + j*a2.x + offx;
      float y = i*a1.y + j*a2.y + offy;
      float z = (i+0.5)*a1.x + (j+0.5)*a2.x + offx;
      debuxar_ollo(x, y, scale, 0);

      //fill(250, 250, 240);
      //ellipse(z, y, 100, 100);
      
      int t=0;
      if        ( (i%2==0) && (j%2==0) ) {
        t = 0;
      } else if ( (i%2==0) && (j%2!=0) ) {
        t = 1;
      } else if ( (i%2!=0) && (j%2==0) ) {
        t = 2;
      } else if ( (i%2!=0) && (j%2!=0) ) {
        t = 3;
      }
      
      
      debuxar_bola(z, y, scale, t);
    }
  }
  //noLoop();
}
