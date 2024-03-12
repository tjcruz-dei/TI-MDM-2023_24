long timestamp;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  pinMode(6,INPUT_PULLUP);
  pinMode(7,INPUT_PULLUP);
}

void loop() {
  if (millis()-timestamp>50) {
    if (!digitalRead(6)) Serial.write('R');
    if (!digitalRead(7)) Serial.write('L');
  }
}