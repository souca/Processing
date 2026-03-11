class Ollo {

  float scale = 100;
  float ratio = PHI;
  float r_iris;
  float r_pupi;
  float ancho, alto;

  float xi;
  float p, q;
  float theta, atheta;
  PVector down, up;

  PVector pos;
  PVector aim;
  PVector centro;
  float ori;

  PImage cut;
  PGraphics mask;


  Ollo(PVector _p, PVector _c, float _a) {

    pos = _p; // centro del rect
    centro = _c; // centro de la pupila w.r.t pos
    ori = _a;

    //validate_params

    alto = scale;
    ancho = scale*ratio;
    r_iris = scale*0.9;
    r_pupi = scale*0.2;

    xi = 0.25*(3-ratio*ratio);
    p = alto * (0.5-xi);
    q = 2*alto*(1-xi);
    theta = atan2(0.5-xi, ratio*0.5);
    atheta = atan2(ratio*0.5, 0.5-xi);

    down = new PVector(0, p);
    up = new PVector(0, -p);

    cut = fondo.get();
    mask = createGraphics(fondo.width, fondo.height);
  }

  void debuxar() {

    noFill();
    pushMatrix();

    translate(pos.x, pos.y);
    rotate(PI*0);

    rectMode(CENTER);
    noStroke();
    stroke(0);
    fill(255);
    rect(0, 0, ancho, alto);
    fill(255,220,240);
    rect(0, 0, ancho + 2*r_iris, alto + 2*r_iris);
    fill(250, 110, 120);
    circle(centro.x, centro.y, r_iris);
    fill(0);
    circle(centro.x, centro.y, r_pupi);
    
    aim = new PVector(0,0);
    // movement
    aim.x = constrain((mouseX-pos.x)-centro.x, -0.5*ancho, 0.5*ancho);
    aim.y = constrain((mouseY-pos.y)-centro.y, -0.5*alto, 0.5*alto);
    centro.lerp(aim,0.1);

    fill(0,255,0);
    circle(mouseX-pos.x,mouseY-pos.y,8);
    fill(0,0,255);
    circle(aim.x,aim.y,8);
    

    //···································
    fill(105);
    noStroke();
    beginShape();
    for (int k=0; k<18; k++) {

      float _a = map(k, 0, 17, theta, theta+2*atheta);
      float x0 = -0.5*q*cos(_a);
      float y0 = -0.5*q*sin(_a) + p;
      vertex(x0, y0);
    }
    for (int k=0; k<18; k++) {
      float _a = map(k, 0, 17, theta+2*atheta, theta);
      float x0 = -0.5*q*cos(-_a);
      float y0 = -0.5*q*sin(-_a) - p;
      vertex(x0, y0);
    }
    vertex(-0.5*ancho, 0.5*alto);
    vertex( 0.5*ancho, 0.5*alto);
    vertex( 0.5*ancho, -0.5*alto);
    vertex(-0.5*ancho, -0.5*alto);
    endShape(CLOSE);
    noFill();
    //···································

    stroke(0);
    strokeWeight(1);
    arc(0, p, q, q, -PI*0.5-atheta, -PI*0.5+atheta);
    arc(0, -p, q, q, theta, theta+2*atheta);
    noStroke();
    popMatrix();

    cut.mask(createMask());
    //image(cut, 0, 0);
  }
  
  PGraphics createMask() {
    mask.beginDraw();
    mask.pushMatrix();
    mask.translate(pos.x, pos.y);
    mask.rotate(PI*0);
    mask.background(0);
    mask.fill(255);
    mask.noStroke();
    mask.beginShape();
    for (int k=0; k<18; k++) {
      float _a = map(k, 0, 17, theta, theta+2*atheta);
      float x0 = -0.5*q*cos(_a);
      float y0 = -0.5*q*sin(_a) + p;
      mask.vertex(x0, y0);
    }
    for (int k=0; k<18; k++) {
      float _a = map(k, 0, 17, theta+2*atheta, theta);
      float x0 = -0.5*q*cos(-_a);
      float y0 = -0.5*q*sin(-_a) - p;
      mask.vertex(x0, y0);
    }
    mask.vertex(-0.5*ancho, 0.5*alto);
    mask.vertex( 0.5*ancho, 0.5*alto);
    mask.vertex( 0.5*ancho, -0.5*alto);
    mask.vertex(-0.5*ancho, -0.5*alto);
    mask.endShape(CLOSE);
    mask.popMatrix();
    mask.endDraw();
    
    return mask;
  }
}
