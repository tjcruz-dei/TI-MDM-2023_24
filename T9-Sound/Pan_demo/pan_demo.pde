/**
 * This sketch shows how to use the pan() method 
 */

import processing.sound.*;

SoundFile soundF;

float panPos=0;

public void setup() {
  size(640, 360,P3D);
  background(0);
  stroke(255);

  // Load and play a soundfile and loop it.
  soundF = new SoundFile(this, "file.mp3");
  soundF.loop();
  rectMode(CENTER);
}

public void draw() {
  // Set background color, noStroke and fill color
  background(0);
  
  float posW=map(panPos,-1,1,0,width);
  line(0,height/2,width,height/2);
  rect(posW,height/2,20,50);
}

void keyPressed(){
  if (key=='-') panPos=panPos-0.1; 
  if (key=='+') panPos=panPos+0.1; 
  soundF.pan(constrain(panPos,-1,1));
}
