/**
 * Tecnologias de Interface
 * Universidade de Coimbra
 * MSc in Design and Multimedia
 *
 * Week 4
 * Exercise 2
 *
 * @since:   02–03–2024
 */


import processing.serial.*;
Serial myPort;
byte ledState = 'L';

void setup() {
  size(500, 500);

  // get and print the list of avariable ports
  printArray(Serial.list());

  //change to match the port
  String portName = Serial.list()[1];

  myPort = new Serial(this, portName, 9600);

  // sets a specific byte to buffer until before calling serialEvent().
  myPort.bufferUntil('\n');

  // removes all data stored on buffer
  myPort.clear();
}

void draw() {
  background(255);
 
  if (ledState == 'H') {
    fill(255,0,0);
  } else {
    fill(0,0,0);
  }
   ellipse(250,250,200,200);
}

void mousePressed () {
   if (dist(mouseX,mouseY,250,250)<=100){
      if (ledState == 'H') 
        ledState = 'L';
      else 
        ledState = 'H';
      myPort.write(ledState);
   }
}
