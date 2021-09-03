  long duracion;
  long distancia; // float distancia para obtener decimales
  int motor11=2;  //salida al motor derecho
  int motor12=3;  //salida al motor derecho
  int motor21=4;  //salida al motor izquierdo
  int motor22=5;  //salida al motor izquierdo
  int motoratras1=6; //salida a los motores de atras
  int motoratras2=7; //salida a los motores de atras 
  int stoplight=8;  //luces motores de atras
  int derecha=9;  //senial para desactivar el derecho
  int izquierda=10; //senial para desactivar el izquierdo
  int detenerse=11; //senial para desactivar los motores de atras
  int echo=12;  
  int trig=13;
  int right=23;//luz derecha
  int left=25; //luz izquierda
  int alta = 256; //velocidad maxima
  int baja = 50; //velocidad minima
  int actual=150; //velocidad por default
  
  void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  Serial1.begin(9600);
  //pinMode(trig, OUTPUT);
  //pinMode(echo, INPUT);
  setMotores();
}

void loop() {
 //opciones();
 //delay(50);
 VerificarMeta();
 delay(500);
}

void setMotores(){
  pinMode(motor11,OUTPUT);
  pinMode(motor12,OUTPUT);
  pinMode(motor21,OUTPUT);
  pinMode(motor22,OUTPUT);
  pinMode(motoratras1,OUTPUT);
  pinMode(motoratras2,OUTPUT);
  pinMode(stoplight,OUTPUT);
  pinMode(derecha,OUTPUT);
  pinMode(izquierda,OUTPUT);
  pinMode(detenerse,OUTPUT);
  pinMode(right,OUTPUT);
  pinMode(left,OUTPUT);
}
void VerificarMeta(){
  int distancia = sensorUS(trig,echo);
  if(distancia<=20){
    stopcar();
    Serial.println("Llego a la meta!!!");
    Serial1.println("Llego a la meta!!!");
  }else{
    opciones();
    //opciones1(distancia);
    Serial1.print("Distancia: ");
    Serial1.print(distancia);
    Serial1.println(" cm");
  }  
}

void opciones1(int algo){
    if(algo<10){//adelante Las llantas giran 
      adelante();
    }else if(algo<20){//reversa-> ajustar Giro con todas la llantas al contario
      reversa();
    }else if(algo<30){//izquierda-> parar llanta derecha 
      irIzquierda();
    }else if(algo <40){//derecha-> detener llanta izquierda
      irDerecha();
    }else if(algo <50){//alta velocidad--> aumento en velocidad
      vAlta();
    }else if(algo<60){//velocidad Baja--> bajar velocidad
      vBaja();
    }else if(algo<70){//Detenerse--> Bajar digitalWrite(pin,LOW);
      stopcar();
    }
    delay(50);
}


void opciones(){
 String algo="";
  while(Serial.available()>0){
   algo +=(char)Serial.read();
  }
  if(algo!=""){
    Serial1.println(algo);
    if(algo=="1"){//adelante Las llantas giran 
      adelante();
    }else if(algo=="2"){//reversa-> ajustar Giro con todas la llantas al contario
      reversa();
    }else if(algo=="3"){//izquierda-> parar llanta derecha 
      irIzquierda();
    }else if(algo=="4"){//derecha-> detener llanta izquierda
      irDerecha();
    }else if(algo=="5"){//alta velocidad--> aumento en velocidad
      vAlta();
    }else if(algo=="6"){//velocidad Baja--> bajar velocidad
      vBaja();
    }else if(algo=="7"){//Detenerse--> Bajar digitalWrite(pin,LOW);
      stopcar();
    }
  }
  delay(50);
}

void adelante(){
  if (actual == 0)
    actual =150;
  analogWrite(derecha, actual);
  analogWrite(izquierda, actual);
  analogWrite(detenerse, actual);
  digitalWrite(stoplight, HIGH);
  digitalWrite(left,HIGH);
  digitalWrite(right,HIGH);
  digitalWrite(motor11,HIGH); 
  digitalWrite(motor12,LOW);
  digitalWrite(motor21,HIGH); 
  digitalWrite(motor22,LOW);
  digitalWrite(motoratras1,HIGH); 
  digitalWrite(motoratras2,LOW);
  enviarMsj("Avanzando velocidad actual:  ","Avanzando");
}

