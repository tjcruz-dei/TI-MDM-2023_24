/**
 * Tecnologias de Interface, 2024
 * Universidade de Coimbra
 * MSc in Design and Multimedia
 *
 * Week 10
 * Frame Differencing
 * Quantify the amount of movement in the video frame using frame-differencing.
 * @based:   Golan Levin's Background Subtraction
 */
import processing.video.*;

Capture cam;
PImage previous;
int threshold = 10;

void setup() {
  size(640, 480);

  String[] devices = Capture.list();

  if (devices.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  }

  cam = new Capture(this, 640, 480, devices[0],30);
  cam.start();

  previous = new PImage (cam.width, cam.height, ARGB);
}

void draw() {
  if (cam.available()) {
    background(0);
    PImage dif = new PImage (cam.width, cam.height, ARGB);

    cam.read();
    cam.loadPixels();
    dif.loadPixels();

    for (int i = 0; i < cam.pixels.length; i++) {
      color current = cam.pixels[i];

      int diffR = (int) abs(red (current) - red (previous.pixels[i]));
      int diffG = (int) abs(green (current) - green (previous.pixels[i]));
      int diffB = (int) abs(blue (current) - blue (previous.pixels[i]));

      int movement = diffR + diffG + diffB;
 
      if (movement > threshold) {
        dif.pixels[i] = color(diffR, diffG, diffB);
      }
    }
    previous = cam.copy();
    dif.updatePixels();
    image (dif, 0, 0);
  }
}
