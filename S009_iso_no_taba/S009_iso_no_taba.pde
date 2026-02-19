void setup() {
  size(400, 210);
  smooth();

  background(180, 170, 170);

  float[] ms = {-140.0, 70.0};

  for (float m : ms) {
    for (int k2=1; k2<13; k2+=2) {
      float h = m + k2*12;
      coseno(h, 2, k2%2);
    }
  }
  for (float m : ms) {
    for (int k2=0; k2<13; k2+=2) {
      float h = m + k2*12;
      coseno(h, 2, k2%2);
    }
  }

  for (float m : ms) {
    for (int k2=1; k2<13; k2+=2) {
      float h = m + k2*12;
      coseno(h, 1, k2%2);
    }
  }
  for (float m : ms) {
    for (int k2=0; k2<13; k2+=2) {
      float h = m + k2*12;
      coseno(h, 1, k2%2);
    }
  }
  
  save("S009_iso_no_taba_000.png");  
  noLoop();
  exit();
  
}

void coseno(float h, float f, int o) {
  int n = 100;
  if (o==0) {
    noFill();
    stroke(230, 210, 180);
    strokeWeight(3);
  } else {
    noFill();
    stroke(180, 170, 170);
    strokeWeight(22);
  }

  beginShape();
  for (int i=0; i<n; i++) {
    //float x = map(i, 0, n-1, -50, width+50);
    float x = map(i, 0, n-1, -5, width+5);
    float y = h + 40 * cos(0.0157*x + PI*f);
    curveVertex(x, y);
  }
  endShape();
}
