
void setup() {
  size(500,500);
  colorMode(HSB, 365, 100, 100);
}

color random_iro() {
  int h = int(random(365));
  int s = int(random(100));
  int b = int(random(50,100));
  color iro = color(h,s,b);
  return iro;
}

void draw() {
  
  background(200,4,100);
  
  color[] iros = {random_iro(), random_iro(), random_iro()};
  int ollo = int(random(iros.length)); 
  int s = 5; // ancho del pixel
  int d = 13; // ancho del carril
  int n = 5; // pixeles por cuadro
  int offx = 8; // offset
  int offy = 4; // ......

  noStroke();
  
  
  for (int i=-1; i<int(width/(s*n+d)+1); i++) {
    for (int j=-1; j<int(height/(s*n+d)+1); j++) {
    
      for (int kx=0; kx<n; kx++) {
        for (int ky=0; ky<n; ky++) {
          ollo = int(random(iros.length)); 
          fill(iros[ollo]);
          int xx = i*(s*n+d)+kx*s+offx;
          int yy = j*(s*n+d)+ky*s+offy;
          rect(xx,yy,s,s);
        }
      }
    }
  }
  
  if (d%2!=0 && d>=3) {
    stroke(200,4,90);
    strokeWeight(1);
    for (int i=0; i<int(width/(s*n+d)+1); i++) {
      int px = offx + i*(s*n+d) + s*n+d/2;
      line(px,0,px,height);
    }
    for (int i=0; i<int(height/(s*n+d)+1); i++) {
      int py = offy + i*(s*n+d) + s*n+d/2;
      line(0,py,width,py);
    }
  }
  
  save("ola.png");
  noLoop();
}
