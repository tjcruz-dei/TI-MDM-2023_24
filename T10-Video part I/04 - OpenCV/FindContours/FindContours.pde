/**
 * Tecnologias de Interface, 2024
 * Universidade de Coimbra
 * MSc in Design and Multimedia
 *
 * Week 10
 * Countour Detection with Open CV
 *
 */

import gab.opencv.*;
import processing.video.*;

Capture cam;
PImage src, result;
OpenCV opencv;

ArrayList<Contour> contours;
ArrayList<Contour> polygons;

PImage frame;
boolean polygonApproximation = false;
boolean mask = false;

void setup() {
  size(1280, 480);
  String[] devices = Capture.list();
  printArray(devices);

  if (devices.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  }


  cam = new Capture(this, 640, 480, devices[0]);
  cam.start();

  opencv = new OpenCV(this, cam);

  // frame = loadImage("sample-image.jpg");
  // frame.resize(width/2, 0);
  // surface.setSize(frame.width*2, frame.height);
}

void draw() {
  if (cam.available() == true) {
    background(245);
    cam.read();

    frame = cam.copy();

    opencv.loadImage(frame);
    opencv.gray();
    opencv.threshold(90);
    opencv.erode();
    opencv.dilate();
    result = opencv.getOutput();

    // get countours
    contours = opencv.findContours();
    // println("found", contours.size(), "contours");

    image(frame, 0, 0);

    if (mask) {
      result.filter(INVERT);
      // ensure that result has the same size than frame
      result = result.get(0,0, frame.width, frame.height);
      PImage copiedFrame = frame.copy();
      copiedFrame.mask(result);
      image(copiedFrame, frame.width, 0);
    } else {
      image(result, frame.width, 0);
    }

    noFill();
    strokeWeight(1);

    for (Contour contour : contours) {
      color c = polygonApproximation ? color(255, 0, 0) : color(0, 255, 0);
      // draw contour
      if (!polygonApproximation) {
        stroke(c);
        contour.draw();
      } else {
        stroke(c);
        beginShape();
        for (PVector point : contour.getPolygonApproximation().getPoints()) {
          vertex(point.x, point.y);
        }
        endShape();
      }
    }
  }
}


void keyPressed () {
  char k = Character.toUpperCase(key);
  if (k == 'A') {
    polygonApproximation = !polygonApproximation;
  } else if (k == 'M') {
    mask = !mask;
  }
}
