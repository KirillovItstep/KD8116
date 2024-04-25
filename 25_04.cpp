#include <Arduino.h>
#include <HardwareSerial.h>
#include "driver/ledc.h"

/*Синий - земля,
черный - АКБ D22,
оранжевый - зажигание D3,
черный - подсветка D23, (Период импульса 12мс)
оранжевый - скорость D21
*/
int auto_accum = 22; //АКБ
int ignition = 19; //Зажигание
int light = 23; //Подсветка
int speed = 21; //Скорость

int voltage8 = 13; //8В
int speedInput = 26; //Скорость
int lowSpeed = 12; //Малая скорость
int load = 14; //Управление нагрузкой
int distance = 27; //Пройденное расстояние

volatile long int counter; //Variables used in ISR must be volatile
volatile boolean speedValue = LOW;
hw_timer_t *timer = NULL; //Pointer to the timer structure
portMUX_TYPE timerMutex = portMUX_INITIALIZER_UNLOCKED; //Mutex

//Interrupt function
void IRAM_ATTR onTimer(){
  if (counter%(72)==0){
    speedValue = !speedValue;
digitalWrite(speed,speedValue);
  }
  //portENTER_CRITICAL_ISR(&timerMutex);
counter++;

//portEXIT_CRITICAL_ISR(&timerMutex);
}

volatile int incomingByte = 0; 

void setup()
{
    Serial.begin(9600);
    pinMode(auto_accum, OUTPUT);
    pinMode(ignition, OUTPUT);
    pinMode(light, OUTPUT);
    pinMode(speed, OUTPUT);  

    timer = timerBegin(0,80,true); //timer 0, prescaller 80, UP counting
  timerAttachInterrupt(timer, &onTimer, true);
  timerAlarmWrite(timer, 1000, true); //delay is 1ms
  timerAlarmEnable(timer);     
}

void switchOn(){
  digitalWrite(auto_accum, HIGH);
    delay(3000);
    digitalWrite(ignition, HIGH);
    delay(3000);
}


void ledOn(){
  byte bitNum = 4;
  ledcSetup(0, 83, bitNum);
  ledcAttachPin(light, 0); 
   // increase the LED brightness
  for(int dutyCycle = 0; dutyCycle <= (1<<bitNum-1); dutyCycle++){   
    // changing the LED brightness with PWM
    ledcWrite(0, dutyCycle);
    delay(150);
  }
  // decrease the LED brightness
  for(int dutyCycle = (1<<bitNum-1); dutyCycle >= 0; dutyCycle--){
    // changing the LED brightness with PWM
    ledcWrite(0, dutyCycle);   
    delay(150);
  }  
   ledcWrite(0, 2); 

}

void speedOn(int speedValue){
   //Скорость
   int koef = 5000;                 //Коэффициент в формуле
   //int speedValue = 60;             //Скорость
   int freq = koef*speedValue/3600; //Частота
   int fdel = 1000/freq/2;          //Задержка
for (int i=0; i<10000; i++){
  digitalWrite(speed,HIGH);
  delay(fdel);
  digitalWrite(speed,LOW);
  delay(fdel);   
}
}

void voltageIn(){
  while (Serial.available()<=0){
   int signal = analogRead(voltage8);
   Serial.print(">V8:");
  Serial.println(signal);
  delay(200);
  }
}

void speedIn(){
  while (Serial.available()<=0){
   int signal = analogRead(speedInput);
   Serial.print(">Speed:");
  Serial.println(signal);
  delay(10);
  }
}

void lowSpeedIn(){
  while (Serial.available()<=0){
   int signal = analogRead(lowSpeed);
   Serial.print(">Low:");
  Serial.println(signal);
  delay(200);
  }
}

void loadIn(){
  while (Serial.available()<=0){
   int signal = analogRead(load);
   Serial.print(">Load:");
  Serial.println(signal);
  delay(200);
  }
}

void distIn(){
  while (Serial.available()<=0){
   int signal = analogRead(distance);
   Serial.print(">Dist:");
  Serial.println(signal);
  delay(200);
  }
}

void loop()
{
  // send data only when you receive data:
  if (Serial.available() > 0) {
    // read the incoming byte:
    incomingByte = Serial.read();
    //Serial.println(incomingByte,DEC);

   switch (incomingByte){
    case '1': switchOn(); break;
    case '2': ledOn(); break;    
    case '3': speedOn(5); break;
    case '4': voltageIn(); break; 
    case '5': speedIn(); break; 
    case '6': lowSpeedIn(); break; 
    case '7': loadIn(); break; 
    case '8': distIn(); break; 
   }
  }
}
