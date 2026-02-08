void setup() {
  size(600,600);
  colorMode(HSB, 365, 100, 100);
}

void draw() {
  
  background(150,30,100);
  
  pushMatrix();
  translate(width/2,height/2);
  rotate(PI*0.25);

  for (int i=-7; i<8; i++) {
    for (int j=-7; j<8; j++) {
      float u = i*60;
      float v = j*60;

      //float _h = 150 + random(0,20);
      float _h = 150 + map(i+j,-14,16,0,50);
      float _s = 30;
      float _b = 100;
      fill(color(_h,_s,_b));

      rect(u,v,60,60);
    }
  }
  
  for (int i=-7; i<8; i++) {
    for (int j=-7; j<8; j++) {
      float x = i*60;
      float y = j*60;

      //float _h = 150 + random(-20,0);
      float _h = 150 + map(i+j,-14,16,-100,0);
      float _s = 30;
      float _b = 100;
      fill(color(_h,_s,_b));

      ellipse(x,y,60,20);
      ellipse(x,y,20,60);
    }
  }

  stroke(0,0,100);
  strokeWeight(3);
  noFill();
  for (int i=-7; i<8; i++) {
    for (int j=-7; j<8; j++) {

      float x = i*60;
      float y = j*60;
      ellipse(x,y,60,20);
      ellipse(x,y,20,60);
    }
  }

  
  popMatrix();
  save("ola.png");
  noLoop();

}
