int LED_PIN_A = LED_BUILTIN;
int LED_PIN_B = 12;

bool active = LOW; // variable that will change


void setup() {
  // initialize leds pins as an output.
  pinMode(LED_PIN_A, OUTPUT);
  pinMode(LED_PIN_B, OUTPUT);

 // init Serial communication
  Serial.begin(9800);
  while(!Serial) {
    ;
  }
}

void loop() {
  // read data from website
  while (Serial.available()) {
    char incomingByte = (char)Serial.read();
     if (incomingByte == 'H') {
      active = HIGH;
    } else if (incomingByte == 'L') {
      active = LOW;
    }
  }

  // update led state
  digitalWrite(LED_PIN_A, active);
  digitalWrite(LED_PIN_B, !active);

  // write the state of pins
  Serial.println ((String)"s:"+active+"|"+!active);
  delay(1000);

}
