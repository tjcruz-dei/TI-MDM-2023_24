/*
    MQTT telemetry pusher
*/

import processing.serial.*;
import mqtt.*;

String ID="PROF"; //CHANGE TO HAVE YOUR OWN ID 

Serial myPort;
MQTTClient client;

String data="";
float roll, pitch;

void setup() {
  String[] portlist=Serial.list();
  myPort = new Serial(this, portlist[1], 9600); // starts the serial communication
  myPort.bufferUntil('\n');
  
  client = new MQTTClient(this);
  client.connect("mqtt://broker.hivemq.com",ID);
  frameRate(15);
}

void draw() {
  client.publish("/roll", str(roll));
  client.publish("/pitch", str(pitch));
}

// Read data from the Serial Port
void serialEvent (Serial myPort) { 
  // reads the data from the Serial Port up to the character '.' and puts it into the String variable "data".
  data = myPort.readStringUntil('\n');

  // if you got any bytes other than the linefeed:
  if (data != null) {
    data = trim(data);
    // split the string at "/"
    String items[] = split(data, '/');
    if (items.length > 1) {

      //--- Roll,Pitch in degrees
      roll = float(items[0]);
      pitch = float(items[1]);
    }
  }
}

void messageReceived(String topic, byte[] payload) {
  println("new message: " + topic + " - " + new String(payload));
}
