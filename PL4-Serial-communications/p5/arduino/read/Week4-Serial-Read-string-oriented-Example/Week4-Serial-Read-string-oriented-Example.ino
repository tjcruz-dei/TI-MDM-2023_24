/**
* Tecnologias de Interface, Winter 2023
* Universidade de Coimbra
* MSc in Design and Multimedia
*
* Week 4
* Example serial communication with Arduino (read, string oriented)
* 
* @since:   03–03–2023      
* @based:   https://www.arduino.cc/en/Tutorial/BuiltInExamples/ReadASCIIString
*/

int x;
String str;

void setup() {
  // Initialize serial data rate (bits per second) and wait for port to open
  Serial.begin(9600);

  // wait for serial port to connect. Needed for native USB port only (Leonardo only)
  while (!Serial) {
    ;
  }

  pinMode(LED_BUILTIN, OUTPUT);
}

void loop() {
  String s = "";
  // while there's any serial available, read it:
  while (Serial.available() > 0) {
    // reads characters from the serial buffer into a String. (until find a terminator char)
    // str = Serial.readStringUntil('\n');

    // converts the string to int
    // parses serial input until it finds the first char that is not a digit
    x = Serial.parseInt();

    // print the results
    // Serial.println((String) "str: " + str);
    Serial.println((String) "x: " + x);
  }
}
