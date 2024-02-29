/**
 * Tecnologias de Interface, Winter 2023
 * Universidade de Coimbra
 * MSc in Design and Multimedia
 *
 * Week 4 — Exercice 3
 * Exercise 3: Control Processing application elements using arduino
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
  fullScreen();
  rectMode (CENTER);

  dist = width/(states.length+1);

  // TODO: 
  // init a serial communication 
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
  // TODO: 
  // handle data from serial communication
  
}
