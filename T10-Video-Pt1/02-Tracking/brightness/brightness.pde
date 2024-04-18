/**
 * Tecnologias de Interface, 2024
 * Universidade de Coimbra
 * MSc in Design and Multimedia
 *
 * Week 10
 * Brightness Tracking
 * Tracks the brightest pixel in a live video signal.
 *
 * @based:   Golan Levin's Brightness Tracking
 */

import processing.video.*;
Capture cam;

PImage frame, m;
boolean show = false;


void setup() {
  size(640, 480);

  String[] devices = Capture.list();
  // printArray(devices);

  if (devices.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  }

  cam = new Capture(this, 640, 480, devices[0],30);
  cam.start();

  noStroke();
  smooth();

  // frame = loadImage("sample-image.jpg");
  // frame.resize(width, 0);
  // surface.setSize(frame.width, frame.height);
}

void draw() {
  if (cam.available()) {
    cam.read();
    frame = cam.copy();

    // brightness map
    m = new PImage(frame.width, frame.height, ARGB);

    PVector brightest = new PVector (-1, -1);
    float max = -1; // Brightness of the brightest video pixel

    m.loadPixels();
    for (int y = 0; y < frame.height; y++) {
      for (int x = 0; x < frame.width; x++) {
        int loc = x + y * frame.width;
        // Determine the brightness of the pixel
        float current = brightness(frame.pixels[loc]);

        m.pixels[loc] = color(current);

        if (current > max) {
          max = current;
          brightest.y = y;
          brightest.x = x;
        }
      }
    }

    m.updatePixels();

    if (show) {
      image (m, 0, 0);
    } else {
      image(frame, 0, 0, width, height);
    }

    // brightest pixel
    fill(255, 0, 255);
    circle(brightest.x, brightest.y, 10);
  }
}

void mousePressed () {
  show = !show;
}
