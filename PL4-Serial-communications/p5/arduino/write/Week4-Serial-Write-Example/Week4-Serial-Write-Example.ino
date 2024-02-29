/**
* Tecnologias de Interface, Winter 2023
* Universidade de Coimbra
* MSc in Design and Multimedia
*
* Week 4
* Example serial communication with Arduino (write)
* 
* @since:   03–03–2023      
* @based:   https://www.arduino.cc/en/Tutorial/BuiltInExamples/ASCIITable
*/

void setup() {
  // Initialize serial data rate (bits per second) and wait for port to open
  Serial.begin(9600); 

  // wait for serial port to connect. Needed for native USB port only (Leonardo only)
  while (!Serial) {
    ; 
  }
}

void loop() {
  // prints value unaltered, i.e. the raw binary version of the byte.
  // The Serial Monitor interprets all bytes as ASCII, so 33, the first number,
  // will show up as '!'
  // Serial.write (33);
  
  // Prints data to the serial port as human-readable ASCII text.
  // println() sends values as strings, terminating with CR+LF
  Serial.println("1: Hello world!");
  
  // concat strings to sent to serial port
  Serial.println((String)"2: " + "Hello world!");

  // concat various type of data into string and sent to serial port
  Serial.println((String)3 + ": Hello world!");

  // print() is the simplest version, without CR+LF 
  String w = "world!";
  Serial.print (4);
  Serial.print (": Hello ");
  Serial.println (w);  

  delay(500);
}
