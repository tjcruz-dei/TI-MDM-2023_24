/**
 * Tecnologias de Interface, 2024
 * Universidade de Coimbra
 * MSc in Design and Multimedia
 *
 * Week 10
 * Face Detection with open CV
 *
 */


import gab.opencv.*;
import java.awt.Rectangle;
import processing.video.*;
import org.opencv.imgproc.Imgproc;

Capture cam;
OpenCV faceClassifier, eyesClassifier;
Rectangle[] faces, eyes;

PImage frame;

// region of interest in an image (ROI)
boolean ROI = true;

void setup() {
  size(640, 480);

  String[] cameras = Capture.list();
  printArray(cameras);

  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  }

  cam = new Capture(this, 640, 480, cameras[1]);
  cam.start();

  // create open cv objects
  faceClassifier = new OpenCV(this, cam);
  eyesClassifier = new OpenCV(this, cam);

  // load face classifier
  faceClassifier.loadCascade(OpenCV.CASCADE_FRONTALFACE);
  // load eye classifier
  eyesClassifier.loadCascade(OpenCV.CASCADE_EYE); // CASCADE_FRONTALFACE
  
  // frame = loadImage("sample-image.jpg");
  // frame.resize(width, 0);
  // surface.setSize(frame.width, frame.height);
}

void draw() {
  if (cam.available() == true) {
    cam.read();
    background (0);
    
    frame = cam.copy();

    faceClassifier.loadImage(frame);
    faces = faceClassifier.detect();

    image(frame, 0, 0);

    noFill();
    stroke(0, 0, 255);
    strokeWeight(2);

    for (int i = 0; i < faces.length; i++) {
      rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);

      if (ROI) {
        eyesClassifier.loadImage(frame);
        // preprocess the image
        eyesClassifier.brightness(20);
        eyesClassifier.erode();
        // define region of interest
        eyesClassifier.setROI(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
        // classifier eyes
        eyes = eyesClassifier.detect();

        stroke(255,0,0);
        
        if (eyes.length==2) {
          for (int j = 0; j < eyes.length; j++) {
            if (eyes[j].y<faces[i].height/2)
              rect(faces[i].x+eyes[j].x, faces[i].y+eyes[j].y, eyes[j].width, eyes[j].height);
          }
        }
      }
    }
  }
}
