Espiral[] espirales;

void setup() {

  size(540,850);
  
  float[] xs = {80,260,440};
  float[] ys = {150,350,550,750};
  
  espirales = new Espiral[12];
  for (int k=0; k<12; k++) {
    int i = k/4;
    int j = k%4;
    espirales[k] = new Espiral(k,xs[i],ys[j]);
  }
}



void draw() {
  
  background(10,10,10);
  for (int i=0; i<12; i++) {
    espirales[i].debuxar();
  }
  
}
