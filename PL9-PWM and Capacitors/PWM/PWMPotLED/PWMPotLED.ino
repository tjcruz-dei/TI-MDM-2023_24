void setup() {
  // put your setup code here, to run once:
 pinMode(3,OUTPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  int rdd=analogRead(A0);

  analogWrite(3,rdd/4);
}
