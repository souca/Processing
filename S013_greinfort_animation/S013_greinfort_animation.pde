float tt;

void setup() {
  size(600, 600);
  background(245, 242, 73);
}

void draw() {
  background(245, 242, 73);
  
  tt = millis();

  float r1 = 200;
  float r2 = 60;
  int n = 14;
  float delta_a = 2*PI/float(n);

  stroke(0);
  strokeWeight(2);
  noFill();

  circle(width*0.5, height*0.5, 2*r1);
  for (int i=0; i<n; i++) {
    float a=map(i, 0, n, 0, 2*PI);
    float x0=r1*cos(a);
    float y0=r1*sin(a);
    circle(width*0.5+x0, height*0.5+y0, 2*r2);
    float x1=r1*cos(a+delta_a);
    float y1=r1*sin(a+delta_a);
    
    float angulo = atan2(y1-y0, x1-x0)+2*PI;
    float dalfa = sqrt((x1-x0) * (x1-x0) + (y1-y0) * (y1-y0));
    float dbeta = sqrt(r2*r2 - dalfa*dalfa*0.25);
    
    pushMatrix();
    translate(width*0.5+x0, height*0.5+y0);
    rotate(angulo);
    
    fill(0);
    
    float periodo = 2200;
    float gamma = atan2(dbeta, dalfa*0.5);
    
    float tgamma, u, e;
    float ttp = tt+i*periodo/n;
    
    if ((ttp%periodo) < periodo*0.5) {
      u = constrain((ttp%periodo)/(periodo*0.5), 0, 1);
      //e = 0.5 - 0.5*cos(u*PI);
      e = u*u*(3-2*u);
      tgamma = lerp(-gamma, gamma, e);
      circle(r2*cos(tgamma), r2*sin(tgamma), 20);
    } else {
      u = constrain(((ttp%periodo)-(periodo*0.5))/(periodo*0.5), 0, 1);
      //e = 0.5 - 0.5*cos(u*PI);
      e = u*u*(3-2*u);
      tgamma = lerp(gamma, -gamma, e);
      circle(dalfa-r2*cos(tgamma), r2*sin(tgamma), 20);
    }
    textSize(24);
    text(i,0,0);
    noFill();
    
    popMatrix();
  }




}
