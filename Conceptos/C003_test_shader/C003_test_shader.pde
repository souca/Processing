PShader eye;

void setup(){
  size(700,700,P2D);
  eye = loadShader("eye.glsl");

  eye.set("resolution",(float)width,(float)height);  
}

void draw(){

  background(30);

  eye.set("eyeA", width/2, height/2.0-100);
  eye.set("eyeB", width/2, height/2.0+100);
  eye.set("iris", (float)mouseX, (float)mouseY);

  eye.set("rEye",180.0);
  eye.set("rIris",80.0);

  shader(eye);
  rect(0,0,width,height);
}
