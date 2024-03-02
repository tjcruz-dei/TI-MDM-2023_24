/**
* Tecnologias de Interface
* Universidade de Coimbra
* MSc in Design and Multimedia
*
* Week 4
* Exercise 1
* 
* @since:   02-03-2024     
*/

const byte REDPIN=3;
const byte GREENPIN=4;

//these could be replaced by a direct reading of the LED pin state
boolean statusG=false;
boolean statusR=false;

char incomingByte;

void setup() {
  // Initialize serial data rate (bits per second) and wait for port to open
  Serial.begin(9600);

  // wait for serial port to connect. Needed for native USB port only (Leonardo only)
  while (!Serial) {
    ;
  }

  pinMode(REDPIN, OUTPUT);
  pinMode(GREENPIN, OUTPUT);
}

void loop() {
  if (Serial.available()) {
    incomingByte = (char)Serial.read();
    if (incomingByte == 'R') {
      statusR=!statusR;
      digitalWrite(REDPIN, statusR);
    }
    if (incomingByte == 'G') {
      statusG=!statusG;
      digitalWrite(GREENPIN,statusG );
    }
  }
}