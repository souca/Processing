class Espiral {
  
  ArrayList<PVector> xy;
  int n_puntos;
  Luna[] lunas;
  float x0,y0;
  int dni;
  
  Espiral(int _dni, float _x0, float _y0) {
    
    dni = _dni;
    x0 = _x0;
    y0 = _y0;
    
    xy = crear_posiciones();
    
    n_puntos = xy.size();
    lunas = new Luna[n_puntos];
    for (int i=0; i<n_puntos; i++) {
      float j = i/(float(n_puntos-1));
      PVector pos = xy.get(i);
      float x = pos.x;
      float y = pos.y;
      lunas[i] = new Luna(i,j,x,y);
    }    
  }
  
  ArrayList<PVector> crear_posiciones() {
   
    ArrayList<PVector> xy;
    xy = new ArrayList<PVector>();
    
    int n = 200;  //: numero de puntos en la espiral 
    float d0 = 34*0.6;//: distancia a la que selecionamos puntos 
    PVector ini = new PVector(0, 0);
    for (int i=0; i<n; i++) {
      float a = map(i, 0, n-1, 0, 3.5*PI)-0.4*PI;
      //float r = map(a, 0, 4.2*PI, 120, 20);
      float r = map(a, 0, 4.2*PI, 120*0.6, 20*0.6);
      float x = x0 + r * cos(a);
      float y = y0 + r * sin(a);
  
      if (ini.x==0 & ini.y==0) {
        ini.x = x;
        ini.y = y;
        xy.add(new PVector(x,y));
      }
      
      float d = dist(ini.x,ini.y,x,y);
      if (abs(d-d0)<5) {
        xy.add(new PVector(x,y));
        ini.x = x;
        ini.y = y;      
      }
    }  
    return xy;
    
  }  

  void debuxar() {
    for (Luna luna:lunas) {
      luna.debuxar();
    }     
  }
  
}
