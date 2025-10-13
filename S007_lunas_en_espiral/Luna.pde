class Luna {
  PGraphics pg;
  PVector n;
  float r0;
  float r1;
  float d;
  float t;
  int fase;
  float t1;
  float sombra;
  color iro;
  
  float x, y;
  
  int dni;
  float dd;
  
  Luna(int _dni, float _d, float _x, float _y) {
    
    dni = _dni;
    
    x = _x;
    y = _y;
    
    r0 = 10*0.6;

    n = new PVector(2.5*r0,2.5*r0);
    pg = createGraphics(int(n.x),int(n.y));
    

    float desfase = 0.0;
    d = _d + desfase;
   
    // Pasamos del parámetro de entrada d (0,1) 
    // que marca un ciclo lunar entero
    // a una sierra con dd (0,1);
    // dd marca el momento de la fase:
    //  dd=1 es fase llena o nueva
    //  dd=0 es cuarto menguante o creciente
    dd = (4*d)%1;
    if (int(4*d)%2==0) {
      dd = 1-dd;
    }
    
    if ((d>=0) && (d<0.25)) {
      fase = 0;
    } else if ((d>=0.25) && (d<0.50)) {
      fase = 1;
    } else if ((d>=0.50) && (d<0.75)) {
      fase = 2;
    } else if ((d>=0.75) && (d<1.00)) {
      fase = 3;
    }

    r1 = (dd==0) ? 9999 : r0*r0*(dd*dd+1)/(2*dd*r0);
    sombra = -sqrt(r1*r1-r0*r0);
    if ((fase==0)||(fase==2)) {
      sombra *= -1;
    }
    
    iro = color(180,180,160);
    
    pg.beginDraw();
    pg.loadPixels();
    for (int i=0; i<(n.x*n.y); i++) {
      
      float x0 = i%n.x-n.x*0.5;
      float y0 = i/n.x-n.y*0.5;
      
      float x1 = i%n.x-n.x*0.5+sombra;
      float y1 = i/n.x-n.y*0.5;
      
      boolean c1 = (x0*x0 + y0*y0 < r0*r0);
      boolean c2 = (x1*x1 + y1*y1 < r1*r1);
      
      if ((fase==1)||(fase==2)){
        c2 = !c2;
      }
      
      if (c1 & c2) {   
        pg.pixels[i] = iro; 
      }
      
    }     
    pg.updatePixels();

    pg.noFill();
    pg.strokeWeight(1.5);
    pg.stroke(iro);
    pg.circle(n.x*0.5, n.y*0.5, 2*r0); 
    
    pg.endDraw();
    
  }
  
  void debuxar() {

    imageMode(CENTER);
    image(pg,x,y);

  }
}
