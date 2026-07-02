int nx, ny;
int offx, offy;
ArrayList<PVector> grid;
ArrayList<PVector> pos;

int agente_grid;
ArrayList<PVector> agente_camino;
boolean agente_moving;
PVector agente_target;
PVector agente_pos;

int step_size;

void setup() {
  size(600,800);

  // Variables iniciales
  nx = 6;
  ny = 6;
  offx = 90;
  offy = 70;
  
  step_size = 10;
  

  // Generamos grid (enteros en red) y pos (píxeles en canvas)
  grid = new ArrayList<PVector>();
  pos  = new ArrayList<PVector>();
  for (int j=0; j<ny; j++) {
    for (int i=0; i<nx; i++) {
      float xx = map(i,0,nx-1, offx, width-offx);
      float yy = map(j,0,ny-1, height*0.4+offy, height-offy);
      pos.add(new PVector(xx,yy));
      grid.add(new PVector(i,j));
      circle(xx,yy,12);
    }
  }
  agente_grid = 10; //current anchor position
  agente_camino = new ArrayList<PVector>(); //collection of last grid points
  agente_moving = true; //if agente has not reached his target yet
  agente_target = new PVector(); //next target position
  agente_camino.add(new PVector(pos.get(agente_grid).x,pos.get(agente_grid).y));
  agente_pos = pos.get(agente_grid).copy(); //actual position on canvas
  
  if (agente_moving) {
    Integer[] vecinos = get_vecinos(agente_grid);
    int nx = (int)random(vecinos.length);
    agente_target = pos.get(vecinos[nx]).copy();
    agente_moving = true;
    agente_grid = vecinos[nx];
  }
}

int idx_to_grid(float i, float j) {
  // de (i,j) a posicion en grid
  return int(j)*ny+int(i);
}

Integer[] get_vecinos(int n) {
  // calcula los vecinos dada la posición en grid
  ArrayList<Integer> sa = new ArrayList<Integer>();
  int ii = (int)grid.get(n).x;
  int jj = (int)grid.get(n).y;
  if (ii-1>=0) {sa.add(idx_to_grid(ii-1,jj));}
  if (ii+1<nx) {sa.add(idx_to_grid(ii+1,jj));}
  if (jj-1>=0) {sa.add(idx_to_grid(ii,jj-1));}
  if (jj+1<ny) {sa.add(idx_to_grid(ii,jj+1));}
  return sa.toArray(new Integer[sa.size()]);
}

void keyPressedNext() {
  //if (key == ' ' && !agente_moving)
  if (!agente_moving) {
    Integer[] vecinos = get_vecinos(agente_grid);
    int nx = (int)random(vecinos.length);
    agente_target = pos.get(vecinos[nx]).copy();
    agente_moving = true;
    agente_grid = vecinos[nx];
  }
}

void draw() {
  background(255,240,240);

  stroke(200);
  noFill();
  if (agente_camino.size()>1) {
    for (int k=0; k<=agente_camino.size()-2; k++) {
      PVector oo = agente_camino.get(k);
      PVector ff = agente_camino.get(k+1);
      line(oo.x,oo.y,ff.x,ff.y);
    }
  }
  for (int step=0; step<step_size; step++) {
    if (agente_moving) {
      float deltax = (agente_target.x-agente_pos.x)*0.5;
      float deltay = (agente_target.y-agente_pos.y)*0.5;
      
      PVector delta = new PVector(deltax,deltay).normalize();
      float omega_1 = random(-PI*0.5,PI*0.5);
      float omega_x = delta.x*cos(omega_1) - delta.y*sin(omega_1);
      float omega_y = delta.y*cos(omega_1) + delta.x*sin(omega_1);
      PVector n_delta = new PVector(omega_x, omega_y).mult(3);
      
      agente_pos.x += n_delta.x;
      agente_pos.y += n_delta.y;
      agente_camino.add(agente_pos.copy());
      if (dist(agente_pos.x,agente_pos.y,agente_target.x,agente_target.y)<10) {
        agente_moving = false;
        agente_pos = pos.get(agente_grid).copy();
        keyPressedNext();
      }
    }
    
  }

  //noFill();
  //stroke(20);
  //textAlign(CENTER,CENTER);
  //textSize(15);
  //for (int k=0; k<pos.size(); k++) {
  //  fill(255,240,240);
  //  circle(pos.get(k).x,pos.get(k).y,20);
  //  fill(20);
  //  text(idx_to_grid(grid.get(k).x,grid.get(k).y),pos.get(k).x, pos.get(k).y);
  //}
  
  


  stroke(0);
  fill(255,170,140);
  float ax = agente_pos.x;//pos.get(agente_grid).x;
  float ay = agente_pos.y;//pos.get(agente_grid).y;
  circle(ax,ay,12);


}
