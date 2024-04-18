/**
 * Tecnologias de Interface, 2024
 * Universidade de Coimbra
 * MSc in Design and Multimedia
 *
 * Week 10
 * Capture Processing Boilerplate
 * Reading and displaying an image from an attached Capture device.
 *
 * @since:   28–04–2023
 * @based:   Processing Video example
 */

import processing.video.*;

Capture cam;

void setup() {
  size(1280, 720);

  String[] cameras = Capture.list();

  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    printArray(cameras);

    //if it fails replace cameras[0] per "pipeline:autovideosrc"
    cam = new Capture(this, 1280, 720, cameras[0],30);
    cam.start();
  }
  frameRate(30);
}

void draw() {
  if (cam.available() == true) {
    cam.read();
    image(cam, 0, 0);
  }
}
