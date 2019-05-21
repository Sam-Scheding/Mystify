
LineSystem ls;
PVector p1, p2, p3, vel1, vel2, vel3, direction1, direction2;

void setup(){
  
  fullScreen();
  p1 = new PVector(random(0, width), random(0, height));
  p2 = new PVector(random(0, width), random(0, height));
  p3 = new PVector(random(0, width), random(0, height));
  vel1 = new PVector(random(-5, 5), random(-5, 5));
  vel2 = new PVector(random(-5, 5), random(-5, 5));
  vel3 = new PVector(random(-5, 5), random(-5, 5));

  ls = new LineSystem();

}


void draw(){
  background(0);
  if(frameCount % 5 == 0){
    ls.addLine(p1, p2);
    ls.addLine(p2, p3);
    ls.addLine(p3, p1);
  }
  ls.run();
}



class LineSystem{
  
  ArrayList<Line> lines;
  
  LineSystem(){
    lines = new ArrayList<Line>();  
  }
  
  void addLine(PVector start, PVector end){
    lines.add(new Line(start.copy(), end.copy()));
  }
  
  void run() {
    
    p1.add(vel1);
    p2.add(vel2);
    p3.add(vel3);
    if(p1.x <= 0 || p1.x >= width){ vel1.x *= -1; }
    if(p1.y <= 0 || p1.y >= height){ vel1.y *= -1; }
    if(p2.x <= 0 || p2.x >= width){ vel2.x *= -1; }
    if(p2.y <= 0 || p2.y >= height){ vel2.y *= -1; }
    if(p3.x <= 0 || p3.x >= height){ vel3.x *= -1; }
    if(p3.y <= 0 || p3.y >= height){ vel3.y *= -1; }
    
    for (int i = lines.size()-1; i >= 0; i--) {
      Line l = lines.get(i);
      l.update();
      l.display();
      if (l.isDead()) {
        lines.remove(i);
      }
    }
  }  
}

class Line{
  
  PVector p1, p2;
  int lifespan;
  
  Line(PVector p1, PVector p2){
    
    this.p1 = p1;
    this.p2 = p2;
    this.lifespan = 100;
  }
  
  void update(){
    lifespan -= 1.0;
  }

  void display() {
    color c = color(p1.x, 255-p1.y, p2.y);
    strokeWeight(2);
    stroke(c);
    line(p1.x, p1.y, p2.x, p2.y);
  }
  boolean isDead(){
    return(this.lifespan <= 0);
  }
  
}
