color iro1,iro2;
float offx, offy;
int d;
int n;

//Sol sol;
ArrayList<Sol> soles;

void setup() {
  
  size(750,500);
  
 
  iro1 = color(25,101,107);
  iro2 = color(24,142,197);
  
  d = 60;

  offx = d*0.4;
  offy = d*0.3; 
 
  soles = new ArrayList<Sol>();
  
  int k=0;
  for (int i=-1; i<int(width/(2*d)+1); i++) {
    float xe = i*2*d + d + offx;
    for (int j=-1; j<int(height/(2*d)+2); j++) {
      float ye = j*2*d + d + offy;
      k += 1;
      soles.add(new Sol(k,d,xe,ye));
    }
  }
  println(soles.size());
  
}

void draw() {
 
  background(iro1);
  for (Sol sol: soles) {
    sol.debuxar();
  }
  
  noFill();
  float xe, ye;
  for (int i=-1; i<int(width/(2*d)+1); i++) {
    xe = i*2*d + d + offx;
    for (int j=-1; j<int(height/(2*d)+2); j++) {
      ye = j*2*d + d + offy;
      stroke(iro2);
      strokeWeight(3);
      circle(xe,ye,2*d);
      stroke(200);
      strokeWeight(1);
      circle(xe,ye,2*d);
    }
  }
  for (int i=0; i<int(width/d)+1; i++) {
      xe = i*2*d + offx;
      stroke(iro2);
      strokeWeight(3);
      line(xe,0,xe,height);
      stroke(200);
      strokeWeight(1);
      line(xe,0,xe,height);
      xe += d;
      stroke(iro2);
      strokeWeight(3);
      line(xe,0,xe,height);
      stroke(200);
      strokeWeight(1);
      line(xe,0,xe,height);
  }  
}
