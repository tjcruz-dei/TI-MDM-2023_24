/**
 * Tecnologias de Interface, 2024
 * Universidade de Coimbra
 * MSc in Design and Multimedia
 *
 * Week 9
 * FFT Spectrum analysis
 *
 * @authors: Tiago Cruz
 * @since:   04-2024
 * @based:   Processing Sound example
 */
 
import processing.sound.*;

// Declare the sound source and FFT analyzer variables
SoundFile sample;
FFT fft;

// Define how many FFT bands to use (this needs to be a power of two)
int bands = 128;

// Create a vector to store the smoothed spectrum data in
float[] sum = new float[bands];

// Variables for drawing the spectrum:
// Declare a scaling factor for adjusting the height of the rectangles
int scale = 5;
// Declare a drawing variable for calculating the width of the 
float barWidth;

public void setup() {
  size(640, 360,P3D);
  background(0);
  stroke(255);

  // Calculate the width of the rects depending on how many bands we have
  barWidth = width/float(bands);

  // Load and play a soundfile and loop it.
  // use your own file!!
  sample = new SoundFile(this, "file.mp3");
  sample.loop();

  // Create the FFT analyzer and connect the playing soundfile to it.
  fft = new FFT(this, bands);
  fft.input(sample);
}

public void draw() {
  // Set background color, noStroke and fill color
  background(0);

  // Perform the analysis
  fft.analyze();

  for (int i = 0; i < bands; i++) {
    fill(i,255-i,i*2);
    // Draw the rectangles, adjust their height using the scale factor
    rect(i*barWidth, height, barWidth, -fft.spectrum[i]*height*scale);
  }
}
