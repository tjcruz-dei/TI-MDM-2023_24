/**
 * Tecnologias de Interface, 2024
 * Universidade de Coimbra
 * MSc in Design and Multimedia
 *
 * Week 10
 * Capture Processing Boilerplate
 * Reading and displaying an image from an attached Capture device.
 *
 * @based:   Daniel Shiffman's Software mirrors example
 */

import processing.video.*;

final int CELL_SIZE = 12;
int cols, rows;
Capture cam;

PImage frame;

void setup() {
  size(640, 480);

  String[] cameras = Capture.list();

  cam = new Capture(this, 640, 480, cameras[1]);

  cols = width/CELL_SIZE;
  rows = height/CELL_SIZE;

  colorMode(RGB, 255, 255, 255, 100);

  rectMode(CENTER);

  background(0);
  cam.start();
  
  // frame = loadImage("sample-image.jpg");
  // frame.resize(width, 0);
  // surface.setSize(frame.width, frame.height);
}

void draw() {
  if (cam.available() == true) {
    background(0);
    cam.read();
    
    frame = cam.copy();
    frame.loadPixels();

    for ( int i = 0; i < cols; i++) {
      for ( int j = 0; j < rows; j++) {

        int x = i*CELL_SIZE + CELL_SIZE/2;
        int y = j*CELL_SIZE + CELL_SIZE/2;
        int loc = x + y*frame.width;
        loc = constrain(loc, 0, frame.pixels.length-1);


        color c = color(red(frame.pixels[loc]), green(frame.pixels[loc]), blue(frame.pixels[loc]), 75);
        fill(c);

        pushMatrix();
        translate(x, y);
        noStroke();
        rotate((2*PI*saturation(c)/255.0f));
        float side = ((brightness(c)/255.0f)*CELL_SIZE);
        rect(0, 0, side, side);
        popMatrix();
      }
    }
  }
}
