/**
 * Tecnologias de Interface, 23/2024
 * Universidade de Coimbra
 * MSc in Design and Multimedia
 *
 * Week 11
 *  Object Detection (YOLO)
 *
 * @based:   based FaceDetector Example from DeepVision
 */
 
import ch.bildspur.vision.*;
import ch.bildspur.vision.result.*;

DeepVision deepVision = new DeepVision(this);
YOLONetwork yolo;
ResultList<ObjectDetectionResult> detections;

String [] paths = {"image-1.jpg", "image-2.jpg", "image-3.jpg", "image-4.jpg", "image-5.jpg", "image-6.jpg", "pexels-lina-kivaka-5623971.jpg"};
int current = 0;

PImage image;
int textSize = 12;

public void setup() {
  size(640, 480);

  colorMode(HSB, 360, 100, 100);

  config();
}

public void draw() {
  background(55);

  image(image, 0, 0);

  noFill();
  strokeWeight(2f);

  strokeWeight(3f);
  textSize(textSize);

  for (ObjectDetectionResult detection : detections) {
    int hue = (int)(360.0 / yolo.getLabels().size() * detection.getClassId());

    noFill();
    stroke(hue, 80, 100);
    rect(detection.getX(), detection.getY(), detection.getWidth(), detection.getHeight());

    fill(hue, 80, 100);
    rect(detection.getX(), detection.getY() - (textSize + 3), textWidth(detection.getClassName()) + 4, textSize + 3);

    fill(0);
    textAlign(LEFT, TOP);
    text(detection.getClassName(), detection.getX() + 2, detection.getY() - textSize - 3);
  }

  surface.setTitle("YOLO Test - FPS: " + Math.round(frameRate));
}


void mousePressed() {
  background(0);
  current = (current + 1) % paths.length;
  config();
}

void config () {
  image = loadImage(paths[current]);
  image.resize(width, 0);
  surface.setSize(image.width, image.height);

  yolo = deepVision.createYOLOv5l();
  yolo.setup();

  yolo.setConfidenceThreshold(0.95f);
  yolo.setTopK(0);

  detections = yolo.run(image);
}
