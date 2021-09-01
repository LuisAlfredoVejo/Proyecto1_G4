  long duracion;
  long distancia; // float distancia para obtener decimales
  int echo=12;
  int trig=13;
  
  void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  Serial1.begin(9600);
  if(true)
   Serial1.println('1');
}

void loop() {
  String algo="";
  while(Serial.available()>0){
   algo +=(char)Serial.read();
  }
  if(algo!="")
    Serial1.println(algo);

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


/*void distancia(){
    //Para estabilizar nuestro módulo ultrasónico
  digitalWrite(trig,LOW);
  delayMicroseconds(4);
  //disparo de un pulso en el trigger de longitud 10us
  digitalWrite(trig,HIGH);
  delayMicroseconds(10);
  digitalWrite(trig,LOW);

  //Lectura de la duración del pulso HIGH generado hasta recibir el Echo
  duracion=pulseIn(echo,HIGH);

  //Calculo distancia
  distancia=duracion/58.4;// (cm)
  Serial.print("Distancia:");
  Serial.print(distancia);
  Serial.println(" cm");
  delay(100);
  }
  */
  
int sensorUS(int triggerPin, int echoPin) {
    pinMode(triggerPin, OUTPUT);
    digitalWrite(triggerPin, LOW);
    delayMicroseconds(2);
    digitalWrite(triggerPin, HIGH);
    delayMicroseconds(10);
    digitalWrite(triggerPin, LOW);
    pinMode(echoPin, INPUT);
    distancia = 0.01723 * pulseIn(echoPin, HIGH);
    delay(25);
    return (distancia);
}
