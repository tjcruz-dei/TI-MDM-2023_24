#include <Wire.h>
#include <Adafruit_Sensor.h>
#include <Adafruit_ADXL345_U.h>
#include <ESP8266WiFi.h>
#include "Adafruit_MQTT.h"
#include "Adafruit_MQTT_Client.h"

//D1 SCL
//D2 SCA
int ADXL345 = 0x53; // The ADXL345 sensor I2C address

float X_out, Y_out, Z_out;  // Outputs
float roll,pitch,rollF,pitchF=0;

#define ChanID "01ABC";

/************************* WiFi Access Point *********************************/

//Configurations for your wifi network
#define WLAN_SSID       ""
#define WLAN_PASS       ""


/************************* Adafruit.io Setup *********************************/

#define AIO_SERVER      "broker.hivemq.com"
#define AIO_SERVERPORT  1883                   // 8883 for MQTTS

//User credentials not employed
#define AIO_USERNAME    ""
#define AIO_KEY         ""

/************ Global State (you don't need to change this!) ******************/

// WiFiFlientSecure for SSL/TLS support
WiFiClient client;

// Setup the MQTT client class by passing in the WiFi client and MQTT server and login details.
Adafruit_MQTT_Client mqtt(&client, AIO_SERVER, AIO_SERVERPORT, AIO_USERNAME, AIO_KEY);

// io.adafruit.com SHA1 fingerprint (not needed here)
const char* fingerprint = "F0 D6 DF 20 B0 5B AB 41 AA D9 9D 29 EC 30 A4 E2 4E 2C 27 F8";

const char publishTopic_pitch[]="/pitch";
const char publishTopic_roll[]="/roll";

Adafruit_MQTT_Publish pitchpub = Adafruit_MQTT_Publish(&mqtt,publishTopic_pitch);
Adafruit_MQTT_Publish rollpub = Adafruit_MQTT_Publish(&mqtt,publishTopic_roll);

// Bug workaround for Arduino 1.6.6, it seems to need a function declaration
// for some reason (only affects ESP8266, likely an arduino-builder bug).
void MQTT_connect();
void verifyFingerprint();

/* Assign a unique ID to this sensor at the same time */
Adafruit_ADXL345_Unified accel = Adafruit_ADXL345_Unified(12345);
 
void displaySensorDetails(void)
{
 sensor_t sensor;
 accel.getSensor(&sensor);
 Serial.println("------------------------------------");
 Serial.print ("Sensor: "); Serial.println(sensor.name);
 Serial.print ("Driver Ver: "); Serial.println(sensor.version);
 Serial.print ("Unique ID: "); Serial.println(sensor.sensor_id);
 Serial.print ("Max Value: "); Serial.print(sensor.max_value); Serial.println(" m/s^2");
 Serial.print ("Min Value: "); Serial.print(sensor.min_value); Serial.println(" m/s^2");
 Serial.print ("Resolution: "); Serial.print(sensor.resolution); Serial.println(" m/s^2"); 
 Serial.println("------------------------------------");
 Serial.println("");
 delay(500);
}
 
