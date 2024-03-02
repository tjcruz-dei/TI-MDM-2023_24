/**
* Tecnologias de Interface, Winter 2023
* Universidade de Coimbra
* MSc in Design and Multimedia
*
* Week 4
* Example serial communication with Arduino (read, byte oriented)
* 
* @since:   03–03–2023      
* @based:   https://www.arduino.cc/en/Tutorial/BuiltInExamples/ReadASCIIString
*/

char incomingByte;

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
  // if there's any serial available, read it:
  if (Serial.available()) {
    incomingByte = (char)Serial.read();
    if (incomingByte == 'H') {
       // if it's a capital H (ASCII 72), turn on the LED:
      digitalWrite(LED_BUILTIN, HIGH);
    } else if (incomingByte == 'L') {
      // if it's an L (ASCII 76) turn off the LED:
      digitalWrite(LED_BUILTIN, LOW);
    }
  }
}

