void setup() {
  size(600,600);
  colorMode(HSB, 365, 100, 100);
}

void draw() {
  
  background(45,15,100);
  
  int d = 80; // ancho del cuadrado total
  int e = 20; // ancho del recuadro de triángulos
  
  pushMatrix();
  translate(width/2,height/2);
  //rotate(PI*0.25);

  noFill();
  stroke(0);
  strokeWeight(1);
  rect(0,0,d,d);
  rect(1*0.5*e,1*0.5*e,d-1*e,d-1*e);
  rect(2*0.5*e,2*0.5*e,d-2*e,d-2*e);

  float t = d/4.;
  noStroke();
  for (int k=0; k<4; k++) {
    fill(0,100,100);
    triangle(0,0,t,0,e*0.5,e*0.5);
    translate(t,0);
  }

  translate(-3*t,0);
  for (int k=0; k<3; k++) {
    fill(120,100,100);
    triangle(0,0,-0.5*e,0.5*e,0.5*e,0.5*e);
    translate(t,0);
  }
  
  translate(-4*t,0);
  translate(0.5*e,0.5*e);
  for (int k=0; k<3; k++) {
    fill(0,100,100);
    triangle(0,0,t,0,e*0.5,e*0.5);
    translate(t,0);
  }
 
  translate(-2*t,0); 
  for (int k=0; k<2; k++) {
    fill(120,100,100);
    triangle(0,0,-0.5*e,0.5*e,0.5*e,0.5*e);
    translate(t,0);
  }
  
  popMatrix();
  noLoop();

}
