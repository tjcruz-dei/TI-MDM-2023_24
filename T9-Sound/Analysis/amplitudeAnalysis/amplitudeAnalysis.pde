/**
 * Tecnologias de Interface, 2024
 * Universidade de Coimbra
 * MSc in Design and Multimedia
 *
 * Week 9
 * Amplitude/volume Analysis
 *
 * @authors: Tiago Cruz
 * @since:   04-2024
 * @based:   Processing Sound example
 */
 
import processing.sound.*;
AudioIn in;
Amplitude amp;
float prev;
int i=0;

void setup()
{
  //If you get an error, remove the P3D
  size(512, 200, P3D);
  background(0);
  
  println(Sound.list());

  in = new AudioIn(this, 0);
  in.start();
  amp = new Amplitude(this);
  amp.input(in);
  prev=amp.analyze();
}

void draw()
{
  if (i==0) background(0);
  stroke(255);
  float newSample=amp.analyze();
  line( i, 100 -prev*100, i+1, 100 -newSample*100 );
  i=(i+1)%width;
  prev=newSample;
}
