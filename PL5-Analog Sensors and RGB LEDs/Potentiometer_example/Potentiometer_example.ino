/**
 * Tecnologias de Interface
 * Universidade de Coimbra
 * MSc in Design and Multimedia
 *
 * Author: Tiago Cruz
 * Week 5
 * Potentiometer Example - this code is 99% equal to the basic LDR code example
 *
 * @since:   08–03–2024
 */

void setup() {
  Serial.begin(9600);
}

void loop() {
  // read the input on analog pin 0:
  int sensorValue = analogRead(A0);

  // Convert the analog reading (which goes from 0 - 1023) 
  // to a voltage (0 - 5V):
  float voltage = sensorValue * (5.0 / 1024.0);
 
 // print out the value you read:
  Serial.println(voltage);
}
