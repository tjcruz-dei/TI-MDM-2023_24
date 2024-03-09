/**
 * Tecnologias de Interface
 * Universidade de Coimbra
 * MSc in Design and Multimedia
 *
 * Author: Tiago Cruz
 * Week 4
 * Homework challenge 1
 *
 * @since:   02–03–2024
 */
 
import processing.serial.*;

ball b;
Serial myPort;
char cmd;

void setup(){
  size(1024,1024);
  println(Serial.list());
  String portName = Serial.list()[2]; //choose the right serial port
  myPort = new Serial(this, portName, 9600);
  //myPort.bufferUntil('\n');
  b=new ball(width/2,height/2,20);
  ellipseMode(CENTER);
}

void draw(){
  background(255);
  
  b.steer(cmd);
  b.move();
  b.show();
  b.collide();
  cmd=0;
}

void serialEvent(Serial myPort) {
      try {
           cmd = (char) myPort.read();  
           println(cmd);
      }
      catch (Exception e) {
            e.printStackTrace(); 
      }
}

void keyPressed() {
  cmd=key;
}

class ball{
    PVector pos;
    PVector dir;
    
    int rad;
    
    ball(int _x, int _y, int _rad) {
         pos=new PVector(0,0);
         dir=new PVector(0,0);
         pos.x=_x;
         pos.y=_y;
         rad=_rad;
         dir.x=0;
         dir.y=-1;
    }
    
    void steer(char cmd){
      if (cmd=='L') dir.rotate(radians(-2));
      else if (cmd=='R') dir.rotate(radians(2));
      println(degrees(dir.heading()));
    }
    
    void move(){
      pos.add(dir);
    }
    
    void collide(){
      PVector plim=new PVector();
      plim=PVector.add(pos,dir);
      if ((plim.x>width-rad) || (plim.x<rad)) dir.rotate(2*(HALF_PI-dir.heading()));
      if ((plim.y>width-rad) || (plim.y<rad)) dir.rotate(-2*(dir.heading()));

    }
    
    void show(){
        ellipse(pos.x,pos.y,rad*2,rad*2);
        line(pos.x,pos.y,pos.x+10*cos(dir.heading()),pos.y+10*sin(dir.heading()));
    }
    
}
