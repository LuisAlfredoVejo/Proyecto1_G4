  long duracion;
  long distancia; // float distancia para obtener decimales
  int motor11=2;
  int motor12=3;
  int motor21=4;
  int motor22=5;
  int motoratras1=6;
  int motoratras2=7;
  int stoplight=8;
  int derecha=9;
  int izquierda=10;
  int detenerse=11; 
  int echo=12;
  int trig=13;
  int right=23;
  int left=25;
  int alta = 256;
  int baja = 50;
  int actual=150;
  
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
  if(distancia<3){
    stopcar();
    Serial.println("Llego a la meta!!!");
    Serial1.println("Llego a la meta!!!");
  }else{
    //opciones();
    opciones1(distancia);
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
  Serial1.print("Avanzando velocidad actual:  ");
  Serial1.print(actual);
  Serial1.println(" pwm");
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
  Serial1.print("Retrocediendo  ");
  Serial1.print(actual);
  Serial1.println(" pwm");
}
void irIzquierda(){
  digitalWrite(detenerse,HIGH);
  digitalWrite(izquierda,HIGH);
  digitalWrite(derecha,LOW);
  digitalWrite(left,HIGH);
  digitalWrite(right,LOW);
  digitalWrite(stoplight, HIGH);
  digitalWrite(motor11,LOW); 
  digitalWrite(motor12,LOW);
  digitalWrite(motor21,HIGH); 
  digitalWrite(motor22,LOW);
  digitalWrite(motoratras1,HIGH); 
  digitalWrite(motoratras2,LOW);
  Serial1.print("Avanzando izquierda ");
  Serial1.print(actual);
  Serial1.println(" pwm");
}
void irDerecha(){
  digitalWrite(detenerse,HIGH);
  digitalWrite(izquierda,LOW);
  digitalWrite(derecha,HIGH);
  digitalWrite(left,LOW);
  digitalWrite(right,HIGH);  
  digitalWrite(stoplight,HIGH);
  digitalWrite(motor11,HIGH); 
  digitalWrite(motor12,LOW);
  digitalWrite(motor21,LOW); 
  digitalWrite(motor22,LOW);
  digitalWrite(motoratras1,HIGH); 
  digitalWrite(motoratras2,LOW);
  Serial1.print("Avanzando derecha ");
  Serial1.print(actual);
  Serial1.println(" pwm");
}
void vAlta(){
  for (int i = actual; i < alta; i++) {
  actual = i;
  analogWrite(derecha, actual);
  analogWrite(izquierda, actual);
  analogWrite(detenerse, actual);
  Serial1.print(actual);
  Serial1.println(" pwm");
  }
  Serial1.print("Velocidad alta ");
  Serial1.print(actual);
  Serial1.println(" pwm");
}
void vBaja(){
  for (int i = actual; i >= baja; --i) {
  actual = i;
  analogWrite(derecha, actual);
  analogWrite(izquierda, actual);
  analogWrite(detenerse, actual);
  Serial1.print(actual);
  Serial1.println(" pwm");
  }
  Serial1.print("Velocidad baja ");
  Serial1.print(actual);
  Serial1.println(" pwm");
}
void stopcar(){
  digitalWrite(stoplight,LOW);
  digitalWrite(left,LOW);
  digitalWrite(right,LOW);
  digitalWrite(detenerse,LOW);
  digitalWrite(izquierda,LOW);
  digitalWrite(derecha,LOW);
  Serial1.println("Detenido");
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
