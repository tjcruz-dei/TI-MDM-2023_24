/*
    MQTT Arduino->Processing ADXL345 client
    Adapted from the 3D Visualization Example by Dejan, https://howtomechatronics.com, with added MQTT support
*/

import mqtt.*;

String ID="CLIXsX65"; //CHANGE TO HAVE YOUR OWN ID 

MQTTClient client;

String data="";
float roll, pitch, rollF, pitchF;

void setup() {
  randomSeed(millis());
  size (960, 640, P3D);
  
  client = new MQTTClient(this);
  client.connect("mqtt://broker.hivemq.com",ID);
  client.subscribe("/roll");
  client.subscribe("/pitch");
  
  ID=ID+getAlphaNumericString(15);

  println(ID);
}

void draw() {
  translate(width/2, height/2, 0);
  background(10);

  pushMatrix();
  // Apply 3D rotations  
  rotateX(radians(rollF));
  rotateZ(radians(pitchF));
  
  // Slab
  textSize(30);  
  fill(0, 170, 150);
  box (400, 45, 200); // Draw box
  textSize(30);
  fill(255, 255, 255);
  text("Accelerometer demo", -140, 10, 105);
  popMatrix();
  
  textSize(32);
  text("Roll:" + int(roll) + "     Pitch:" + int(pitch), -150, 270);
  
}


void messageReceived(String topic, byte[] payload) {
//  println("new message: " + topic + " - " + new String(payload));

  String value=new String(payload);
  if (topic.equals("/roll")) roll = float(value);
  if (topic.equals("/pitch")) pitch = float(value)-1.5;
  
  //Low pass filter
  rollF = 0.94 * rollF + 0.06 * roll;
  pitchF = 0.94 * pitchF + 0.06 * pitch;
  
}

String getAlphaNumericString(int n) 
    { 
  
        // chose a Character random from this String 
        String AlphaNumericString = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
                                    + "0123456789"
                                    + "abcdefghijklmnopqrstuvxyz"; 
  
        // create StringBuffer size of AlphaNumericString 
        StringBuilder sb = new StringBuilder(n); 
  
        for (int i = 0; i < n; i++) { 
  
            // generate a random number between 
            // 0 to AlphaNumericString variable length 
            int index 
                = (int)(AlphaNumericString.length() 
                        * random(1)); 
  
            // add Character one by one in end of sb 
            sb.append(AlphaNumericString 
                          .charAt(index)); 
        } 
  
        return sb.toString(); 
  } 
