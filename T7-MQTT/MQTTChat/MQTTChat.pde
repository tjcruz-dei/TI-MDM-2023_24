import mqtt.*;
import controlP5.*;
String ID="01ABC";
String Username="TJC";
String textValue = "";

import controlP5.*;

ControlP5 cp5;
Textarea myTextarea;
MQTTClient client;

void setup() {
  size(700,400);
  
  client = new MQTTClient(this);
  client.connect("mqtt://public:public@public.cloud.shiftr.io",ID+String.valueOf(System.currentTimeMillis()));
  client.subscribe("/TI/chatchannel");

  cp5 = new ControlP5(this);
  
  cp5.addTextfield("Message")
     .setPosition(50,20)
     .setSize(400,40)
     .setFont(createFont("arial",12))
     .setAutoClear(true)
     ;
     
  myTextarea = cp5.addTextarea("txt")
                  .setPosition(100,100)
                  .setSize(500,250)
                  .setFont(createFont("arial",12))
                  .setLineHeight(14)
                  .setColor(color(128))
                  .setColorBackground(color(255,100))
                  .setColorForeground(color(255,100));
                  ;
  myTextarea.setText("");
  
}

void messageReceived(String topic, byte[] payload) {
  println("new message: " + topic + " - " + new String(payload));
  myTextarea.append(new String(payload)+"\n");
}

public void Message(String theText) {
  // automatically receives results from controller input
  client.publish("/TI/chatchannel", Username+":"+theText);
}

void draw() {
  background(0);
}
