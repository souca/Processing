PShader eye;

float rectW, rectH;

void setup() {
  size(800, 800, P2D);

  eye = loadShader("eye.glsl");

  rectW = width * 0.8;
  rectH = height * 0.8;
}

void draw() {

  background(240);

  //drawGrid();

  // centro del canvas
  PVector center = new PVector(width/2, height/2);

  // esquinas del rectángulo
  float x0 = width/2 - rectW/2;
  float x1 = width/2 + rectW/2;
  float y0 = height/2 - rectH/2;
  float y1 = height/2 + rectH/2;

  PVector[] corners = {
    new PVector(x0,y0),
    new PVector(x1,y0),
    new PVector(x1,y1),
    new PVector(x0,y1)
  };

  for (PVector pos : corners) {
    drawEye(pos, center);
  }
}
void drawEye(PVector pos, PVector lookTarget) {

  // dirección hacia el centro
  PVector dir = PVector.sub(lookTarget, pos);
  float angle = atan2(dir.y, dir.x);

  float eyeSize = 220;

  eye.set("resolution", (float)width, (float)height);

  // offset del shader
  eye.set("offset", pos.x, pos.y);

  // rotación
  eye.set("rotation", angle);

  // parámetros geométricos locales
  eye.set("eyeA", -80.0f, 0.0f);
  eye.set("eyeB",  80.0f, 0.0f);

  // iris mira ligeramente al centro
  eye.set("iris", dir.x*0.15f, dir.y*0.15f);

  eye.set("rEye", 120.0f);
  eye.set("rIris", 50.0f);

  shader(eye);

  pushMatrix();
  translate(pos.x, pos.y);
  rectMode(CENTER);
  rect(0, 0, eyeSize, eyeSize);
  popMatrix();

  resetShader();
}
