// 31/01/2564

#include <OneWire.h>
#include <DallasTemperature.h>
#define ONE_WIRE_BUS 4 //กำหนดขาที่จะเชื่อมต่อ Sensor
#include <WiFiClientSecureAxTLS.h>
#define BLYNK_PRINT Serial
#include <BlynkSimpleEsp8266.h>
#include <TridentTD_LineNotify.h>


OneWire oneWire(ONE_WIRE_BUS);
DallasTemperature sensors(&oneWire);

char auth[] = ""; 
#define LINE_TOKEN ""  

const char* ssid     = "";
const char* pwd = ""; 

float Celsius = 0;
float Fahrenheit = 0 ; 

void setup(void) {
  Serial.begin(9600);
  Blynk.begin(auth, ssid, pwd);
  Serial.println("App Blynk ทำงาน!");
  Serial.print("IP address: ");
  Serial.println(WiFi.localIP());
  Serial.print("MAC address: ");
  Serial.println(WiFi.macAddress());
  LINE.setToken(LINE_TOKEN);
  LINE.notify("Start...");
  sensors.begin();
}

void loop(void) {
  Blynk.run();
  sensors.requestTemperatures();            
  Celsius=sensors.getTempCByIndex(0);
  Fahrenheit = sensors.toFahrenheit(Celsius); 
  // check for multi task 
  if(Celsius == -127.00){     //  not possible, something failed,DS18B20 miscommunication
      task0();
  }
  if(Celsius > -55 && Celsius < 125){  //  value is possible
      task1();      // blynk @ 1 minute 
      task4();      // GAS routine save data to google sheet   @ 1 hr 
  }
  if((Celsius > -55 && Celsius< 2) || (Celsius > 8 && Celsius < 100)){   // out of range
      task1();      // blynk @ 1 minute
      task2();    // notification when the temp is below 2 C OR  above 8 C   @ 1 hr 
      task3();    // GAS save data to google sheet when out of range @ 30 minute 
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
const  unsigned long period=60000; // 1 นาที 
  while((millis()-timer > period)){
      Blynk.virtualWrite(V0,Celsius);
      Blynk.virtualWrite(V1,Fahrenheit);
      timer +=period;  
  }
}

void task2(){ // notification when the temp is below 2 C OR  above 8 C   @ 1 hr 
  static unsigned long timer=millis();
  const  unsigned long period=3600000; // 1 hr 
  while((millis()-timer > period)){
      String LineText;
      String string1 = "ขณะนี้อุณหภูมิตู้เก็บยา  =  ";  
      String string2 = " °C";
      LineText = string1 + Celsius + string2;
      LINE.notify(LineText);
      timer +=period;  
  }
}

void task3(){  // GAS save data to google sheet when out of range @ 30 minute
  static unsigned long timer=millis();
  const  unsigned long period=1800000; // 30 minute 
  while((millis()-timer > period)){
    axTLS::WiFiClientSecure client;
    const char* HOST = "script.google.com";
    const char* GScriptId = "";  
    String url32 = String("/macros/s/") + GScriptId + "/exec?&FIELD1="+(String)Celsius ; 
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
    } // end if 
    timer +=period;  
  } //end while loop
}

void task4(){  // GAS routine save data to google sheet   @ 1 hr 
  static unsigned long timer=millis();
  const  unsigned long period=3600000; // 1 hr  
  while((millis()-timer > period)){
    axTLS::WiFiClientSecure client;
    const char* HOST = "script.google.com";
    const char* GScriptId = "";  
    String url32 = String("/macros/s/") + GScriptId + "/exec?&FIELD1="+(String)Celsius ; 
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
        client.print("\r\n\r\n");
    } // end if     
    timer +=period;  
  }  // end while loop 
 }
