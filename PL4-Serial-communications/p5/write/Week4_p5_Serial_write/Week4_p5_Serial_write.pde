/**
 * Tecnologias de Interface
 * Universidade de Coimbra
 * MSc in Design and Multimedia
 *
 * Week 4
 * Example serial communication with Arduino and Processing (write)
 *
 * @since:   03–03–2023
 * @based:   https://processing.org/reference/libraries/serial/Serial_write_.html
 */



import processing.serial.*;
Serial myPort;
byte ledState = 'L';

void setup() {
  size(500, 500);

  // get and print the list of avariable ports
  printArray(Serial.list());

  //change to match the port
  String portName = Serial.list()[2];

  myPort = new Serial(this, portName, 9600);

  // sets a specific byte to buffer until before calling serialEvent().
  myPort.bufferUntil('\n');

  // removes all data stored on buffer
  myPort.clear();
}

void draw() {
  if (ledState == 'H') {
    background (255);
  } else {
    background (0);
  }
}

void mousePressed () {

  // sent a uppercase H or L out the serial port
  if (ledState == 'H') {
    ledState = 'L';
    // alternatively, sent the code
    // ledState = 76;
  } else {
    ledState = 'H';
    // alternatively, sent the code
    // ledState = 72;
  }

  myPort.write(ledState);

  // sent a string
  // myPort.write("this is a string!");
}
