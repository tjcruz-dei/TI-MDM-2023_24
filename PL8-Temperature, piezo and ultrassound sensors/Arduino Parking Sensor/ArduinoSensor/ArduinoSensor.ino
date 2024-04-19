 /* MSc in Design and Multimedia
 *
 * Week 8
 * HC-SR04 Parking sensor
 *
 * HC-SR04 Ping distance sensor:
 * VCC to arduino 5v,  GND to arduino GND
 * Echo to Arduino pin 7, Trig to Arduino pin 8
 */

#define echoPin 7 // Echo Pin
#define trigPin 8 // Trigger Pin
#define LEDPin 13 // Onboard LED

boolean flag=false;
int ooRange=0;

int cnt=0;
int acum=0;
int readVect[10];

int timeBase=50;
long lastEvent=0,eventCount=0;

int maximumRange = 200; // Maximum range needed
int minimumRange = 0; // Minimum range needed
int duration, distance; // Duration used to calculate distance

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
   duration = pulseIn(echoPin, HIGH,50000);
   
   //Calculate the distance (in cm) based on the speed of sound.
   distance = (duration*.0343)/2;
 
   if ((distance >= maximumRange) || (distance <= minimumRange)){
      /* Out of Range */
      digitalWrite(LEDPin, HIGH);
      ooRange=ooRange+1;
   }
   else {
       /* Send the distance to the computer using Serial protocol, and
       turn LED OFF to indicate successful reading. */
       ooRange=0;
       updateReadings(distance);
      
       if (flag) Serial.println(acum/10);
       digitalWrite(LEDPin, LOW); 
       
       if (cnt==9) {
          cnt=0;
          flag=true;
       }
       else cnt=cnt+1;
  }

  /* Send a negative number to computer and Turn LED ON 
  to indicate "out of range" */
  if (ooRange>=15) {
    cnt=0;
    Serial.println("-1");
  } else if (flag) {
    toneGen((acum/150));
  }

   updateTimeCounter();
   //Delay 50ms before next reading.
   delay(50); 
}

void updateTimeCounter(){
 long currEvent=millis();
 if (((currEvent-lastEvent)/timeBase)>=1) {
    lastEvent=currEvent;
    eventCount=eventCount+1;
 }
}

void toneGen(long events) {
  if ((events==0) || ((eventCount%events)==0)) {
      //noTone(9);
      tone(9,235,40);
  }
}

void updateReadings(int distance) {
 acum=acum-readVect[cnt];
 readVect[cnt]=distance;
 acum=acum+distance;
}

 
