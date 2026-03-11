Ollo ollo;
ArrayList<Ollo> ollos;
PGraphics fondo;
float PHI = 0.5*(sqrt(5)+1);

void setup() {
  size(700, 700);
  smooth();
  frameRate(60);

  fondo = createFondo();

  ollos = new ArrayList<Ollo>();
  float x = width*0.5;
  float y = height*0.5;
  ollos.add(new Ollo(new PVector(x, y), new PVector(-30, -5), 0));
}

void draw() {

  background(255);
  //image(fondo, 0, 0);

  for (Ollo ollo : ollos) {
    ollo.debuxar();  
  }

 // noLoop();
}

PGraphics createFondo() {
  fondo = createGraphics(700, 700);
  fondo.beginDraw();
  fondo.background(255);
  fondo.stroke(200);
  fondo.strokeWeight(0.5);
  for (int i=0; i<15; i++) {
    for (int j=0; j<15; j++) {
      float x = map(i,0,14,10,width-10);
      float y = map(j,0,14,10,height-10);
      fondo.line(x,0,x,height);
      fondo.line(0,y,width,y);
    }
  }
  fondo.endDraw();

  return fondo;
}
