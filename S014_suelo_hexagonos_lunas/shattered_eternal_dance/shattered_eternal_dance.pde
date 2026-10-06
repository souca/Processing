float a;
PVector xx, yy;

boolean help;

void setup() {
  size(600, 600);

  a = 70;
  xx = new PVector(1.0, 0);
  yy = new PVector(0.5, 0.866);

  help = false;
}

void keyPressed() {
  if (key == ' ') {
    help = !help;
  }
}

PVector lerp_hexa(ArrayList<PVector> ps, int k1, int k2, float t) {
  PVector oo = new PVector();
  oo.x = lerp(ps.get(k1).x, ps.get(k2).x, t);
  oo.y = lerp(ps.get(k1).y, ps.get(k2).y, t);
  return oo;
}

void draw_rombo(ArrayList<PVector> hexa, int[] vs) {

  color iro = color(#222b30);
  color iro_luna = color(#d7bf96);
  float t = 0.075;

  fill(iro);
  noStroke();
  PVector ps1 = lerp_hexa(hexa, vs[0], vs[1], t);
  PVector ps2 = lerp_hexa(hexa, vs[0], vs[1], 1-t);
  PVector ps3 = lerp_hexa(hexa, vs[2], vs[3], t);
  PVector ps4 = lerp_hexa(hexa, vs[2], vs[3], 1-t);

  beginShape();
  vertex(ps3.x, ps3.y);
  vertex(ps2.x, ps2.y);
  vertex(ps4.x, ps4.y);
  vertex(ps1.x, ps1.y);
  endShape(CLOSE);

  noStroke();
  PVector oo1 = lerp_hexa(hexa, 3, 5, 0.5);
  fill(iro_luna);
  circle(oo1.x, oo1.y, a*0.257);
  PVector qq1 = lerp_hexa(hexa, 3, 5, (random(0.7)<0.5)?0.43:1-0.43);
  fill(iro);
  circle(qq1.x, qq1.y, a*0.164);
  PVector oo2 = lerp_hexa(hexa, 1, 3, 0.5);
  fill(iro_luna);
  circle(oo2.x, oo2.y, a*0.257);
  PVector qq2 = lerp_hexa(hexa, 1, 3, (random(0.7)<0.5)?0.43:1-0.43);
  fill(iro);
  circle(qq2.x, qq2.y, a*0.164);
  PVector oo3 = lerp_hexa(hexa, 5, 1, 0.5);
  fill(iro_luna);
  circle(oo3.x, oo3.y, a*0.257);
  PVector qq3 = lerp_hexa(hexa, 5, 1, (random(0.7)<0.5)?0.43:1-0.43);
  fill(iro);
  circle(qq3.x, qq3.y, a*0.164);
}

void draw_hexa(ArrayList<PVector> hexa) {

  int[] vs1 = {4, 6, 3, 5};
  draw_rombo(hexa, vs1);

  int[] vs2 = {2, 6, 1, 3};
  draw_rombo(hexa, vs2);

  int[] vs3 = {1, 5, 6, 0};
  draw_rombo(hexa, vs3);
}

void draw() {
  pushMatrix();
  rotate(0.3);
  background(#d3c7b5);

  int n = 5;
  float sq = sqrt(3)/3.;
  ArrayList<PVector> hexxa = new ArrayList<PVector>();

  noFill();

  noFill();
  stroke(0, 0, 0);
  pushMatrix();
  translate(width*0.5,height*0.5);
  for (int i=-3; i<=3*n; i++) {
    for (int j=-3; j<=3*n; j++) {
      float x = a * (xx.x * i + yy.x * j);
      float y = a * (xx.y * i + yy.y * j);

      noFill();
      stroke(#a58f76);
      strokeWeight(0.5);
      //pushMatrix();
      translate(x,y);
      beginShape();
      for (int k=0; k<6; k++) {
        float ang = map(k, 0, 6, 0, TWO_PI);
        float hx = sq * a * cos(ang+PI/6.) + x;
        float hy = sq * a * sin(ang+PI/6.) + y;
        vertex(hx,hy); //fuera
      }
      translate(-x,-y);
      endShape();

      //translate(x,y);
      translate(x,y);
      beginShape();
      for (int k=0; k<6; k++) {
        float ang = map(k, 0, 6, 0, TWO_PI);
        float hx = 0.9 * sq * a * cos(ang+PI/6.) + x;
        float hy = 0.9 * sq * a * sin(ang+PI/6.) + y;
        //vertex(hx, hy); // dentro
        hexxa.add(new PVector(hx,hy));
      }
      hexxa.add(new PVector(x,y));
      endShape(CLOSE);
      draw_hexa(hexxa);
      translate(-x,-y);
    }
  }
  popMatrix();
  noLoop();






}
