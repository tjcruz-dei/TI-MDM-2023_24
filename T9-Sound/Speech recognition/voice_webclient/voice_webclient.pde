/*
  Simple WebSocketServer example that can receive voice transcripts from Chrome
  Requires installing the websockets library
 */

import websockets.*;

WebsocketServer socket;
int now;

void setup() {
  socket = new WebsocketServer(this,8080,"/p5websocket");
  now=millis();
}

void draw() {
  if(millis()>now+5000){
    socket.sendMessage("Server is alive");
    now=millis();
  }
  
}

void webSocketServerEvent(String msg){
 println(msg);
 if (msg.contains("hello")) println("Yay!");
}
