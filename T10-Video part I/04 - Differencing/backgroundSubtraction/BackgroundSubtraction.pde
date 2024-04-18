/**
 * Tecnologias de Interface, 2024
 * Universidade de Coimbra
 * MSc in Design and Multimedia
 *
 * Week 10
 * Background Subtraction
 * Detect the presence of people and objects in the frame using a simple
 * background-subtraction technique. To initialize the background, press a key.
 *
 * @based:   Golan Levin's Background Subtraction
 */

import processing.video.*;

int numPixels;
int[] backgroundPixels;

Capture cam;

void setup() {
  size(640, 480);

  String[] devices = Capture.list();

  if (devices.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  }

  cam = new Capture(this, 640, 480, devices[0],30);
  cam.start();

  // Create array to store the background image
  numPixels = cam.width * cam.height;
  backgroundPixels = new int[numPixels];

  loadPixels();
}

void draw() {
  if (cam.available()) {
    background(0);
    cam.read();
    cam.loadPixels();
    // Difference between the current frame
    // and the stored background
    int movement = 0;
    for (int i = 0; i < numPixels; i++) { // For each pixel in the video frame...
      color current = cam.pixels[i];
      color bkgd = backgroundPixels[i];

      int diffR = (int) abs(red (current) - red (bkgd));
      int diffG = (int) abs(green (current) - green (bkgd));
      int diffB = (int) abs(blue (current) - blue (bkgd));

      movement += diffR + diffG + diffB;

      // display difference between current and background
      // pixels[i] = color(diffR, diffG, diffB);

      // display diferent pixels
      if (diffR > 20 && diffG > 20 && diffB > 20) {
        pixels[i] = current;
      } else {
        pixels[i] = color (0);
      }
    }
    updatePixels();
    // Print out the total amount of movement
    println(movement);
  }
}

// When a key is pressed, capture the background image into the backgroundPixels
// buffer, by copying each of the current frame's pixels into it.
void keyPressed() {
  cam.loadPixels();
  arrayCopy(cam.pixels, backgroundPixels);
}
