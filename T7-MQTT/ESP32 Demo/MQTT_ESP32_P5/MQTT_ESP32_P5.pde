import mqtt.*;
import controlP5.*;
String DeviceID="01ABC";
String ID="12345";

ControlP5 cp5;

int myColorBackground = color(0,0,0);

Chart myChart;

MQTTClient client;

void setup() {
  size(450,300);
  smooth();
  noStroke();
  
  client = new MQTTClient(this);
  client.connect("mqtt://public:public@public.cloud.shiftr.io",ID+String.valueOf(System.currentTimeMillis()));
  client.subscribe("sensor/TX_01ABC");
  
  cp5 = new ControlP5(this);
     
   cp5.addToggle("D15")
     .setPosition(350,80)
     .setSize(50,20)
     ;
               
  myChart = cp5.addChart("Telemetry")
               .setPosition(130, 150)
               .setSize(200, 100)
               .setRange(0, 2000)
               .setView(Chart.LINE) // use Chart.LINE, Chart.PIE, Chart.AREA, Chart.BAR_CENTERED
               .setStrokeWeight(1.5)
               .setColorCaptionLabel(color(255,255,255))
               ;

  myChart.addDataSet("incoming");
  myChart.setData("incoming", new float[100]);
  
}

void draw() {
  background(0);
}
 

void D15(boolean theFlag) {
  client.publish("sensor/D4_01ABC", str(theFlag));
}

void messageReceived(String topic, byte[] payload) {
  println("new message: " + topic + " - " + new String(payload));
  myChart.push("incoming", float(new String(payload)));
  
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
                        * Math.random()); 
  
            // add Character one by one in end of sb 
            sb.append(AlphaNumericString 
                          .charAt(index)); 
        } 
  
        return sb.toString(); 
  } 
