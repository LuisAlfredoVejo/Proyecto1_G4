char lectura = Serial1.read();
long duracion;
long distancia; // float distancia para obtener decimales
int echo=12;
int trig=13;

void setup() {
  // put your setup code here, to run once:
  Serial1.begin(9600);
  pinMode(trig,OUTPUT); // emisor
  pinMode(echo,INPUT); // Receptor
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
