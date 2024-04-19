int beat[]={180,200,80,80,500};

void setup() {
  // put your setup code here, to run once:
  pinMode(13,OUTPUT);
}

void loop() {
  // put your main code here, to run repeatedly:´
  for (int c=0;c<5;c++) {
    digitalWrite(13,HIGH);
    delay(10);
    digitalWrite(13,LOW);
    delay(beat[c]);
  }
}
