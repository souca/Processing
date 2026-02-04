

void setup() {
  size(500,500); 
}

void draw() {
  
  background(200,100,100);
  noStroke();
  fill(120,20,40);
  circle(width/2,height/2,480);
  fill(200,100,100);
  circle(width/2, height/2, 20);
  
  pushMatrix();
  translate(width/2, height/2);
  
  int n = 10;
  for (int k=0; k<n; k++) {
    float r = map(k,0,n-1,0,200);
    float a = map(k,0,n-1,0,2*PI);
    float b = r/10;

    strokeWeight(1.6);
    stroke(200,100,100);
    noFill();
    beginShape();
    for (int i=0; i<6; i++) {
        vertex(r*cos(a-i*PI/3.), r*sin(a-i*PI/3.));
    }
    endShape(CLOSE);


    strokeWeight(4);
    stroke(200,200,220);
    fill(150,150,180);
    for (int i=0; i<6; i++) {
        circle(r*cos(a-i*PI/3.), r*sin(a-i*PI/3.), b);
    }
    
  }
  popMatrix();
  
  
  save("ola.png");
  noLoop();
  
  
}
