class Sol {
  
  int d;
  int dni;
  float x,y;
  PGraphics pg, mask;
  
  Sol(int _k, int _d, float _x, float _y) {
    x = int(_x);
    y = int(_y);
    d = _d;
    dni = _k;
    
    pg = createGraphics(2*d+1, 2*d+1);
    pg.beginDraw();
    pg.noStroke();
    pg.fill(iro1);
    pg.circle(d,d,2*d);
    pg.noFill();
    pg.rect(0,0,2*d,2*d);
    pg.noFill();
    pg.stroke(iro2);
    pg.strokeWeight(0.25);
    
    int _xyz = int(random(8))+4;
    PVector pos = random_point_in_square();
    
    for (int k=0; k<_xyz; k++) {
      float r = map(k,0,_xyz-1,3*d,d);
      pg.circle(pos.x,pos.y,r);
    }
    pg.endDraw();
    
    
    mask = createGraphics(2*d+1, 2*d+1);
    mask.beginDraw();
    mask.background(0);
    mask.fill(255);
    mask.circle(d,d,2*d);
    mask.endDraw();
    
    
    pg.mask(mask);
   
  }
  
  PVector random_point_in_square() {
    float _u = random(4); 
    int d1 = int(_u);
    float d3 = _u-int(_u);
    float x=0;
    float y=0;    
    if (d1==0) { 
      x = map(d3,0,1,0,2*d);
      y = 0;
    } else if (d1==1) {
      x = map(d3,0,1,0,2*d);
      y = n;
    } else if (d1==2) {
      y = map(d3,0,1,0,2*d);
      x = 0;
    } else if (d1==3) {
      y = map(d3,0,1,0,2*d);
      x = n;
    }
    return new PVector(x,y);
  }
  
  void debuxar() {
    imageMode(CENTER);
    image(pg,x,y);
    
    noFill();
    stroke(iro2);
  }
}
