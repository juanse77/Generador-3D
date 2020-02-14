import gifAnimation.*;

PShape obj;
boolean btn_control = false;
final ArrayList <Punto> silueta = new ArrayList<Punto>();
boolean started = false;
//GifMaker ficherogif;

void setup(){
  size(600, 600, P3D);
  stroke(0);
  strokeWeight(3);
  
  /*
  ficherogif = new GifMaker(this, "rotation.gif");
  ficherogif.setRepeat(0);
  */
}

ArrayList <Punto> rotaPunto(Punto p){
  ArrayList <Punto> puntoRotado = new ArrayList<Punto>();
  
  for(float i = 0; i < TWO_PI; i += PI/12){
    float auxX = (p.getX()-width/2) * cos(i) - p.getZ() * sin(i);
    float auxZ = (p.getX()-width/2) * sin(i) + p.getZ() * cos(i);
    
    Punto auxP = new Punto(auxX+width/2, p.getY(), auxZ);
    
    puntoRotado.add(auxP);
  }
  
  return puntoRotado;
}

void dibujaFigura(){
  ArrayList<ArrayList <Punto>> matriz_puntos = new ArrayList<ArrayList <Punto>>();
  
  for(int i = 0; i < silueta.size(); i++){
    matriz_puntos.add(rotaPunto(silueta.get(i)));
  }
  
  obj = createShape();
  obj.beginShape(TRIANGLE_STRIP);
  obj.fill(192);
  obj.stroke(0);
  obj.strokeWeight(3);
  
  for(int i = 0; i < matriz_puntos.size()-1; i ++){
    for(int j = 0; j < matriz_puntos.get(i).size(); j++){
      Punto p1 = matriz_puntos.get(i).get(j);
      Punto p2 = matriz_puntos.get(i+1).get(j);
      obj.vertex(p1.getX(), p1.getY(), p1.getZ());
      obj.vertex(p2.getX(), p2.getY(), p2.getZ());
    }
  }
  
  obj.endShape();
  shape(obj);
  
  noLoop();
}

void imprimeMenu(){

  background(96);
  
  textFont(createFont("Arial", 30));
  textAlign(CENTER, CENTER);
  
  text("Generador de figuras 3D", width/2, height/4);
 
  textFont(createFont("Arial", 20));
  String s = "Para generar la figura cliquee la silueta en la parte derecha de la pantalla con la tecla ctrl pulsada. Al levantar la tecla control se generará automáticamente.\nPara iniciar o reiniciar pulse \'i\'.\nPara mostrar el menú pulse \'m\'.";
  text(s, 100, 200, 400, 200);
  
  textFont(createFont("Arial", 14));
  text("Práctica 2 CIU: Juan Sebastián Ramírez Artiles", width/2, 3*height/4);

  noLoop();
}

void dibujaSilueta(){
  for(int i = 0; i < silueta.size()-1; i++){
    Punto p1 = silueta.get(i);
    Punto p2 = silueta.get(i+1);
    
    line(p1.getX(), p1.getY(), p2.getX(), p2.getY());
  } 
}

void draw(){
  background(255);

  if(started){
    line(width/2, 0, width/2, height);
  
    if(btn_control){
      dibujaSilueta();
    }else if(silueta.size() > 0){
      dibujaFigura();
    }
  }else{
    imprimeMenu();
  }
  
  //ficherogif.addFrame();
}

void keyPressed(){
  
  if(key == CODED && keyCode == CONTROL){
    btn_control = true;
  }
  
}

void keyReleased(){
  
  if(key == CODED && keyCode == CONTROL){
    btn_control = false;
  }
  
  if(key == 'i'){
    started = true;
    silueta.clear();
    loop();
  }
  
  if(key == 'm'){
    started = false;
    redraw();
  }
  
  /*
  if(key == 'r'){
    ficherogif.finish();
  }
  */
}

void mousePressed(){
  
  if (mouseButton == LEFT && btn_control) {
    if(mouseX >= width/2){
      Punto punto = new Punto(mouseX, mouseY, 0);
      silueta.add(punto);
    }
  }

}
