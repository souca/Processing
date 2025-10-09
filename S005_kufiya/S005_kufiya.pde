// >< {}

float d = 110;
float d1 = 2*d/5;
float d2 = 1*d/8;
float d3 = 1*d/16;

void setup() {
  size(880, 400);
  smooth();
}

//{}
void cuadro_sin_rotar(float x, float y) {
 
  pushMatrix();
  
  //rombito a la derecha
  translate(x+d/sqrt(2),y);
  noStroke();
  fill(120);
  rectMode(CENTER);
  beginShape();
  vertex(d3/2,0);
  vertex(0,d3);
  vertex(-d3/2,0);
  vertex(0,-d3);
  endShape(CLOSE);

  //rombito a la izquierda
  translate(-d/sqrt(2),d/sqrt(2));
  rectMode(CENTER);
  beginShape();
  vertex(d3/2,0);
  vertex(0,d3);
  vertex(-d3/2,0);
  vertex(0,-d3);
  endShape(CLOSE);
  popMatrix();

  pushMatrix();
  translate(x,y);
  for (int r=0; r<3; r++) {
    rotate(PI*r);
    float q1 = sqrt(2)*(d1/2+d2);
    float q2 = d*sqrt(2)/2-d3/2;
    float q3 = d*sqrt(2)/2-d3;
    for (int k=0; k<4; k++) {
      float qx = map(k,0,4,q1,q2);
      //float qy = map(k,0,4,q2,q1);
      float qz = map(k,0,4,q3,q1);
      if (k>0 && k<4) {
        ellipse(qx,0,2,2);
        ellipse(0,qz,2,2);
      }
    }
  }
  translate(d*sqrt(2)/2,d*sqrt(2)/2);
  int r0=0;
  int rf=3;
  for (int r=r0; r<rf; r++) {
    rotate(PI*r);
    float q1 = sqrt(2)*(d1/2+d2);
    float q2 = d*sqrt(2)/2-d3/2;
    float q3 = d*sqrt(2)/2-d3;
    int k0=0;
    int kf=4;
    for (int k=k0; k<kf; k++) {
      float qx = map(k,k0,kf,q1,q2);
      float qz = map(k,k0,kf,q3,q1);
      if (k>k0 && k<kf) {
        ellipse(qx,0,2,2);
        ellipse(0,qz,2,2);
      }
    }
  }
  popMatrix();
  
}

void cuadro_rotado(float x, float y) {

  pushMatrix();
  rotate(PI*0.25);
  translate(x, y);

  //lineas NSWE
  stroke(120);
  //line(0, 0, 60, 60);
  //line(0, 0, -60, 60);
  //line(0, 0, 60, -60);
  //line(0, 0, -60, -60);
  noStroke();

  //cuadraditos grises en las esquinas
  fill(120);
  rect( (d1+d2)/2, (d1+d2)/2, d2, d2);
  rect(-(d1+d2)/2, (d1+d2)/2, d2, d2);
  rect( (d1+d2)/2, -(d1+d2)/2, d2, d2);
  rect(-(d1+d2)/2, -(d1+d2)/2, d2, d2);

  // barritas /
  PVector qq1 = new PVector(-d1/2,-d1/2-d2);
  PVector qq2 = new PVector(-d1/2, d1/2+d2);
  PVector qq3 = new PVector( d1/2,-d1/2-d2);
  PVector qq4 = new PVector( d1/2, d1/2+d2);
  
  stroke(120);
  strokeWeight(3);
  int n0 = 0;
  int nf = 6;
  for (int k=n0; k<nf; k++) {
    float mqx_0 = map(k,n0,nf,qq1.x,qq3.x);
    float mqx_1 = map(k,n0,nf,qq2.x,qq4.x);
    float mqy_0 = map(k,n0,nf,qq1.y,qq3.y);
    float mqy_1 = map(k,n0,nf,qq2.y,qq4.y);
    if (k>n0 && k<nf) {
      line(mqx_0,mqy_0,mqx_1,mqy_1);
      }
  }
  noStroke();

  // barritas \
  PVector pp1 = new PVector(-d1/2-d2,-d1/2);
  PVector pp2 = new PVector( d1/2+d2,-d1/2);
  PVector pp3 = new PVector(-d1/2-d2, d1/2);
  PVector pp4 = new PVector( d1/2+d2, d1/2);
  
  stroke(120);
  strokeWeight(3);
  for (int k=n0; k<nf; k++) {
    float mqx_0 = map(k,n0,nf,pp1.x,pp3.x);
    float mqx_1 = map(k,n0,nf,pp2.x,pp4.x);
    float mqy_0 = map(k,n0,nf,pp1.y,pp3.y);
    float mqy_1 = map(k,n0,nf,pp2.y,pp4.y);
    if (k>n0 && k<nf) {
      line(mqx_0,mqy_0,mqx_1,mqy_1);
      }
  }
  noStroke();


  //cuadrado negro principal
  rectMode(CENTER);
  fill(200);
  noStroke();
  rect(0, 0, d1, d1);

  fill(200);
  ellipse(d/2,0,5,5);
  ellipse(0,d/2,5,5);

  
  popMatrix();
}

void draw() {
  background(40);
  noFill();
  stroke(40);
  int nx=9;
  int ny=6;
  for (int i=-nx; i<nx; i++) {
    for (int j=-ny; j<ny; j++) {
      float x = i*d;
      float y = j*d;
      cuadro_rotado(x, y);
    }
  }
  for (int i=-nx; i<nx; i++) {
    for (int j=-ny; j<ny; j++) {
      float x = i*d*sqrt(2);
      float y = j*d*sqrt(2);
      cuadro_sin_rotar(x,y);
    }
  }  

  String path = sketchPath();
  File[] files = listFiles(path);
  ArrayList<String> pngs = new ArrayList<String>();
  for (int i=0; i<files.length; i++) {
    String png = files[i].getName();
    if (png.substring(10,14).equals(".png")) {
      pngs.add(png);
    }
  }

  int maximo = 0;
  for (int j=0; j<pngs.size(); j++) {
    println(pngs.get(j));
    int num = int(pngs.get(j).substring(8,10));
    println(nf(num,3));
    if (num > maximo) {
      maximo = num;
    }
  }

  String new_file = "kufiya_" + nf(maximo+1,3) + ".png";
  println(new_file);

  noLoop();
}