void displayDataRate(void)
{
 Serial.print ("Data Rate: "); 
 
 switch(accel.getDataRate())
 {
 case ADXL345_DATARATE_3200_HZ:
 Serial.print ("3200 "); 
 break;
 case ADXL345_DATARATE_1600_HZ:
 Serial.print ("1600 "); 
 break;
 case ADXL345_DATARATE_800_HZ:
 Serial.print ("800 "); 
 break;
 case ADXL345_DATARATE_400_HZ:
 Serial.print ("400 "); 
 break;
 case ADXL345_DATARATE_200_HZ:
 Serial.print ("200 "); 
 break;
 case ADXL345_DATARATE_100_HZ:
 Serial.print ("100 "); 
 break;
 case ADXL345_DATARATE_50_HZ:
 Serial.print ("50 "); 
 break;
 case ADXL345_DATARATE_25_HZ:
 Serial.print ("25 "); 
 break;
 case ADXL345_DATARATE_12_5_HZ:
 Serial.print ("12.5 "); 
 break;
 case ADXL345_DATARATE_6_25HZ:
 Serial.print ("6.25 "); 
 break;
 case ADXL345_DATARATE_3_13_HZ:
 Serial.print ("3.13 "); 
 break;
 case ADXL345_DATARATE_1_56_HZ:
 Serial.print ("1.56 "); 
 break;
 case ADXL345_DATARATE_0_78_HZ:
 Serial.print ("0.78 "); 
 break;
 case ADXL345_DATARATE_0_39_HZ:
 Serial.print ("0.39 "); 
 break;
 case ADXL345_DATARATE_0_20_HZ:
 Serial.print ("0.20 "); 
 break;
 case ADXL345_DATARATE_0_10_HZ:
 Serial.print ("0.10 "); 
 break;
 default:
 Serial.print ("???? "); 
 break;
 } 
 Serial.println(" Hz"); 
}
 
void displayRange(void)
{
 Serial.print ("Range: +/- "); 
 
 switch(accel.getRange())
 {
 case ADXL345_RANGE_16_G:
 Serial.print ("16 "); 
 break;
 case ADXL345_RANGE_8_G:
 Serial.print ("8 "); 
 break;
 case ADXL345_RANGE_4_G:
 Serial.print ("4 "); 
 break;
 case ADXL345_RANGE_2_G:
 Serial.print ("2 "); 
 break;
 default:
 Serial.print ("?? "); 
 break;
 } 
 Serial.println(" g"); 
}
 
void setup(void) 
{
 Serial.begin(9600);
 Serial.println("Accelerometer Test"); Serial.println("");
 
 /* Initialise the sensor */
 if(!accel.begin())
 {
 /* There was a problem detecting the ADXL345 ... check your connections */
 Serial.println("Ooops, no ADXL345 detected ... Check your wiring!");
 while(1);
 }
 
 /* Set the range to whatever is appropriate for your project */
 accel.setRange(ADXL345_RANGE_16_G);
 // displaySetRange(ADXL345_RANGE_8_G);
 // displaySetRange(ADXL345_RANGE_4_G);
 // displaySetRange(ADXL345_RANGE_2_G);
 
 /* Display some basic information on this sensor */
 displaySensorDetails();
 
 /* Display additional settings (outside the scope of sensor_t) */
 displayDataRate();
 displayRange();
 Serial.println("");

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
}
 
void loop(void) 
{
 /* Get a new sensor event */ 
 sensors_event_t event; 
 accel.getEvent(&event);
 
 /* Display the results (acceleration is measured in m/s^2) */
 Serial.print("X: "); Serial.print(event.acceleration.x); Serial.print(" ");
 Serial.print("Y: "); Serial.print(event.acceleration.y); Serial.print(" ");
 Serial.print("Z: "); Serial.print(event.acceleration.z); Serial.print(" ");Serial.println("m/s^2 ");

  float roll = atan(event.acceleration.y / sqrt(pow(event.acceleration.x, 2) + pow(event.acceleration.z, 2))) * 180 / PI;
  float pitch = atan(event.acceleration.x / sqrt(pow(event.acceleration.y, 2) + pow(event.acceleration.z, 2))) * 180 / PI;
  Serial.println(roll);
  Serial.println(pitch);


   String STRroll=String(roll);
  String STRpitch=String(pitch);
   
    if (! pitchpub.publish((char*) STRpitch.c_str())) {
      Serial.println(F("Failed"));
    } else {
      Serial.println(F("OK!"));
    }

    if (! rollpub.publish((char*) STRroll.c_str())) {
      Serial.println(F("Failed"));
    } else {
      Serial.println(F("OK!"));
    }
    
   MQTT_connect();

  mqtt.processPackets(100);
 delay(66);
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
