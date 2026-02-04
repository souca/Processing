

void setup() {
  size(800,400);
}

void celda(float xx, float yy, color iro) {
  
  float oox = 47;
  float ooy = 32;
  float r = 30;
  
  pushMatrix();
  translate(xx,yy);
  
  fill(246,242,224);
  noStroke();
  rect(oox-r/2-2,0,r+4,100);

  stroke(246,242,224);
  strokeWeight(10);
  fill(200,0,100);
  beginShape();
   
  for (int k=0; k<6; k++) {
    float a = map(k,0,6,0,2*PI);
    float x = r*cos(a) + oox;
    float y = r*sin(a) + ooy;
    if (k==0) {
      x+=10;
    } else if (k==3) {
      x-=10;
    }
    vertex(x,y);
  }
  endShape(CLOSE);
  
  fill(iro);
  noStroke();
  pushMatrix();
  translate(oox, 80);
  beginShape();
  vertex(10,0);
  vertex(0,10);
  vertex(-10,0);
  vertex(0,-10);
  endShape();
  popMatrix();
 
  //noFill();
  //stroke(255);
  //strokeWeight(1);
  //rect(0,0,2*oox,100);
  
  popMatrix();
}

void draw() {
  background(50,0,25);
  color[] iros = {color(0,204,0), color(250,150,50), color(50,150,250), color(0,50,170),color(200,0,100),color(0,100,100)};
  float px = 2*47;
  float py = 100;
  for (int i=-1;i<9;i++) {
    for (int j=-1;j<4;j++) { 
      int ollo = int(map(abs(sin(i*2.121-1.21*j)*10),0,10,0,iros.length));
      celda(i*px+25,j*py+10,iros[ollo]); 
    }
  }
  save("ola.png");
  noLoop();
}
