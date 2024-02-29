/**
* Tecnologias de Interface
* Universidade de Coimbra
* MSc in Design and Multimedia
*
* Week 2
* Control led with a pushbutton
* 
* @since:   16–02–2024  
*/

const int BT_PIN = 2; // pushbutton pin
const int LED_PIN = 13;

int state = 0; // variable for reading the pushbutton status

void setup() {
  // init pins
  pinMode (LED_PIN, OUTPUT);
  pinMode (BT_PIN, INPUT);
}

void loop() {
  // read the state of pushbutton pin
  state = digitalRead(BT_PIN);
  // check if the pushbutton is pressed
  if (state == HIGH) {
    // turn on led
    digitalWrite(LED_PIN, HIGH);
  } else {  
    // turn off led
    digitalWrite (LED_PIN, LOW);
  }
}
