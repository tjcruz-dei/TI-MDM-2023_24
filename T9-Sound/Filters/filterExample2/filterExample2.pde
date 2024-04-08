/**
 * Tecnologias de Interface, 2024
 * Universidade de Coimbra
 * MSc in Design and Multimedia
 *
 * Week 9
 * Play with filters using a sound file as source
 *
 * @authors: Tiago Cruz
 * @since:   04-2024
 * @based:   Processing Sound example
 */
 

import processing.sound.*;

// All oscillators are instances of the Oscillator superclass.
SoundFile sample;
Effect filts[] = new Effect[5];

// Store information on which of the oscillators is currently playing.
int current = 0;
FFT fft;
int fftBands = 256;


void setup() {
  size(640, 360);
  background(255);
    
  filts[0] = new LowPass(this);
  filts[1] = new HighPass(this);
  filts[2] = new BandPass(this);
  
  //change file name
  sample = new SoundFile(this, "file.mp3");
  sample.loop();
  
   // Initialise the FFT and start playing the (default) oscillator.
  fft = new FFT(this, 512);
  filts[current].process(sample);
  fft.input(sample);
}

void draw() {
  // Map mouseX from 20Hz to 22000Hz for frequency.
  float frequency = map(mouseX, 0, width, 20.0, 10000.0);
  // Update oscillator frequency.
  if (current==0) ((LowPass)(filts[current])).freq(frequency);
  if (current==1) ((HighPass)(filts[current])).freq(frequency);
  if (current==2) {
     float bw = map(mouseY, 0, height, 2000.0, 0.0);
    ((BandPass)(filts[current])).freq(frequency);
    ((BandPass)(filts[current])).bw(bw);
  }
  background(0);  
  stroke(255);
  fft.analyze();

  float r_width = width/float(fftBands);

  for (int i = 0; i < fftBands; i++) {
    rect( i*r_width, height, r_width, -fft.spectrum[i]*height*10);
  }

  // Display the name of the oscillator class.
  textSize(32);
  fill(255);
  float verticalPosition = map(current, -1, filts.length, 0, height);
  text(filts[current].getClass().getSimpleName(), 0, verticalPosition);
}

void keyPressed()
{ 
  if ((key>='0') && (key<='2')) {
     if ((int(key-48) != current)) {
      filts[current].stop();
      current = int(int(key-48));
      filts[current].process(sample);
      fft.input(sample);
     }
  }
}
