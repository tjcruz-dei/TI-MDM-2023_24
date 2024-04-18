/**
 * Tecnologias de Interface, 2024
 * Universidade de Coimbra
 * MSc in Design and Multimedia
 *
 * Week 10
 * Software Mirrors
 *
 * @based:   Daniel Shiffman's Software mirrors example
 */

import processing.video.*;


final int CELL_SIZE = 8;
int cols, rows;
Capture cam;

PImage frame;

void setup() {
  size(640, 480);

  String[] devices = Capture.list();
  // printArray(devices);

  cam = new Capture(this, 640, 480, devices[1]);
  cam.start();

  //set up columns and rows
  cols = width/CELL_SIZE;
  rows = height/CELL_SIZE;

  colorMode(RGB, 255, 255, 255, 100);
  rectMode(CENTER);
  background(0);
  frameRate(30);
  
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
      //begin loop for rows
      for ( int j = 0; j < rows; j++) {
        int x = i * CELL_SIZE + CELL_SIZE/2;
        int y = j * CELL_SIZE + CELL_SIZE/2;
        int loc = int(x + y * frame.width);
         
        loc = constrain(loc, 0, frame.pixels.length-1);
       
        noStroke();
        //make a new color with alpha value
        color c = color(red(frame.pixels[loc]), green(frame.pixels[loc]), blue(frame.pixels[loc]), 100);
        
        //our drawing code, we are using translate
        pushMatrix();
        translate(x, y);
        
        //each rectangle colored white with a size determined by brightness
        fill(brightness(c));
        float side = ((brightness(c)/255.0f)*CELL_SIZE);
        
        rect(0, 0, side, side);
        popMatrix();
      }
    }
  }
  // cam.updatePixels();
}
