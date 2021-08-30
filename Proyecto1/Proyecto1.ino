char lectura = Serial1.read();

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  Serial1.begin(9600);
  pinMode(12,OUTPUT);
  pinMode(13,OUTPUT);
  }
void loop() {
  // put your main code here, to run repeatedly:
  digitalWrite(12,LOW);
  digitalWrite(13,LOW);
  delay(50);
 }

void velocidad(){
  
}

void izquierda(){
  
}

void derecha(){
  
}

void adelante_reversa(){
  
}

void detenerse(){
  
}
