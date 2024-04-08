
/**
 * Tecnologias de Interface, 2024
 * Universidade de Coimbra
 * MSc in Design and Multimedia
 *
 * Week 9
 * Waveform Analysis
 *
 * @authors: Tiago Cruz
 * @since:   04-2024
 * @based:   Processing Sound example
 */
 
import processing.sound.*;

AudioIn in;
Waveform waveform;
int samples=512;

void setup()
{
  //If you get an error, remove the P3D
  size(512, 200, P3D);
  println(Sound.list());

  in = new AudioIn(this, 0);
  in.start();
  waveform = new Waveform(this, samples);
  waveform.input(in);
}

void draw()
{
  background(0);
  stroke(255);
  
  waveform.analyze();
  
  for (int i = 0; i < (waveform.data).length-1; i++)
  {
    line( i, 100 + waveform.data[i]*100, i+1, 100 + waveform.data[i+1]*100 );
  }
}
