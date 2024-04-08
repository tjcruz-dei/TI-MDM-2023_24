/**
 * Inspect the frequency spectrum of different simple oscillators.
 */

import processing.sound.*;

// All oscillators are instances of the Oscillator superclass.
Oscillator oscs[] = new Oscillator[5];

// Store information on which of the oscillators is currently playing.
int current = 0;
Waveform waveform;
int samples=640;


void setup() {
  size(640, 360);
  background(255);

  // Turn the volume down globally.
  Sound s = new Sound(this);
  s.volume(0.2);

  // Create the oscillators and put them into an array.
  oscs[0] = new SinOsc(this);
  oscs[1] = new TriOsc(this);
  oscs[2] = new SawOsc(this);
  oscs[3] = new SqrOsc(this);

  // Special treatment for the Pulse oscillator to set its pulse width.
  Pulse pulse = new Pulse(this);
  pulse.width(0.05);
  oscs[4] = pulse;
  
  waveform = new Waveform(this, samples);
  waveform.input(oscs[current]);
  oscs[current].play();
}

void draw() {
  // Map mouseX from 20Hz to 22000Hz for frequency.
  float frequency = map(mouseX, 0, width, 20.0, 22000.0);
  // Update oscillator frequency.
  oscs[current].freq(frequency);

  background(0);  
  waveform.analyze();
  
  stroke(255);
  for (int i = 0; i < (waveform.data).length-1; i++)
  {
    line( i, 180 + waveform.data[i]*100, i+1, 180 + waveform.data[i+1]*100 );
  }
  
  // Display the name of the oscillator class.
  textSize(32);
  fill(255);
  float verticalPosition = map(current, -1, oscs.length, 0, height);
  text(oscs[current].getClass().getSimpleName(), 0, verticalPosition);
}

void keyPressed()
{ 
  if ((key>='0') && (key<='4')) {
     if ((int(key-48) != current)) {
      oscs[current].stop();
      current = int(int(key-48));
      oscs[current].play();
      waveform.input(oscs[current]); 
     }
  }
}
