/* Copyright 2020 Electrical Engineering Enterprise Group.
 *  ESP-EP.12 DATA Logger by ggSpread Sheet  
 *  
 *  Dev.Jukrapun Chitpong
 */
#define BLYNK_PRINT Serial
#include <BlynkSimpleEsp8266.h>
#include <OneWire.h>
#include <DallasTemperature.h>
#include <TridentTD_LineNotify.h>
#include <WiFiClientSecureAxTLS.h>

#define ONE_WIRE_BUS 2 // ESP8266 sensor DS18B20  ต่อ PIN D4,G,3V
  OneWire oneWire(ONE_WIRE_BUS);    // sensor DS18B20
  DallasTemperature sensors(&oneWire);  // sensor DS18B20


//------ Config WiFi ------
#define ssid    "EMMA_2.4GHz"
#define pass    "me053700"

// You should get Auth Token in the Blynk App and Line notify.
char auth[] = "8_ZMa0Xp7oecvePsvYC3ebHgx6Lx4s_o";

// line 
#define LINE_TOKEN "OsDSh5Wb9cubp4UntUaCDROdlxdzWNJbLEfW0KCtV9m" 



 

float Celsius = 0;
float Fahrenheit = 0;

void setup() {
  Serial.end();
  Serial.begin(115200);

  // **********  set up  DS18B20 - Blynk - Line notify - Timer
  // (1) set DS18B20
  sensors.begin();
  // (2) set Blynk
  Blynk.begin(auth, ssid, pass);
    // view IP
  Serial.println((WiFi.localIP().toString()));
  // (3) set Line notify
   LINE.setToken(LINE_TOKEN);

  Serial.println("\nWaiting for time");
  while (!time(nullptr)) {
    Serial.print(".");
    delay(1000);
  }
}

void loop(){

  Blynk.run();
  sensors.requestTemperatures(); // Send the command to get temperatures
  Celsius=(sensors.getTempCByIndex(0))-1;
  Fahrenheit = sensors.toFahrenheit(Celsius); 

  // check for multi task 
        if(Celsius == -127.00){ //  sensor  error      
          task0();
        }
        if(Celsius > 1 && Celsius < 11 ){
            task_blynk();
            tast_inorder();
            task_line();
        }
        if(Celsius > -55 && Celsius< 2){
            task_blynk();
            tast_amiss();
            task_line();
        }
        if(Celsius > 10 && Celsius < 50){
           task_blynk();
           tast_amiss();
           task_line();
        }



}
void task0(){                                     // do not thing  
  static unsigned long timer=millis();
  const  unsigned long period=600000; // 10 นาที 
    while((millis()-timer > period)){
        Serial.println("sensor NOT working");
        timer +=period;  
    }
}

void task_blynk(){                            // send data to blynk 
  static unsigned long timer=millis();
  const  unsigned long period=60000; // 1 นาที 
    while((millis()-timer > period)){
        Blynk.virtualWrite(V0,Celsius);
        Blynk.virtualWrite(V1,Fahrenheit);
        timer +=period;  
    }
}


void task_line(){                                   // notification when the temp is below 2 C OR  above 8 C   
  static unsigned long timer=millis();
//  const  unsigned long period=300000; // 1 นาที 
  const  unsigned long period=300000; // 5 นาที 
  while((millis()-timer > period)){
      String LineText;
      String string1 = "ขณะนี้อุณหภูมิตู้เก็บวัคซีน  =  ";  
      String string2 = " °C";
      LineText = string1 + Celsius + string2;
      LINE.notify(LineText);
      timer +=period;  
  }
}

void tast_inorder(){  
    static unsigned long timer=millis();
    const  unsigned long period=3600000; // 1 hr
        while((millis()-timer > period)){
            axTLS::WiFiClientSecure client;
            const char* HOST = "script.google.com";
            
            // google appscript id
            // ทุ่งในไร่
            // YOUR SCRIPT = https://script.google.com/macros/s/AKfycbxYT0hHSgwfFbLDuXcm8NiekakzvPMp7pB1G-_hfGzb2cdMS9lhcFHGWnoMJceAwcUt/exec
            // U can test script by fill:   /?&FIELD1=16&FIELD2=18  
            const char* GScriptId = "AKfycbxYT0hHSgwfFbLDuXcm8NiekakzvPMp7pB1G-_hfGzb2cdMS9lhcFHGWnoMJceAwcUt";  
            //  String url32 = String("/macros/s/") + GScriptId + "/exec?&FIELD1="+(String)TEMP + "&FIELD2="+(String) HUMD;
            String url32 = String("/macros/s/") + GScriptId + "/exec?&FIELD1="+(String)Celsius;
            Serial.print("Client.Connecting...");

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
                Serial.print("routine task...");  
            }  // end if 
             timer +=period;  
        }  // end while 
  
}

void tast_amiss(){
      static unsigned long timer=millis();
      const  unsigned long period=600000; // 10 minute 
      
        while((millis()-timer > period)){
            axTLS::WiFiClientSecure client;
            const char* HOST = "script.google.com";
            
            // google appscript id
            // ทุ่งในไร่
            // YOUR SCRIPT = https://script.google.com/macros/s/AKfycbxYT0hHSgwfFbLDuXcm8NiekakzvPMp7pB1G-_hfGzb2cdMS9lhcFHGWnoMJceAwcUt/exec
            // U can test script by fill:   /?&FIELD1=16&FIELD2=18  
            const char* GScriptId = "AKfycbxYT0hHSgwfFbLDuXcm8NiekakzvPMp7pB1G-_hfGzb2cdMS9lhcFHGWnoMJceAwcUt";  
            //  String url32 = String("/macros/s/") + GScriptId + "/exec?&FIELD1="+(String)TEMP + "&FIELD2="+(String) HUMD;
            String url32 = String("/macros/s/") + GScriptId + "/exec?&FIELD1="+(String)Celsius;
            Serial.print("Client.Connecting...");

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
                Serial.print("out of range...");  
            }  // end if 
             timer +=period;  
        }  // end while 
}


/*
void GG_ScriptSheet(){
//  sensors.requestTemperatures();            // อ่านค่าจาก sensor DS18B20
//  Celsius = sensors.getTempCByIndex(0);     // รับค่า output จาก sensor 
  axTLS::WiFiClientSecure client;
  const char* HOST = "script.google.com";
  // google appscript id
  // ทุ่งในไร่
  // YOUR SCRIPT = https://script.google.com/macros/s/AKfycbxYT0hHSgwfFbLDuXcm8NiekakzvPMp7pB1G-_hfGzb2cdMS9lhcFHGWnoMJceAwcUt/exec
  // U can test script by fill:   /?&FIELD1=16&FIELD2=18  
  const char* GScriptId = "AKfycbxYT0hHSgwfFbLDuXcm8NiekakzvPMp7pB1G-_hfGzb2cdMS9lhcFHGWnoMJceAwcUt";  
  //  String url32 = String("/macros/s/") + GScriptId + "/exec?&FIELD1="+(String)TEMP + "&FIELD2="+(String) HUMD;
  String url32 = String("/macros/s/") + GScriptId + "/exec?&FIELD1="+(String)Celsius;
  Serial.print("Client.Connecting...");

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
      Serial.print("Response...");  
  }
  Serial.println("OK !!!");  
}
*/
