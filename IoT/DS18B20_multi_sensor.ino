// update 30-01-2021

#include <OneWire.h>
#include <DallasTemperature.h>
#include <Time.h>
#include <ESP8266WiFi.h>
#define BLYNK_PRINT Serial
#include <BlynkSimpleEsp8266.h>
#include <TridentTD_LineNotify.h>
#include <WiFiClientSecureAxTLS.h>

char auth[] = ""; 
#define LINE_TOKEN ""  



#define ONE_WIRE_BUS1 2
#define ONE_WIRE_BUS2 4 

// Create a new instance of the oneWire class to communicate with any OneWire device:
OneWire oneWire1(ONE_WIRE_BUS1);
OneWire oneWire2(ONE_WIRE_BUS2);
// Pass the oneWire reference to DallasTemperature library:
DallasTemperature sensor1(&oneWire1);
DallasTemperature sensor2(&oneWire2);


const char* ssid     = ""; 
const char* pwd = "";


//int timezone = 7 * 3600; //ตั้งค่า TimeZone ตามเวลาประเทศไทย
//int dst = 0; //กำหนดค่า Date Swing Time

float Celsius1=0;
float Celsius2=0;

void setup() {
    Serial.begin(115200);
    Blynk.begin(auth, ssid, pwd);
    Serial.print("IP address: ");
    Serial.println(WiFi.localIP());
    Serial.print("MAC address: ");
    Serial.println(WiFi.macAddress());
    LINE.setToken(LINE_TOKEN);
    LINE.notify("Start Up...");
    Serial.println("");
    Serial.println("Start Up...");
    sensor1.begin();
    sensor2.begin(); 
}

// the loop function runs over and over again forever
void loop() {
  Blynk.run();
  sensor1.requestTemperatures();
  sensor2.requestTemperatures();
  Celsius1 = sensor1.getTempCByIndex(0);  
  Celsius2 =  sensor2.getTempCByIndex(0);
//  Serial.print("Sensor 1 =>  ");
//  Serial.print(Celsius1);
//  Serial.print("  | Sensor 2 =>  "); 
//  Serial.println(Celsius2); 
//  Fahrenheit = sensors.toFahrenheit(Celsius); 
  
  // check for multi task 
    if(Celsius1 == -127.00){ //        Serial.println("sensor NOT working");
        task0();
    }
    if(Celsius2 == -127.00){ //        Serial.println("sensor NOT working");
        task0();
    }
    if((Celsius1 > -55 && Celsius1 < 125) || (Celsius2 > -55 && Celsius2 < 125)){
        task1();      // blynk @ 1 minute 
        task4();      // GAS routine save data to google sheet   @ 1 hr 
    }
    if(Celsius1 > -55 && Celsius1 < 2){   // sensor1  below where  need 
        task1();      // blynk @ 1 minute
        task201();    // notification when  Celsius1 (sensor1)  is below 2 C    @ 1 hr 
        task3();    // GAS save data to google sheet when out of range @ 30 minute 
    }
    if(Celsius2 > -55 && Celsius2 < 2){   // sensor2 below where  need 
        task1();      // blynk @ 1 minute
        task202();    // // notification when  Celsius1 (sensor2)  is below 2 C   @ 1 hr 
        task3();    // GAS save data to google sheet when out of range @ 30 minute 
    }
    if(Celsius1 > 8 && Celsius1 < 100){ // sensor1 above  where  need 
        task1();      // blynk  @ 1 minute
        task201();      // notification when  Celsius1 (sensor1)  is above 8  C    @ 1 hr 
        task3();    // GAS save data to google sheet  when out of range  @ 30 minute 
    }
    if(Celsius2 > 8 && Celsius2 < 100){ // sensor2 above  where  need
        task1();      // blynk  @ 1 minute
        task202();      // notification when  Celsius1 (sensor2)  is above 8  C    @ 1 hr 
        task3();    // GAS save data to google sheet  when out of range  @ 30 minute 
    }

    
}

void task0(){ // do not thing  
static unsigned long timer=millis();
const  unsigned long period=600000; // 10 นาที 
  while((millis()-timer > period)){
      Serial.println(".");
    timer +=period;  
  }
}
void task1(){ // send data to blynk 
static unsigned long timer=millis();
const  unsigned long period=30000; // 1/2 นาที 
  while((millis()-timer > period)){
      Blynk.virtualWrite(V0,Celsius1);
      Blynk.virtualWrite(V1,Celsius2);
//      Serial.print("send data to blynk =>");
//      Serial.print(Celsius1);
//      Serial.print("  |   ");
//      Serial.println(Celsius2);
      timer +=period;  
  }
}

