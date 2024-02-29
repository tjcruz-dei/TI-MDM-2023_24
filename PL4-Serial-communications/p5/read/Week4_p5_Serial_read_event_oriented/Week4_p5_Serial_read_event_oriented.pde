/**
 * Tecnologias de Interface, Winter 2023
 * Universidade de Coimbra
 * MSc in Design and Multimedia
 *
 * Week 4
 * Example serial communication with Arduino and Processing (event-oriented)
 *
 * @since:   03–03–2023
 * @based:   https://processing.org/reference/libraries/serial/Serial_readString_.html
 */


import processing.serial.*;
Serial myPort;
String value = "";

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
  background (255);
  
  // display the raw data
  fill(0);
  textSize(36);
  text(value, width/2-textWidth(value)/2, height/2);
}

void serialEvent(Serial myPort) { 
  // put the incoming data into a String 
  // the '\n' is our end delimiter  
  // indicating the end of a complete packet
  value = myPort.readString(); 
  // alternative
  // value = myPort.readStringUntil('\n');
  
  if (value != null) {
    // remove breakline in the end of buffer
    String str = value.substring(0, value.length()-2);
    
    // alternative
    // String str = int(trim(value));
    println ("received:", str);
  }
} 
