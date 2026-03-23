float t;

void setup() {
  size(600, 600);
  noiseSeed(1234);
  t = 0;
}

void draw() {
  background(200,0,0);

  int nx = 48;
  int ny = 36;
  float spacing = 30.0;
  float angle = 60*PI/180.;

  PVector u = new PVector(1, 0);
  PVector v = new PVector(cos(angle), sin(angle));
  PVector oo = new PVector(width*0.5, height*0.5);

  float k = 1.0;
  float s = sin(t*0.001);
  float z = map((s>0?1:-1) * pow(abs(s), k), -1,1,0,1);

  t = millis();

  for (int i=-nx; i<nx; i++) {
    for (int j=-ny; j<ny; j++) {
      PVector x = PVector.mult(u, i*spacing);
      PVector y = PVector.mult(v, j*spacing);
      PVector xy = PVector.add(oo, PVector.add(x, y));
      color iro = color(map(noise(i*0.9+z,j*0.9-z),0,1,20,180));
      fill(iro);
      strokeWeight(2);
      stroke(iro);
      beginShape();
      vertex(xy.x, xy.y-spacing*sin(angle));
      vertex(xy.x-spacing*cos(angle), xy.y);
      vertex(xy.x, xy.y+spacing*sin(angle));
      vertex(xy.x+spacing*cos(angle), xy.y);
      endShape(CLOSE);
    }
  }
  
  saveFrame("frames/frame-####.png");
  
  if (frameCount >= 60) {
    exit();
  }
  
}
