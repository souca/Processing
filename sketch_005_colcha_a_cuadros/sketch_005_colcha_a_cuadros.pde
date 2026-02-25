void setup() {
  size(700, 700);
  colorMode(HSB, 365, 100, 100);
}

color random_iro() {
  color iro;
  if (random(1) > 0.25) {
    iro = color(25,random(50,90),random(50,100));
  } else if (random(1) > 0.50) {
    iro = color(25,20,random(70,100));
  } else if (random(1) > 0.70) {
    iro = color(random(130,160),random(50,100),random(50,65));
  } else if (random(1) > 0.90) {
    iro = color(0,100,100);
  } else {
    iro = color(260,75,80);
  }  
  return iro;
}

void mitri(int x, int y, int t) {
  if (t==0) {
    fill(random_iro());
    triangle(x, y, x+20, y, x+10, y+10);
  } else if (t==1) {
    fill(random_iro());
    triangle(x, y, x+20, y, x+10, y-10);
  } else if (t==2) {
    fill(random_iro());
    triangle(x, y, x, y+20, x+10, y+10);
  } else if (t==3) {
    fill(random_iro());
    triangle(x, y, x, y+20, x-10, y+10);
  }
}

void htri() {
  mitri( 0, 0, 0);
  mitri(20, 0, 0);
  mitri(40, 0, 0);
  mitri(60, 0, 0);
  mitri(10, 10, 1);
  mitri(30, 10, 1);
  mitri(50, 10, 1);
  mitri(10, 10, 0);
  mitri(30, 10, 0);
  mitri(50, 10, 0);
  mitri(40, 20, 1);
  mitri(20, 20, 1);
  mitri(20, 60, 0);
  mitri(40, 60, 0);
  mitri(10, 70, 1);
  mitri(30, 70, 1);
  mitri(50, 70, 1);
  mitri(10, 70, 0);
  mitri(30, 70, 0);
  mitri(50, 70, 0);
  mitri( 0, 80, 1);
  mitri(20, 80, 1);
  mitri(40, 80, 1);
  mitri(60, 80, 1);
}

void vtri() {
  mitri( 0, 0, 2);
  mitri( 0, 20, 2);
  mitri( 0, 40, 2);
  mitri( 0, 60, 2);
  mitri(10, 10, 2);
  mitri(10, 30, 2);
  mitri(10, 50, 2);

  mitri(60, 20, 2);
  mitri(60, 40, 2);
  mitri(70, 10, 2);
  mitri(70, 30, 2);
  mitri(70, 50, 2);

  mitri(10, 10, 3);
  mitri(10, 30, 3);
  mitri(10, 50, 3);
  mitri(20, 20, 3);
  mitri(20, 40, 3);

  mitri(70, 10, 3);
  mitri(70, 30, 3);
  mitri(70, 50, 3);

  mitri(80, 0, 3);
  mitri(80, 20, 3);
  mitri(80, 40, 3);
  mitri(80, 60, 3);
}

void tile(int x, int y) {
  pushMatrix();
  translate(x, y);
  noStroke();
  fill(40,20,95);
  rect(0,0,80,80);
  htri();
  vtri();
  popMatrix();
}

void draw() {

  background(330,100,65);
  noFill();
  noStroke();
  for (int i=0; i<width/80; i++) {
    for (int j=0; j<height/80; j++) {
      int _x = i*80+30;
      int _y = j*80+30;
      println(_x,_y);
      tile(_x, _y);
    }
  }
  noLoop();
}
