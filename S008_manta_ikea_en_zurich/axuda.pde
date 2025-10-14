void debuxar_ollo(float _x, float _y, float _s, float _a) {

  pushMatrix();
  translate(_x, _y);
  rotate(_a);

  float r = 50 * _s;
  float phi = 0.3;

  noStroke();
  fill(250, 250, 240);
  beginShape();
  int n = 100;
  for (int i=0; i<n; i++) {
    float a = map(i, 0, n-1, phi*PI, (1-phi)*PI);
    float x = r * cos(a);
    float y = r * sin(a) - r * sin(phi*PI);
    vertex(x, y);
  }
  endShape();

  beginShape();
  for (int i=0; i<n; i++) {
    float a = map(i, 0, n-1, (1+phi)*PI, (2-phi)*PI);
    float x = r * cos(a);
    float y = r * sin(a) + r * sin(phi*PI);
    vertex(x, y);
  }
  endShape();

  fill(10, 10, 50);
  ellipse(0, 0, 2*r*(1-sin(phi*PI)), 2*r*(1-sin(phi*PI)));

  popMatrix();
}


void debuxar_bola(float _x, float _y, float _s, int _t) {

  pushMatrix();
  translate(_x, _y);

  float r = 50*_s;
  noStroke();
  fill(250, 210, 100);  
  ellipse(0, 0, 2*r, 2*r);
  
  float oo = 0.45*r;

  
  if (_t == 0 ) { 
    
  } else if (_t == 1 ) {
    
    fill(250,250,240);
    arc(0,0,2*r,2*r,PI*0.5,PI*1.5);
    
  } else if (_t == 2) {
  
  } else if (_t == 3) {
    rotate(PI);  
  }
  
  if ((_t==2) || (_t==3)) {
    float x0 = 0.5*(oo);
    float y0 = sqrt(r*r - (x0)*(x0));  
    float phi = acos( ((x0-oo)*(x0-oo)-y0*y0) / ((x0-oo)*(x0-oo)+y0*y0) );
    fill(250,250,240);
    arc(oo,0,2*r,2*r, PI-0.5*phi, PI+0.5*phi, CHORD);
    arc(0,0,2*r,2*r, -0.5*phi, 0.5*phi, CHORD);
    stroke(250,250,240);
    line(x0,-y0,x0,y0); 
  }
  //rotate(_a);
  
  //float a = 0;
  //float b = 0.45*r;
  //float x0 = 0.5*(b+a);
  //float y0 = sqrt(r*r - (x0-a)*(x0-a));  
  //float phi = acos( ((x0-b)*(x0-b)-y0*y0) / ((x0-b)*(x0-b)+y0*y0) );
  
  //fill(250, 250, 240);
  //arc(b,0,2*r,2*r, PI-0.5*phi, PI+0.5*phi, CHORD);
  //arc(a,0,2*r,2*r, -0.5*phi, 0.5*phi, CHORD);
  //stroke(250,250,240);
  //line(x0,-y0,x0,y0);

  popMatrix();
}
