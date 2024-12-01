

void setup() {
  
  size(900,400);
  smooth();
  
} 

void coseno(float h, int f) {
  int n = 100;
  //int n = int(map(mouseX,0,width,40,1000));
  noFill();
  stroke(220);
  strokeWeight(3);
  beginShape();
  for (int i=0; i<n; i++) {
    float x = map(i,0,n-1,-50,width+50);
    float y = h + 20 * cos(0.04*x + PI*f);
    curveVertex(x,y); 
  }
  endShape();
}

void flor(float x, float y) {
  fill(250,200,30);
  noStroke();
  ellipse(x,y,6,6);
  
  int m=12;
  for (int r=0; r<m; r++) {
    pushMatrix();
    translate(x,y);
    float a = PI * map(r,0,m,0,2);
    rotate(a);
    float d1 = 7;
    float x1 = -20 - map(cos(2*a),-1,1,2,10);
    float d2 = 2;
    float x2 = -10;
    
    fill(220);
    noStroke();
    ellipse(x1,0,d1,d1);
    ellipse(x2,0,d2,d2);
    beginShape();
    vertex(x1,d1*0.5);
    vertex(x2,d2*0.5);
    vertex(x2,-d2*0.5);
    vertex(x1,-d1*0.5);
    endShape(CLOSE);
    
    popMatrix();
  }  
}


void draw() {
  
  //background(40,130,145);
  background(20,20,20);
  for (int k=0; k<10; k++) {
    float h = 30+k*50;
    coseno(h,k%2);
  }
  
  float a = 156;
  PVector aa = new PVector(1,0);
  float b = 156;
  PVector bb = new PVector(0.5,-0.32);
  
  noFill();
  stroke(240);
  int nx = 6;
  int ny = 6;
  for (int i=-nx; i<nx; i++) {
    for (int j=-ny; j<ny; j++) {
      float x = i*a*aa.x+j*b*bb.x + 313;
      float y = i*a*aa.y+j*b*bb.y + 205;
      flor(x,y);
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
  
  String new_file = "daifuku_" + nf(maximo+1,3) + ".png";
  println(new_file);
  
  
  //save(new_file);
  noLoop();
}