void task201(){ // notification when the Celsius1 is below 2 C OR  above 8 C   @ 1 hr 
  static unsigned long timer=millis();
//  const  unsigned long period=300000; // 1 นาที 
  const  unsigned long period=3600000; // 1 hr 
  while((millis()-timer > period)){
      String LineText;
      String string1 = "ขณะนี้อุณหภูมิตู้เก็บยา (sensor1)  =  ";  
      String string2 = " °C";
      LineText = string1 + Celsius1 + string2;
//      Serial.print("send data to line notify =>");
//      Serial.println(LineText);
      LINE.notify(LineText);
      timer +=period;  
  }
}
void task202(){ // notification when the Celsius2  is below 2 C OR  above 8 C   @ 1 hr 
  static unsigned long timer=millis();
//  const  unsigned long period=300000; // 5 นาที 
  const  unsigned long period=3600000; // 1 hr 
  while((millis()-timer > period)){
      String LineText;
      String string1 = "อุณหภูมิตู้เก็บวัคซีน (sensor2)   =  ";  
      String string2 = " °C";
      LineText = string1 + Celsius2 + string2;
//      Serial.print("send data to line notify =>");
//      Serial.println(LineText);
      LINE.notify(LineText);
      timer +=period;  
  }
}

void task3(){  // GAS save data to google sheet when out of range @ 30 minute
  static unsigned long timer=millis();
//  const  unsigned long period=600000; // 10 minute 
  const  unsigned long period=1800000; // 30 minute 
  while((millis()-timer > period)){
  axTLS::WiFiClientSecure client;
  const char* HOST = "script.google.com";
  const char* GScriptId = "";  
  String url32 = String("/macros/s/") + GScriptId + "/exec?&FIELD1="+(String)Celsius1 + "&FIELD2="+(String) Celsius2;
//  Serial.print("Client.Connecting...");
  if (client.connect(HOST, 443)) {
      client.println("GET " + String(url32) + " HTTP/1.0"); //HTTP/1.0 OK sent LINEnotify and GoogleSheet
      client.println("Host: " + String(HOST));
      client.println("User-Agent: ESP8266\r\n");
      client.println("Connection: close\r\n\r\n");
      //client.println(true ? "" : "Connection: close\r\n");
      //client.println("Content-Type: application/x-www-form-urlencoded");
      client.println("Content-Type: application/json");    
      //2client.println("Connection: close");    
      client.println("Content-Length: " + String(url32.length()));
      client.println();
      //client.println(postData);
      client.print("\r\n\r\n");
  }
//  Serial.print(millis());  
//  Serial.print("OK out of range  GAS =>");
//  Serial.print("sensor1  :");
//  Serial.print(Celsius1);
//  Serial.print("sensor2  :");
//  Serial.print(Celsius2);
//  Serial.println("    ok...");
  timer +=period;  
  }
}
void task4(){  // GAS routine save data to google sheet   @ 1 hr 
  static unsigned long timer=millis();
//  const  unsigned long period=1800000; // 5 minute 
  const  unsigned long period=3600000; // 1 hr  
  while((millis()-timer > period)){

  axTLS::WiFiClientSecure client;
  const char* HOST = "script.google.com";
  const char* GScriptId = ";  
  String url32 = String("/macros/s/") + GScriptId + "/exec?&FIELD1="+(String)Celsius1 + "&FIELD2="+(String) Celsius2;
//  Serial.print("Client.Connecting...");
  if (client.connect(HOST, 443)) {
      client.println("GET " + String(url32) + " HTTP/1.0"); //HTTP/1.0 OK sent LINEnotify and GoogleSheet
      client.println("Host: " + String(HOST));
      client.println("User-Agent: ESP8266\r\n");
      client.println("Connection: close\r\n\r\n");
      //client.println(true ? "" : "Connection: close\r\n");
      //client.println("Content-Type: application/x-www-form-urlencoded");
      client.println("Content-Type: application/json");    
      //2client.println("Connection: close");    
      client.println("Content-Length: " + String(url32.length()));
      client.println();
      //client.println(postData);
      client.print("\r\n\r\n");
  }    
//      Serial.print(millis());
//      Serial.print("OK routine GAS => ");
//      Serial.print("sensor1  :");
//      Serial.print(Celsius1);
//      Serial.print("sensor2  :");
//      Serial.print(Celsius2);
//      Serial.println("    successfully...");
      timer +=period;  
  }
}
