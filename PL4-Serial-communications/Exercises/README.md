# Arduino & Friends: Serial Communications(Week 4)


## Exercise 1

<img src="circuit1.png"  alt="Circuit assembly used on this Exercise class" width="60%" height="auto">

1-Make a simple circuit with two LEDs – red and green, connected to digital pins 3 and 4, respectively.

2-Write a program allows you to select them:

-When you enter a “R” via serial monitor, the red LED must switch on. If you enter the 	same character another time, it must switch off.

-When you enter a “G” via serial monitor, the green LED must switch on. If you enter the same character another time, it must switch off.

See [Week4 Exercise 1](https://github.com/tjcruz-dei/TI-MDM-2023_24/tree/main/PL4-Serial-communications/Exercises/Exercise1/Exercise1.ino)

## Exercise 2

(Same circuit and program used for byte oriented reads: [https://github.com/tjcruz-dei/TI-MDM-2023_24/blob/main/PL4-Serial-communications/p5/arduino/read/Week4-Serial-Read-byte-oriented-Example/Week4-Serial-Read-byte-oriented-Example.ino)
]

Make a Processing program that draws a black circle with 100px radius, centered within a 500x500px window.

When you click the circle make it change its color between black and red, alternately.

Also, make the program write the “H” and “L” strings alternately to the serial port.

Program the Arduino to control the LED on pin 13 (the embedded LED), using the information sent via serial port.

Processing code [Week4 Exercise 2](https://github.com/tjcruz-dei/TI-MDM-2023_24/tree/main/PL4-Serial-communications/Exercises/Exercise2/Exercise2.pde)


## Homework Challenge 1

Assemble an Arduino circuit with two pushbuttons - the circuit is quite simple, using two buttons wired to pins 8 and 9.

Create a program in Processing with a 1024x1024 window

The Arduino buttons must control the displacement of a circle which is continuously moving 
forward (so, the buttons will basically steer left and right)

Code [Homework Challenge 1](https://github.com/tjcruz-dei/TI-MDM-2023_24/tree/main/PL4-Serial-communications/Exercises/Homework_Challenge)
