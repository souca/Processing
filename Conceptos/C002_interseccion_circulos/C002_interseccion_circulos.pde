// Proyecto auxiliar para el tema de dibujar ojos. 
// El problema principal a atacar era cómo ocultamos la parte del iris que queda detrás de los párpados.
// Sean dos círculos de igual radio que se cortan en dos puntos.
// El segmento de arco de uno de los círculos que queda dentro del otro círculo es una mitad del contorno
//   del ojo.
// Los dos arcos forman la forma lenticular del ojo visible. 
// Los puntos de corte de estos dos círculos los derivé teniendo en cuenta que la forma de la que partimos
//   son las dimensiones del ojo, (x*ratio, x), donde 1>ratio>2.
// Dado este rectángulo, los puntos (-x*ratio/2,0) y (+x*ratio/2,0) con respecto al centro del rectángulo
//   son los puntos de corte, pero para poder dibujar solo los arcos tengo que conocer el radio de los círculos
//   y luego derivar los ángulos tendidos. 
// En este caso, no costó mucho calcularlo, así que ya teníamos la forma del ojo. Para que el iris quedase 
//   por detrás del párpado, lo que hicimos fue beginDraw()...endDraw recorriendo los dos arcos y completando
//   el recorrido por el rectángulo, pintándolo del mismo color que el fondo.
// (De hecho, lo que hicimos fue pintar el fondo en un PGImage, y esta forma del rectángulo del ojo menos el 
//   propio ojo la maskeamos del fondo para pintarla. De esta forma podemos poner fondos con cosas, no solo
//   colores sólidos).
// El problema limitante es que si el iris es grande y/o está muy escorado en el ojo, saldrá fuera de los 
//   límites del rectángulo. La solución de hacer más grande los rectángulos no es satisfactoria si vamos a
//   querer tener la libertad de hacer diseños con muchos ojos unos cerca de los otros. 
// La solución real es quedarse con la intersección de los dos círculos. 
// Queda la pregunta de cómo arreglamos cuando haya tres círculos, que es lo que pasará en los ojos cuando
//   el iris esté centrado en vertical pero muy escorado en horizontal. 

void setup() {

  size(600, 600);
  noCursor();
}

void draw() {

  background(240, 220, 230);

  PVector u0 = new PVector(width*0.45, height*0.45);
  float r0 = 100;

  PVector u1 = new PVector(mouseX, mouseY);
  float r1 = 40;

  noFill();

  // vector centro-centro
  strokeWeight(1);
  stroke(200);
  PVector dd = new PVector(u1.x-u0.x, u1.y-u0.y);
  line(u0.x, u0.y, u0.x+dd.x, u0.y+dd.y);

  // circulos
  stroke(0);
  strokeWeight(1);
  circle(u0.x, u0.y, r0*2);
  circle(u0.x, u0.y, 1);
  circle(u1.x, u1.y, r1*2);
  circle(u1.x, u1.y, 1);

  // lineas apoyo 0.9
  //stroke(100);
  //strokeWeight(1);
  //line(0.9*width, 0, 0.9*width, height);
  //line(0, 0.9*height, width, 0.9*height);

  // cuadro dependiente de si corta o no
  color iro;
  noFill();
  boolean jarl = false;
  if (dd.mag() < abs(r0-r1)) {
    iro = color(200, 0, 0);
    fill(iro);
  } else if (dd.mag() > r0+r1) {
    iro = color(0, 200, 0);
    fill(iro);
  } else {
    iro = color(0, 0, 200);
    fill(iro);
    jarl = true;
  }
  rect(0.92*width, 0.92*height, 0.06*width, 0.06*height);

  //
  if (jarl) {
    //PVector qq = new PVector(-dd.y, dd.x);
    //noFill();
    //stroke(0);
    //strokeWeight(2);
    //line(u0.x,u0.y,qq.x+u0.x,qq.y+u0.y);

    pushMatrix();
    translate(u0.x, u0.y);
    fill(0);
    noStroke();
    circle(0, 0, 12);
    circle(dd.x,dd.y,12);
    //float theta = atan2(u1.y-u0.y, u1.x-u0.x);
    rotate(atan2(u1.y-u0.y, u1.x-u0.x));
    float left = max(dd.mag()-r1,-r0);
    float right = r0;
    fill(0);
    fill(200, 0, 100);
    circle(left,0,12);
    circle(right,0,12);
    
   
    fill(0,212,180);
    float ww = (r0*r0-r1*r1+dd.mag()*dd.mag())/(2*dd.mag());
    circle(ww,0,24);
    
    fill(255,123,225);
    
    PVector c1 = new PVector(ww, sqrt(r0*r0-ww*ww));
    PVector c2 = new PVector(ww, -sqrt(r0*r0-ww*ww));
    circle(c1.x,c1.y,12);
    circle(c2.x,c2.y,12);
    
    float theta = atan2(sqrt(r0*r0-ww*ww), ww);
    float atheta = atan2(sqrt(r1*r1-(ww-dd.mag())*(ww-dd.mag())), (ww-dd.mag()));
    
    noFill();
    stroke(0);
    strokeWeight(1);
    line(0,0,2*r0*cos(theta),2*r0*sin(theta));
    line(0,0,2*r0*cos(theta),-2*r0*sin(theta));

    noFill();
    stroke(250,120,140);
    strokeWeight(3);
    arc(0,0,2*r0,2*r0,-theta,theta);
    arc(dd.mag(),0,2*r1,2*r1,atheta, 2*PI-atheta);
    
    popMatrix();
    
  }
}
