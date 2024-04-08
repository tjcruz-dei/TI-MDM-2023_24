/**
 * Tecnologias de Interface, 2024
 * Universidade de Coimbra
 * MSc in Design and Multimedia
 *
 * Week 9
 * Windmill 2 - with GL support
 *
 * @authors: Tiago Cruz
 * @since:   04-2024
 * @based:   Processing Sound example
 */
 
import processing.sound.*;
AudioIn in;
Amplitude amp;

float arc=0;
float step=0,radius=0;

void setup()
{
  size(640, 480,OPENGL);
  radius=150;
  amp = new Amplitude(this);
  in = new AudioIn(this, 0);
  in.start();
  amp.input(in);
}

void draw()
{
  background(0); 
  
 float Impulse=(amp.analyze()*QUARTER_PI/2);
  if (step<0.4) step=step+Impulse;
  
  //friction
  if (step>0.01)
    step=step-radians(sqrt(step)/5);
  else step=0;
  
  float grad=map(step,0,0.4,0,255);
  arc=(arc+step)%TWO_PI;
  
  pushMatrix();
  
  translate(width/2,height/2);
  rotate(arc);
 

  beginShape();
    fill(grad,255-grad,grad);
    vertex(radius*cos(-0.2),radius*sin(-0.2));
    vertex(radius*cos(0.2),radius*sin(0.2));
    fill(255,255,255);
    vertex(0,0);
    fill(grad,255-grad,255-grad);
    vertex(radius*cos(-0.2+PI),radius*sin(-0.2+PI));
    vertex(radius*cos(0.2+PI),radius*sin(0.2+PI));
    fill(255,255,255);
    vertex(0,0);
  endShape();
  popMatrix();
}
