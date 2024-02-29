/**
* Tecnologias de Interface, Winter 2023
* Universidade de Coimbra
* MSc in Design and Multimedia
*
* Week 4
* Exercise 3: Control Processing application elements using arduino
* 
* @authors: Sérgio M. Rebelo, Ana Cláudia Rodrigues, and Tiago Cruz
* @since:   24–02–2023      
*/

const int BT_PIN = 2;             // pushbutton pin
const int LED_PIN_1 = LED_BUILTIN;  // led pin 1
const int LED_PIN_2 = 12;  // led pin 1

int btState;                 // variable for reading the pushbutton status
int ledState = HIGH;         // current state of the led
int previousLedState = LOW;  // previous state of the led

// time variables
long lastDebounceTime = 0;  // the last time the output pin was toggled
long debounceDelay = 50;    // the bounce time;


void setup() {
  // init pins
  pinMode(LED_PIN_1, OUTPUT);
   pinMode(LED_PIN_2, OUTPUT);
  //configure pin 2 as an input and enable the internal pull-up resistor
  pinMode(BT_PIN, INPUT_PULLUP);

  // set initial LED state
  digitalWrite(LED_PIN_1, ledState);
  digitalWrite(LED_PIN_2, !ledState);

  // init Serial communication
  Serial.begin(9600);
  while(!Serial) {
    ;
  }
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

  // turn on the first led when push the bt
  // invert signal gathered by bt
  digitalWrite(LED_PIN_1, !ledState);
  // turn off the second led when push the bt
  digitalWrite(LED_PIN_2, ledState);

  // save the reading.
  previousLedState = reading;

  // TODO: sent the data to serial
}
