

void setup() {
  size(500,500);
}

void draw() {
  background(220,120,0);

  int x0 = 150;
  int y0 = 150;
  int n = 200;

  stroke(250,180,180);
  strokeWeight(7);
  fill(200,90,90);
  rect(x0,y0,n,n);
  
  float u = random(4);
  
  for (int j=0; j<10; j++) {
    println(random(4));
  }
  
  stroke(0);
  fill(0);
  textSize(40);
  int d1 = int(u);
  float d3 = u-int(u);
  text(str(u), 20,40);
  
  float x=0;
  float y=0;
  
  if (d1==0) { 
    x = map(d3,0,1,0,n);
    y = 0;
  } else if (d1==1) {
    x = map(d3,0,1,0,n);
    y = n;
  } else if (d1==2) {
    y = map(d3,0,1,0,n);
    x = 0;
 } else if (d1==3) {
    y = map(d3,0,1,0,n);
    x = n;
  }
  
  noStroke();
  fill(255);
  circle(x0+x,y0+y,20);
  
  noLoop();

}
