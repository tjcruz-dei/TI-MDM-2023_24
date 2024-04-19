 /* MSc in Design and Multimedia
 *
 * Week 8
 * HC-SR04 Parking sensor - processing side
 * UPDATE THE SERIAL PORT DEVICE TO MATCH YOUR SPECIFIC CASE!!!!!
 *
 */
 
import processing.serial.*;

Serial myPort;
String readStr=null;
String portName=null;

int cx,cy;
float dist=200;

void setup(){
  size(640,480);
  cx=width/2;
  cy=height/2;
  //dist=200;
  
  printArray(Serial.list());
  portName=Serial.list()[1];
  myPort = new Serial(this, portName, 9600); 
  myPort.bufferUntil('\n'); 
}

void draw() {
 background(255);
 noFill(); 
 strokeWeight(10);
 
 for (int radius=0;radius<10;radius=radius+1) {
   int step=int(dist/20);
   if (radius<=step) stroke(255-(step*25),step*25,0);
   else stroke (0);
   arc(cx,cy,radius*40,radius*40,PI/6,PI-PI/6);
 }  
 fill(255,0,0);
   
 textAlign(CENTER,CENTER);
 textSize(64);
 text(str(int(dist))+"cm", cx, cy/2); 
}

void serialEvent(Serial myPort) {
  //put the incoming data into a String - 
  //the '\n' is our end delimiter indicating the end of a complete packet
  readStr = myPort.readStringUntil('\n');
 
  if (readStr!=null) {
    //Important, because it may fail on the first reads
   int distRead= int(trim(readStr));   
   if (distRead==-1) dist=200;
   else dist=distRead;
  }
  
}
