#include <CapacitiveSensor.h>

/*
 * Capacitive Library Demo Sketch
 * Paul Badger 2008
 * Uses a high value resistor e.g. 10M between send pin and receive pin
 * Resistor effects sensitivity, experiment with values, 50K - 50M. Larger resistor values yield larger sensor values.
 * Receive pin is the sensor pin - try different amounts of foil/metal on this pin
 */


CapacitiveSensor   cs_7_6 = CapacitiveSensor(7,6);        // 10M resistor between pins 7 & 6, pin 6 is sensor pin, add a wire and or foil if desired

void setup()                    
{
   cs_7_6.set_CS_AutocaL_Millis(0xFFFFFFFF);     // turn off autocalibrate on channel 1 - just as an example
   Serial.begin(9600);
}

void loop()                    
{
    long start = millis();
    long total1 =  cs_7_6.capacitiveSensor(30);
    
    // Uncomment the next lines to check the sensor output values
    //Serial.print(millis() - start);        // check on performance in milliseconds
    //Serial.print("\t");                    // tab character for debug windown spacing
    Serial.println(total1);                  // print sensor output 1

    if (total1>150) Serial.println("touch");
    delay(10);                             // arbitrary delay to limit data to serial port 
}
