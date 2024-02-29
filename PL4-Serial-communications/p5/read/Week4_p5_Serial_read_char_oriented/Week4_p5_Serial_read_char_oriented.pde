/**
* Tecnologias de Interface, Winter 2023
* Universidade de Coimbra
* MSc in Design and Multimedia
*
* Week 4
* Example serial communication with Arduino and Processing (char-oriented)
* 
* @since:   03–03–2023      
* @based:   https://processing.org/reference/libraries/serial/Serial_readChar_.html
*/


import processing.serial.*;
Serial myPort;

void setup() {
  size(500,500);
  
  // get and print the list of avariable ports
  printArray(Serial.list());
  
  //change to match the port
  String portName = Serial.list()[2];
  
  myPort = new Serial(this, portName, 9600);
  // removes all data stored on buffer
  myPort.clear();
}

void draw() {
  background (255);
  // when data is on port
  if (myPort.available() > 0) {
    // read the data in buffer
    char inByte=myPort.readChar();
    
    // alternative
    // int inByte = myPort.read();
    
    // print the raw data
    println(inByte);
    fill(0);
    // display the raw data
    textSize(36);
    text(char(inByte), width/2-textWidth(char(inByte)), height/2);
  }
}
