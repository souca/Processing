int n1;
int n2;
float r1;
float r2;

void setup() {
  
  size(500,500);
  n1 = 11;
  n2 = 21;
  r1 = 250;
  r2 = 30;

}


void draw() {
  
  n1 = int(map(mouseX,0,width,5,21));
  n2 = int(map(mouseY,0,width,5,21));
    
  background(30);
  
  pushMatrix();
  translate(width/2,height/2);
  
  float delta = TWO_PI/float(n1);
  
  float[] bs = new float[n2];
  for (int i=0; i<n2; i++) {
    bs[i] = map(i,0,n2,r1,r2*0.5);
  }
  
  for (int j=0; j<n2-2; j+=2) {
    for (int i=0; i<n1; i++) {
      noStroke();
      fill(210,210,201);
      beginShape();
      vertex(bs[j  ]*cos((i+0.5)*delta), bs[j  ]*sin((i+0.5)*delta));
      vertex(bs[j+1]*cos((i)*delta),     bs[j+1]*sin((i)*delta));
      vertex(bs[j+2]*cos((i+0.5)*delta), bs[j+2]*sin((i+0.5)*delta));
      vertex(bs[j+1]*cos((i+1)*delta),   bs[j+1]*sin((i+1)*delta));
      endShape();    
    }
    
  }
  popMatrix();
  
  text(n1,width-20,20);
  text(n2,width-20,30);
  
}
