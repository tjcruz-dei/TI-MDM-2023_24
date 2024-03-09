/**
 * Tecnologias de Interface
 * Universidade de Coimbra
 * MSc in Design and Multimedia
 *
 * Author: Tiago Cruz
 * Week 5
 * LDR Reading - example
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
  float voltage = sensorValue * (5.0 / 1023.0);
 
 // print out the value you read - comment out one of them if using the serial plotter
  Serial.println(voltage);
  Serial.println(sensorValue);
}
