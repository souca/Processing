float rr; // radio de los circulos
float x0; // x del 1er circulo
float x1; // x del 2o circulo
float y0; // y del 1er circulo
float y1; // y del 2o circulo
float tt; // variable temporal (tiempo desde arranque, [ms])

boolean visual_aid; // vista limpia o con ayuda para debuguear

void setup() {
  size(600, 600);
  background(20, 60, 20); // verde campo

  rr = 120;
  new_coords();
  visual_aid = false;
}

void new_coords() {
  // genera dos circulos del mismo radio que se intersectan.
  // deberían estar totalmente contenidos en la pantalla.
  // C0 en la mitad izquierda, C1 en la derecha.
  boolean fin = true;
  while (fin) {
    x0 = random(-width*0.5+rr, 0);
    x1 = random(0, width*0.5-rr);
    y0 = random(-height*0.5+rr, height*0.5-rr);
    y1 = random(-height*0.5+rr, height*0.5-rr);
    fin = (dist(x0, y0, x1, y1)>1.5*rr);
  }
}

// Con espacio generamos nuevos circulos
void keyPressed() {
  if (key == ' ') {
    new_coords();
  }
  if (key == 'q') {
    visual_aid = !visual_aid;
  }
}

void draw() {
  background(20, 60, 20);

  textSize(20);
  fill(100);
  if (visual_aid) {
    text("debug", 6, 20);
  } else {
    text("Q", 6,20);
  }

  tt = millis();

  stroke(210);
  strokeWeight(0.2);
  noFill();

  // ----------------------------------------------------------------------
  // Sistema de coordenadas 1: en el centro de la pantalla
  pushMatrix();
  translate(width*0.5, height*0.5);

  // cálculo del ángulo que forman los dos centros
  float angulo = atan2(y1-y0, x1-x0)+2*PI;

  // calculo de la distancia entre centros (dalfa)
  // y de la perpendicular, desde el punto intercentro a las intersecciones (dbeta)
  float dalfa = sqrt((x1-x0) * (x1-x0) + (y1-y0) * (y1-y0));
  float dbeta = sqrt(rr*rr - dalfa*dalfa*0.25);

  circle(x0, y0, 2*rr);
  circle(x1, y1, 2*rr);

  if (visual_aid) {
    line(x0,y0,x1,y1);
    line(x0,-height*0.5,x0,height*0.5);
    line(x1,-height*0.5,x1,height*0.5);
    // cálculo del punto intercentro
    float ax = 0.5*(x1+x0);
    float ay = 0.5*(y1+y0);
    circle(ax, ay, 3);
    // segmento del intercentro a una de las intersecciones
    float xdd = dbeta * cos(angulo+PI*0.5);
    float ydd = dbeta * sin(angulo+PI*0.5);
    line(ax-xdd,ay-ydd,ax+xdd,ay+ydd);
    circle(x0,y0,10);
    circle(x1,y1,10);
  }

  popMatrix();


  // ----------------------------------------------------------------------
  // Sistema de coordenadas 2: centrado en C0, con el C1 en +ê1
  pushMatrix();
  // movemos las coordenadas
  // 1. traslacion al circulo 0
  translate(width*0.5+x0, height*0.5+y0);
  // 2. rotar por el ángulo de la linea entre circulos
  rotate(angulo);

  fill(255);

  float periodo = 2600; //periodo en ms
  float gamma = atan2(dbeta, dalfa*0.5); // angulo que un punto de interseccion hace
  // con el eje ê1

  // animacion
  float tgamma, u, e;
  if ((tt%periodo) < periodo*0.5) {
    u = constrain((tt%periodo)/(periodo*0.5), 0, 1);
    e = 0.5 - 0.5*cos(u*PI);
    tgamma = lerp(-gamma, gamma, e);
    circle(rr*cos(tgamma), rr*sin(tgamma), 14);
  } else {
    u = constrain(((tt%periodo)-(periodo*0.5))/(periodo*0.5), 0, 1);
    e = 0.5 - 0.5*cos(u*PI);
    tgamma = lerp(gamma, -gamma, e);
    circle(dalfa-rr*cos(tgamma), rr*sin(tgamma), 14);
  }


  popMatrix();
}
