/**
 * Tecnologias de Interface, 2024
 * Universidade de Coimbra
 * MSc in Design and Multimedia
 *
 * Week 9
 * Windmill 1 - noGL
 *
 * @authors: Tiago Cruz
 * @since:   04-2024
 * @based:   Processing Sound example
 */

import processing.sound.*;
AudioIn in;
Amplitude amp;

float arc=0;
float step=0, radius=0;

void setup()
{
  size(640, 480);
  radius=150;
  println(Sound.list());
  in = new AudioIn(this, 0);
  amp = new Amplitude(this);
  in.start();
  amp.input(in);
}

void draw()
{
  background(0);
  stroke(255);

  float Impulse=(amp.analyze()*QUARTER_PI/2);

  if (step<0.4) step=step+Impulse;
  
  //friction
  if (step>0.01)
    step=step-radians(sqrt(step)/5);
  else step=0;

  arc=(arc+step)%TWO_PI;

  triangle(320, 240, 320+radius*cos(arc-0.2), 240+radius*sin(arc-0.2), 320+radius*cos(arc+0.2), 240+radius*sin(arc+0.2));
  triangle(320, 240, 320+radius*cos(arc+PI-0.2), 240+radius*sin(arc+PI-0.2), 320+radius*cos(arc+PI+0.2), 240+radius*sin(arc+PI+0.2));
}
