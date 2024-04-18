/**
 * Tecnologias de Interface, 2024
 * Universidade de Coimbra
 * MSc in Design and Multimedia
 *
 * Week 10
 * Color Tracking
 * Euclidean distance color tracker
 *
 */

import processing.video.*;

color track = color(0);
Capture cam;

PImage frame, m;
boolean show = false;

void setup() {
  size(660, 480);

  String[] devices = Capture.list();

  if (devices.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  }

  cam = new Capture(this, 640, 480, devices[0]);

  cam.start();

  noStroke();
  smooth();

  // frame = loadImage("sample-image.jpg");
  // frame.resize(width, 0);
  // surface.setSize(frame.width, frame.height);
}

void draw() {
  float min = Float.MAX_VALUE;
  PVector pos = new PVector (0, 0);

  if (cam.available()) {
    background(0);
    cam.read();

    frame = cam.copy();
    m = new PImage (frame.width, frame.height, ARGB);

    cam.loadPixels();
    m.loadPixels();
    for (int y = 0; y < frame.height; y++) {
      for (int x = 0; x < frame.width; x++) {
        int loc = x + y * frame.width;
        color current = frame.pixels[loc];
         
        //Euclidean distance to color
        float distance = dist(
          red(current), green(current), blue(current),
          red(track), green(track), blue(track));

        if (distance < 100) {
          m.pixels[loc] = color(255-distance);
        }

        if (distance < min) {
          min = distance;
          pos.x = x;
          pos.y = y;
        }
      }
    }
    m.updatePixels();

    
    image(show ? m : frame, 0, 0, width, height);


    // Draw a large, yellow circle at the position
    fill(255, 0, 255);
    ellipse(pos.x, pos.y, 10, 10);

    fill(track);
    rect(width-20, 0, 20, height);
  }
}

void mousePressed() {
  int loc = mouseX + mouseY * frame.width;
  track = frame.pixels[loc];
}


void keyPressed () {
  switch (Character.toUpperCase(key)) {
  case 'S':
    show = !show;
    break;
  default:
    break;
  }
}
