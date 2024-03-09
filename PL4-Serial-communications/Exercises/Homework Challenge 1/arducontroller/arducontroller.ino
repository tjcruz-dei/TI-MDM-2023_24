/**
 * Tecnologias de Interface
 * Universidade de Coimbra
 * MSc in Design and Multimedia
 *
 * Author: Tiago Cruz
 * Week 4
 * Homework challenge 1
 *
 * @since:   02–03–2024
 */
 
long timestamp;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  pinMode(8,INPUT_PULLUP);
  pinMode(9,INPUT_PULLUP);
}

void loop() {
  if (millis()-timestamp>50) {
    if (!digitalRead(8)) Serial.write('R');
    if (!digitalRead(9)) Serial.write('L');
  }
}