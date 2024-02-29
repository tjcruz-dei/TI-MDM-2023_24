/**
 * Tecnologias de Interface, Winter 2023
 * Universidade de Coimbra
 * MSc in Design and Multimedia
 *
 * Week 4 — Exercice 3
 * Control the style of Processing application using arduino (event-oriented)
 *
 * @authors: Sérgio M. Rebelo, Ana Cláudia Rodrigues, and Tiago Cruz
 * @since:   03–03–2023
 * @based:   https://processing.org/reference/libraries/serial/Serial_readString_.html
 */


import processing.serial.*;
Serial port;

int[] states = {0, 0, 0};
float dist;
String value;

void setup () {
  fullScreen(2);
  rectMode (CENTER);

  dist = width/(states.length+1);

  // printArray(Serial.list());

  String portName = Serial.list()[5];
  port = new Serial (this, portName, 9600);
  port.bufferUntil('\n');
  port.clear();
}

void draw() {
  background (0);
  for (int i=0; i<states.length; i++) {
    color c = states[i] == 1 ? color (255, 255, 0) : color(255);
    fill(c);
    rect(i*dist+dist, height/2, 100, 100);
  }
}

void serialEvent (Serial myPort) {
  try {
    value = myPort.readStringUntil('\n');
    // Important, because it may fail on the first reads
    if (value!=null) {
      String[] list = split(value, ':');
      if (list[0].indexOf("Chan")>=0) {
        if (list.length >=2) {
          int index = Character.getNumericValue(list[0].charAt(list[0].length()-1));
          index = index-1;
          states[index] = Character.getNumericValue(list[1].charAt(0));

        }
      }
    }
  }
  catch (Exception e) {
    e.printStackTrace();
  }
}
