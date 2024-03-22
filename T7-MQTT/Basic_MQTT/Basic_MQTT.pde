import mqtt.*;
MQTTClient client;
String ID="Bananablaster1K";
// CHANGE THE ID FOR YOUR UNIQUE CLIENT

void setup() {
  client = new MQTTClient(this);
  //First parameter is the server, the second is an unique client ID string
  client.connect("mqtt://public:public@public.cloud.shiftr.io",ID+String.valueOf(System.currentTimeMillis()));
  client.subscribe("/example");
}

void draw() {}

void keyPressed() {
  client.publish("/hello", "world");
}

void messageReceived(String topic, byte[] payload) {
  println("new message: " + topic + " - " + new String(payload));
}
