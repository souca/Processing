color iro1,iro2;
float offx, offy;
int d;
int n;

//Sol sol;
ArrayList<Sol> soles;

void setup() {
  
  size(750,500);
  
 
  iro1 = color(20,70,40);
  iro2 = color(249,229,143);
  
  d = 40;

  offx = random(d);
  offy = random(d); 
 
  soles = new ArrayList<Sol>();
  
  int k=0;
  for (int i=-1; i<int(width/(2*d)+1); i++) {
    float xe = i*2*d + d + offx;
    for (int j=-1; j<int(height/(2*d)+1); j++) {
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
  stroke(iro2);
  strokeWeight(1);
  float xe, ye;
  for (int i=-1; i<int(width/(2*d)+1); i++) {
    xe = i*2*d + d + offx;
    for (int j=-1; j<int(height/(2*d)+1); j++) {
      ye = j*2*d + d + offy;
      circle(xe,ye,2*d);
    }
  }
  for (int i=0; i<int(width/d)+1; i++) {
      xe = i*2*d + offx;
      line(xe,0,xe,height);
      xe += d;
      line(xe,0,xe,height);
  }  
}
