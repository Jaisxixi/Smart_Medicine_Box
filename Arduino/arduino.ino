#include <SoftwareSerial.h>
#include <LiquidCrystal.h>
#include <StringAction.h>
#include <async.h>

//Pins
const uint8_t rs = 2, en = 3, d4 = 4, d5 = 5,d6 = 6, d7 = 7; // LCD Display Pins
const uint8_t enBT = 10; // Enable/Disable BT
const uint8_t bluTX_ardRX = 11; // BT-Incoming
const uint8_t bluRX_ardTX = 12; //BT-Outgoing
const uint8_t pushButton = 13; // BT-Push Button
const uint8_t buzzer = 9; //Buzzer
const char l1=A3,l2=A2,l3=A1,l4=A0; //LEDS
const uint8_t pushButton2 = 8; // Buzzer-Push Button

//Variables
int loopTime = 150; //Looptime
bool buzzerOn = 0; //buzzerState
//meds data
String desc[4];
unsigned long time[4], TimeMem = 0, ArdElapsed = 0;

//Instances
SoftwareSerial bluetooth(bluTX_ardRX, bluRX_ardTX); // Software Serial connection with HC05
LiquidCrystal lcd(rs, en, d4, d5, d6, d7); // LCD instance

// Current Time
#define RTC (TimeMem+millis()/60000-ArdElapsed)

//Setup
void setup() {
  //Pin setup
  pinMode(bluTX_ardRX,INPUT);
  pinMode(bluRX_ardTX,OUTPUT);  
  pinMode(pushButton,INPUT_PULLUP);
  pinMode(pushButton2,INPUT_PULLUP);
  pinMode(enBT,OUTPUT);
  pinMode(buzzer,OUTPUT);
  pinMode(l1,OUTPUT);
  pinMode(l2,OUTPUT);
  pinMode(l3,OUTPUT);
  pinMode(l4,OUTPUT);
  analogWrite(buzzer,0);

  //LCD setup
  lcd.begin(16, 2);
  
  //Serial Comm Setup
  bluetooth.begin(9600);
  Serial.begin(9600);
}


//Functions
void checkBluetooth() {
  if (bluetooth.available()>0) {
    String incoming = bluetooth.readStringUntil('\n');

    for(int i=0;i<4;i++){
      desc[i] = "";     
      time[i] = 0;
    }
    
    StringAction obj;
    String Meds = "",meds[4]={"","","",""},t[4]={"","","",""};
    
    TimeMem = (incoming[0]-'0')*600 + (incoming[1]-'0')*60 + (incoming[2] - '0')*10 +(incoming[3] - '0');
    ArdElapsed = millis()/60000;

    for(int i=5;i<incoming.length();i++){
      Meds+=incoming[i];
    }    
    obj.split(Meds,meds,";");
    
    for(int i=0;i<4;i++){
      if(meds[i]!=""){
        for(int j=0;j<4;j++){
          t[i]+=meds[i][j];
        }
        for(int j=5;j<meds[i].length();j++){
          desc[i]+=meds[i][j];
        }
      }
    }
    
    for(int i=0;i<4;i++){
      if(t[i]!=""){   
        time[i] = (t[i][0]-'0')*600 + (t[i][1]-'0')*60 + (t[i][2]-'0')*10 + (t[i][3]-'0');
      }
    }

    Serial.print("Time1 = ");
    Serial.println(time[0]);
    
    Serial.print("Time2 = ");
    Serial.println(time[1]);
  }
}

void checkButton(){
  if(!digitalRead(pushButton)){
    digitalWrite(enBT,!digitalRead(enBT));
    
    Serial.print("Bluetooth Pairing mode ");
    if(digitalRead(enBT)) Serial.println("on");
    else Serial.println("off");
  }
}

void buzzerButton(){
  if(!digitalRead(pushButton2)){
    analogWrite(buzzer,0);
    buzzerOn = 0;    
    if(digitalRead(l1)) time[0]+=1440;
    if(digitalRead(l2)) time[1]+=1440;
    if(digitalRead(l3)) time[2]+=1440;
    if(digitalRead(l4)) time[3]+=1440;
    digitalWrite(l1,LOW);
    digitalWrite(l2,LOW);
    digitalWrite(l3,LOW);
    digitalWrite(l4,LOW);
    
    Serial.print("Time1 = ");
    Serial.println(time[0]);
    Serial.print("Time2 = ");
    Serial.println(time[1]);

    lcd.clear();
  }  
}

//Loop Function
void loop() { 
  lcd.setCursor(0, 1);
  lcd.print(RTC/60);
  lcd.print(":");
  lcd.print(RTC%60);
  checkButton();
  delay(loopTime);
  
  while(digitalRead(enBT)){
    checkBluetooth(); //If something is coming at us 
    delay(loopTime);
    checkButton();
  }

  //Alarm and Lighting Functionality
    for(int i=0;i<4;i++){
      if(time[i]!=0 && (RTC)>=time[i]){
        
        analogWrite(buzzer,245);   
        buzzerOn = 1;             

          while(buzzerOn){
            if(RTC>=time[0]){
              digitalWrite(l1,HIGH);
              lcd.setCursor(0,0);
              lcd.print(desc[0]);
              buzzerButton();
              delay(150);
             }
             if(RTC>=time[1]){
              digitalWrite(l2,HIGH);
              lcd.setCursor(0,0);
              lcd.print(desc[1]);
              buzzerButton();
              delay(150);
             }
             if(RTC>=time[2]){
              digitalWrite(l3,HIGH);
              lcd.setCursor(0,0);
              lcd.print(desc[2]);
              buzzerButton();
              delay(150);
             }
             if(RTC>=time[3]){
              digitalWrite(l4,HIGH);
              lcd.setCursor(0,0);
              lcd.print(desc[3]);
              buzzerButton();
              delay(150);
             }
            
          }
      }
    }

  delay(loopTime);
}
