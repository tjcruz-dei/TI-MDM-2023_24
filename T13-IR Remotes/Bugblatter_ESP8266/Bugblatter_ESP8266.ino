/***************************************************
//ESP8266 Domestic Guerrilla Tool for IT Remotes 
//aka, the Ravenous Bugblatter Beast of IR
 ****************************************************/

//Mandatory libraries
#include <Arduino.h>
#include <IRremoteESP8266.h>
#include <IRsend.h>

#include <ESP8266WiFi.h>
#include "Adafruit_MQTT.h"
#include "Adafruit_MQTT_Client.h"

#define ClientID "01ABC";

const uint16_t kIrLed = 4;  // ESP8266 GPIO pin to use. Recommended: 4 (D2).

IRsend irsend(kIrLed);  // Set the GPIO to be used to sending the message.

//Topics
const char CMDTopic[]="/TV";
const char publishTopic[]="/bugblatter";


/************************* WiFi Access Point *********************************/

#define WLAN_SSID       "SSID"
#define WLAN_PASS       "password"

/************************* Adafruit.io Setup *********************************/

#define AIO_SERVER      "192.168.1.85"
#define AIO_SERVERPORT  1883                   // 8883 for MQTTS

//User credentials not employed

#define AIO_USERNAME    "...your AIO username (see https://accounts.adafruit.com)..."
#define AIO_KEY         "...your AIO key..."

/************ Global State (you don't need to change this!) ******************/

// WiFiFlientSecure for SSL/TLS support
WiFiClient client;

// Setup the MQTT client class by passing in the WiFi client and MQTT server and login details.
Adafruit_MQTT_Client mqtt(&client, AIO_SERVER, AIO_SERVERPORT, AIO_USERNAME, AIO_KEY);

// io.adafruit.com SHA1 fingerprint (not needed here)
const char* fingerprint = "F0 D6 DF 20 B0 5B AB 41 AA D9 9D 29 EC 30 A4 E2 4E 2C 27 F8";

/****************************** Feeds ***************************************/

// Setup a feed called 'test' for publishing.
// Notice MQTT paths for AIO follow the form: <username>/feeds/<feedname>
Adafruit_MQTT_Publish test = Adafruit_MQTT_Publish(&mqtt,publishTopic);

/*************************** Subscriptions **********************************/

// Setup a feeds for subscribing to RGB values
Adafruit_MQTT_Subscribe CMD_feed = Adafruit_MQTT_Subscribe(&mqtt, CMDTopic);

/******************** Subscription Callbacks  *******************************/

void CMDCallback(char *data, uint16_t len) {
  Serial.println("Message received:"+String(data));

  unsigned long nReadHex= strtoul(data, NULL, 16);
  //irsend.sendNEC(0x2fd48b7UL);
  //irsend.sendNEC(nReadHex);

  irsend.sendSony(nReadHex, 12,3); // Sony TV power code - 3 repeats, 12 bits
  Serial.print("Received code via MQTT:");
  Serial.println(nReadHex,HEX);
}


// Bug workaround for Arduino 1.6.6, it seems to need a function declaration
// for some reason (only affects ESP8266, likely an arduino-builder bug).
void MQTT_connect();
void verifyFingerprint();

void setup() {

  pinMode(D0,OUTPUT);
  
  Serial.begin(115200);
  delay(10);

  Serial.println(F("\nRavenous Bugblatter Beast of IR, v0.1 "));

  // Connect to WiFi access point.
  Serial.println(); Serial.println();
  Serial.print("Connecting to ");
  Serial.println(WLAN_SSID);

  delay(1000);

  WiFi.begin(WLAN_SSID, WLAN_PASS);
  delay(2000);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println();

  Serial.println("WiFi connected");
  Serial.println("IP address: "); Serial.println(WiFi.localIP());

  //associate callbacks
  CMD_feed.setCallback(CMDCallback);
  
  // Setup MQTT subscription for the feed.
  mqtt.subscribe(&CMD_feed);

  irsend.begin();
  #if ESP8266
  Serial.begin(115200, SERIAL_8N1, SERIAL_TX_ONLY);
  #else  // ESP8266
  Serial.begin(115200, SERIAL_8N1);
  #endif  // ESP8266
}

uint32_t x=0;

void loop() {
  // Ensure the connection to the MQTT server is alive (this will make the first
  // connection and automatically reconnect when disconnected).  See the MQTT_connect
  // function definition further below.
  MQTT_connect();

  mqtt.processPackets(500);

  //Publish test via serial
  if (Serial.available()>0) {
    String data=Serial.readStringUntil('\n');
    // Now we can publish stuff!
    Serial.print(F("\nSending val to test feed..."));
    if (! test.publish((char*) data.c_str())) {
      Serial.println(F("Failed"));
    } else {
      Serial.println(F("OK!"));
    }
  }

  // wait some time to avoid rate limit
  delay(500);

}

// Function to connect and reconnect as necessary to the MQTT server.
// Should be called in the loop function and it will take care if connecting.
void MQTT_connect() {
  int8_t ret;

  // Stop if already connected.
  if (mqtt.connected()) {
    return;
  }

  Serial.print("Connecting to MQTT... ");

  uint8_t retries = 3;
  while ((ret = mqtt.connect()) != 0) { // connect will return 0 for connected
       Serial.println(mqtt.connectErrorString(ret));
       Serial.println("Retrying MQTT connection in 5 seconds...");
       mqtt.disconnect();
       delay(5000);  // wait 5 seconds
       retries--;
       if (retries == 0) {
         Serial.println("Engaging WDT");
         // basically die and wait for WDT to reset me
         while (1);
       }
  }

  Serial.println("MQTT Connected!");
}
