/**
 * Tecnologias de Interface, 2024
 * Universidade de Coimbra
 * MSc in Design and Multimedia
 *
 * Week 10
 * Runtime video mask 
 *
 */
 
import gab.opencv.*;
import processing.video.*;

Capture cam;
PImage src, dst,img;
OpenCV opencv;

ArrayList<Contour> contours;


void setup() {
  size(640, 480);
  String[] cameras = Capture.list();

  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } 
  else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(i+":"+cameras[i]);
  }

    cam = new Capture(this, 640, 480, cameras[0]);
    cam.start();
  }
  //size(cam.width, cam.height/2);
  opencv = new OpenCV(this, cam);
  img = loadImage("back.jpg");
  img.resize(cam.width,cam.height);
}

void draw() {
  background(255);
  if (cam.available() == true) {
    cam.read();  
  }
  
  opencv.loadImage(cam);
  opencv.gray();
  opencv.threshold(90);
  opencv.erode();
  opencv.dilate();
  dst = opencv.getOutput();

  contours = opencv.findContours();

  dst.filter(INVERT);
  img.mask(dst);   
  image(img, 0, 0);
 
  noFill();
  strokeWeight(3);
  
  for (Contour contour : contours) {
    stroke(0, 255, 0);
    contour.draw();
    
    //Uncommment to check the contours
    //println(contour.getPoints());
    stroke(255, 0, 0);
  }
}
