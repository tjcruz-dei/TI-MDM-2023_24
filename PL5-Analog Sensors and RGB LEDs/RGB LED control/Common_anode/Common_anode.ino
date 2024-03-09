/**
 * Tecnologias de Interface
 * Universidade de Coimbra
 * MSc in Design and Multimedia
 *
 * Author: Tiago Cruz
 * Week 5
 * RGB LED control - common anode example
 *
 * @since:   02–03–2024
 */

void setup() {
  for (int pin=8;pin<11;pin++) {
    pinMode(pin,OUTPUT);
    digitalWrite(pin,HIGH);
  }
}

void loop() {
  for (int pin=8;pin<11;pin++) {
    digitalWrite(pin,LOW);
    delay(1000);
    digitalWrite(pin,HIGH);
    delay(1000);
  }
}

