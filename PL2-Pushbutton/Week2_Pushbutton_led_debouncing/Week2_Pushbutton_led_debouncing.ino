/**
* Tecnologias de Interface
* Universidade de Coimbra
* MSc in Design and Multimedia
*
* Week 2
* Control led with a pushbutton (with debouncing)
* 
* @since:   16–02–2024   
* @based:   https://www.arduino.cc/en/Tutorial/BuiltInExamples/Debounce
*/

const int BT_PIN = 2;             // pushbutton pin
const int LED_PIN = LED_BUILTIN;  // led pin

int btState;                 // variable for reading the pushbutton status
int ledState = HIGH;         // current state of the led
int previousLedState = LOW;  // previous state of the led

// time variables
long lastDebounceTime = 0;  // the last time the output pin was toggled
long debounceDelay = 50;    // the bounce time;


void setup() {
  // init pins
  pinMode(LED_PIN, OUTPUT);
  pinMode(BT_PIN, INPUT);

  // set initial LED state
  digitalWrite(LED_PIN, ledState);
}

void loop() {
  // read the state of pushbutton pin
  int reading = digitalRead(BT_PIN);

  // check to see if you just pressed the button
  // (i.e. the input went from LOW to HIGH), and you are waited
  // long enough since the last press to ignore any noise:.

  // If the switch changed, due to noise or pressing:
  if (reading != previousLedState) {
    // reset the debouncing timer
    lastDebounceTime = millis();
  }

  if ((millis() - lastDebounceTime) > debounceDelay) {
    // whatever the reading is at, it's been there for longer than the debounce
    // delay, so take it as the actual current state:

    // if the button state has changed:
    if (reading != btState) {
      btState = reading;

      // only toggle the LED if the new button state is HIGH
      if (btState == HIGH) {
        ledState = !ledState;
      }
    }
  }

  // set the LED using the state of the button
  // turn off and on the led by clicking
  digitalWrite(LED_PIN, ledState);

  // turn on the led by pushing the bt
  // digitalWrite(LED_PIN, btState);

  // save the reading.
  previousLedState = reading;
}
