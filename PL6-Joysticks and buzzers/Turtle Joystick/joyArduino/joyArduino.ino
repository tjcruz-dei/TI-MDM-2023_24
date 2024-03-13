 /* MSc in Design and Multimedia
 *
 * Author: Tiago Cruz
 * Week 6
 * turtle control - joystick handling
 *
 * @since:   02–03–2024
 */

#define ButtonX 0
#define ButtonY 1
long ellapsed;
int maxX=0,maxY=0,minX=1024,minY=1024;

void setup() {    
   Serial.begin (9600);
   ellapsed=millis();

   //Serial.println("Callibrating for still position");
   //Calibração – máximos e mínimos em repouso
   while ((millis()-ellapsed)<10000){
   // X e Y are local
     int X = analogRead(ButtonX); 
     int Y = analogRead(ButtonY); 
     if (X>maxX) maxX=X;
     if (X<minX) minX=X;
     if (Y>maxY) maxY=Y;
     if (Y<minY) minY=Y;
   }
   //Serial.println("End of Callibration");
 } 

void loop() {   
   if (millis()-ellapsed>100){  
     int X = analogRead(ButtonX); 
     int Y = analogRead(ButtonY); 
     int XSend=0, YSend=0;

     ellapsed=millis();
     
     if ((X<minX) || (X>maxX))
      XSend=X-512;
     
     if ((Y<minY) || (Y>maxY)) 
      YSend=Y-512;
   
     Serial.println(String(XSend)+":"+String(YSend));
   }
}
