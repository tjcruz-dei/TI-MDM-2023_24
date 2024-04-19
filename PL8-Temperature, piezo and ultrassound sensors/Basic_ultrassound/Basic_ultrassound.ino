 /* MSc in Design and Multimedia
 *
 * Week 8
 * Basic HC-SR04 Demo
 *
 */

#define echoPin 7 // Echo Pin
#define trigPin 8 // Trigger Pin
#define LEDPin 13

long duration; 
float distance; // Duration used to calculate distance

void setup() {
 Serial.begin (9600);
 pinMode(trigPin, OUTPUT);
 pinMode(echoPin, INPUT);
 pinMode(LEDPin, OUTPUT); // Use LED indicator (if required)
}

void loop() {

/* The following trigPin/echoPin cycle is used to determine the
 distance of the nearest object by bouncing soundwaves off of it. */ 

 digitalWrite(trigPin, LOW); 
 delayMicroseconds(2); 

 digitalWrite(trigPin, HIGH);
 delayMicroseconds(10); 

 digitalWrite(trigPin, LOW);
 duration = pulseIn(echoPin, HIGH,200000);

 //Calculate the distance (in cm) based on the speed of sound.
 distance = (duration*0.034)/2; 

Serial.println(distance);

 //Delay 50ms before next reading.
 delay(50);
}




