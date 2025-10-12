int nx,ny;
int bx,by;
PVector[] centros;
color[] iros;

void setup() {
  
  size(630,830);//, SVG, "jarl.svg");
  
  nx = 20;
  ny = int(nx * height / float(width));
  
  bx = 4;
  by = 4;
  
  iros = new color[5];
  iros[0] = #be0f5a;
  iros[1] = #1e375f;
  iros[2] = #c3375f;
  iros[3] = #6fcff2;
  iros[4] = #f29e0d;
  
  int m = (nx-2*bx+1) * (ny-2*by+1);
  int k = 0;
  centros = new PVector[m];
  for (int i=bx; i<nx-(bx-1); i++) {
    for (int j=by; j<ny-(by-1); j++) {
   
      float x = map(i,0,nx,0,width);
      float y = map(j,0,ny,0,height);
      
      float fuerza = map(j,by,ny-(by),10,0);
      float ox = fuerza * random(-1,1);
      float oy = fuerza * random(-1,1);
      float rr = map(fuerza,0,10,0,0.25*PI) * random(-1,1);
      
      centros[k] = new PVector(x+ox,y+oy,rr);
      
      k++;
    }
  }
  
}

void draw() {
  
  background(#eee5c8);
  rectMode(CENTER);
  
  for (int k=0; k<centros.length; k++) {

      float xx = centros[k].x;
      float yy = centros[k].y;
      float rr = centros[k].z;
      
      pushMatrix();
      translate(xx,yy);
      rotate(rr);
      
      
      noStroke();
      int t1 = int(10*abs(sin(0.92312312*k+0.2313213)))%iros.length;
      float r1 = red(iros[t1]);
      float g1 = green(iros[t1]);
      float b1 = blue(iros[t1]);
      fill(r1,g1,b1,125);
      rect(0,0,31.5,31.5);
      fill(#eee5c8);
      rect(0,0,10,10);
      int t2 = int(10*abs(sin(0.34958305*k+0.2934820384)))%iros.length;
      t2 = (t2==t1) ? (t2+1)%iros.length : t2;
      float r2 = red(iros[t2]);
      float g2 = green(iros[t2]);
      float b2 = blue(iros[t2]);
      fill(r2,g2,b2,125);
      rect(0,0,10,10);
      
      popMatrix();
    
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
  
  String new_file = "cuadros_movidos" + nf(maximo+1,3) + ".png";
  println(new_file);
  
  
  //save(new_file);
  noLoop();
  
}