void reversa(){
  analogWrite(derecha, actual);
  analogWrite(izquierda, actual);
  analogWrite(detenerse, actual);
  digitalWrite(left,HIGH);
  digitalWrite(right,HIGH);
  digitalWrite(stoplight, HIGH);
  digitalWrite(motor11,LOW); 
  digitalWrite(motor12,HIGH);
  digitalWrite(motor21,LOW); 
  digitalWrite(motor22,HIGH);
  digitalWrite(motoratras1,LOW); 
  digitalWrite(motoratras2,HIGH);
  enviarMsj("Retrocediendo  ","Retrocediendo");
}
void irIzquierda(){
  analogWrite(detenerse,actual);
  analogWrite(izquierda,actual);
  digitalWrite(derecha,LOW);
  digitalWrite(left,HIGH);
  digitalWrite(right,LOW);
  digitalWrite(stoplight, HIGH);
  //digitalWrite(motor11,LOW); 
  //digitalWrite(motor12,LOW);
  //digitalWrite(motor21,HIGH); 
  //digitalWrite(motor22,LOW);
  //digitalWrite(motoratras1,HIGH); 
  //digitalWrite(motoratras2,LOW);
  enviarMsj("Avanzando izquierda ","Izquierda");
}
void irDerecha(){
  analogWrite(detenerse,actual);
  digitalWrite(izquierda,LOW);
  analogWrite(derecha,actual);
  digitalWrite(left,LOW);
  digitalWrite(right,HIGH);  
  digitalWrite(stoplight,HIGH);
  //digitalWrite(motor11,HIGH); 
  //digitalWrite(motor12,LOW);
  //digitalWrite(motor21,LOW); 
  //digitalWrite(motor22,LOW);
  //digitalWrite(motoratras1,HIGH); 
  //digitalWrite(motoratras2,LOW);
  enviarMsj("Avanzando derecha ","Derecha");
}
void vAlta(){
  for (int i = actual; i < alta; i++) {
  actual = i;
  analogWrite(derecha, actual);
  analogWrite(izquierda, actual);
  analogWrite(detenerse, actual);
  digitalWrite(left,HIGH);
  digitalWrite(right,HIGH);  
  digitalWrite(stoplight,HIGH);
  }
  enviarMsj("Velocidad alta ","Velocidad alta");
}
void vBaja(){
  for (int i = actual; i >= baja; --i) {
  actual = i;
  analogWrite(derecha, actual);
  analogWrite(izquierda, actual);
  analogWrite(detenerse, actual);
  digitalWrite(left,HIGH);
  digitalWrite(right,HIGH);  
  digitalWrite(stoplight,HIGH);
  }
  enviarMsj("Velocidad baja ","Velocidad baja");
}
void stopcar(){
  actual = 0;
  digitalWrite(stoplight,HIGH);
  digitalWrite(left,LOW);
  digitalWrite(right,LOW);
  digitalWrite(detenerse,LOW);
  digitalWrite(izquierda,LOW);
  digitalWrite(derecha,LOW);
  Serial1.println("Detenido");
  Serial.println("Detenido");
}

void enviarMsj(String msj1, String msj2){
  Serial1.print(msj1);
  Serial1.print(actual);
  Serial1.println(" pwm");
  Serial.println(msj2);
}
int sensorUS(int triggerPin, int echoPin) {
    pinMode(triggerPin, OUTPUT);
    digitalWrite(triggerPin, LOW);
    delayMicroseconds(4);
    digitalWrite(triggerPin, HIGH);
    delayMicroseconds(10);
    digitalWrite(triggerPin, LOW);
    pinMode(echoPin, INPUT);
    distancia = 0.01712328767 * pulseIn(echoPin, HIGH);
    delay(75);
    return (distancia);
}
