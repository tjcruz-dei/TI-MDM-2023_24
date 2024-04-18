/**
 * Tecnologias de Interface, 2024
 * Universidade de Coimbra
 * MSc in Design and Multimedia
 *
 * Week 10
 * Hue Histogram
 *
 * @based:   Processing Brightness Histogram example
 */

import processing.video.*;
Capture cam;

PImage frame;

void setup() {
  size(640, 360);
  String[] devices = Capture.list();
  // printArray(devices);

  if (devices.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  }

  cam = new Capture(this, 640, 480, devices[1]);
  cam.start();

  colorMode(HSB, 360, 100, 100);
  noStroke();
  smooth();

  // frame = loadImage("sample-image.jpg");
  // frame.resize(width, 0);
  // surface.setSize(frame.width, frame.height);
}

void draw () {
  if (cam.available()) {
    background(0);
    cam.read();
    frame = cam.copy();

    int[] histogram = new int[360];

    // Calculate the histogram
    for (int i = 0; i < frame.width; i++) {
      for (int j = 0; j < frame.height; j++) {
        int hue = int(hue(frame.get(i, j)));
        histogram[hue]++;
      }
    }

    // compute max of histogram
    int max = max(histogram);
    tint(100);
    image(frame, 0, 0);

    for (int i= 0; i <histogram.length; i++) {
      float x = map (i, 0, histogram.length, 0, width);
      stroke(i, 100, 100);

      int y = int(map(histogram[i], 0, max, 0, height/2));
      line (x, height, x, height-y);
    }

    // printArray(histogram);
  }
}
