#include <ESP8266WiFi.h>
#include <WiFiUDP.h>
#include <EEPROM.h>

// Wifi related globals.
const char* SSID = "chickadee";
const char* PASSWORD = "iflyfast";

const IPAddress MULTICAST_ADDRESS(239, 249, 134, 147);
const uint16_t PORT = 59734;

// Radio related globals.
const unsigned int TUNE_TIME_MS = 30; // 30

// Cross-power up globals.
const uint32_t EEPROM_VERSION = 1;

const uint16_t MAX_JOIN_DELAY = 15000;

#define RSSI_READS 3 // used to be 10 but took 4ms

const int BOARD_LED = 0;
const int ESP_LED = 2;
const int SPEAKER = 14;
const int ADC_SELECT = 12;

const int RCV_CHIP_SELECT = 4;
const int RCV_CLK = 5;
const int RCV_DATA = 13;

const uint8_t PACKET_TYPE_NEW_CLIENT = 1;
const uint8_t PACKET_TYPE_NEW_PEER = 2;

int errorCode = -1;

unsigned long lastReadTime;
unsigned long lastTuneTime;

IPAddress ourIp;

WiFiUDP udp;

// If we are the AP we must also forward packets from peers to clients.
#define TCP_SERVER_PORT 59736
WiFiServer server(TCP_SERVER_PORT);


uint8_t controlPacket[] = {0, 0, 0, 0};

void setup() {
  Serial.begin(115200);
  delay(10);

  uint32_t chipId = ESP.getChipId();
  //Serial.println(chipId);

  // Get our file counter.
  EEPROM.begin(12);
  uint32_t storedChipId;
  EEPROM.get(0, storedChipId);
  //Serial.println(storedChipId);
  // Initialize the eeprom completely.
  if (storedChipId != chipId) {
    EEPROM.put(0, chipId);
    EEPROM.put(4, EEPROM_VERSION);
  }
  EEPROM.end();

  pinMode(0, OUTPUT);
  
  // ADC_SELECT switches between measuring RSSI and battery voltage. v3 boards
  // don't have the battery voltage divider hooked up so we just set it to the
  // RSSI for good.
  pinMode(ADC_SELECT, OUTPUT);
  digitalWrite(ADC_SELECT, HIGH);

  pinMode(BOARD_LED, OUTPUT);

  pinMode(RCV_DATA, OUTPUT);
  pinMode(RCV_CLK, OUTPUT);
  pinMode(RCV_CHIP_SELECT, OUTPUT);

  // Scan for an existing network.
  WiFi.mode(WIFI_STA);
  WiFi.disconnect();
  delay(100);

  int network_count = WiFi.scanNetworks();

  bool found_network = false;
  for (int i = 0; i < network_count; i++) {
    found_network = String(WiFi.SSID(i)).equals(String(SSID));
    if (found_network) {
      break;
    }
  }

  if (!found_network) {
    WiFi.mode(WIFI_AP_STA);
    WiFi.softAP(SSID, PASSWORD);
    ourIp = WiFi.softAPIP();

    server.begin();
    Serial.println("Created network");
    Serial.println(server.status());
  } else {
    WiFi.begin(SSID, PASSWORD);
    uint16 total_delay = 0;
    while (WiFi.status() != WL_CONNECTED && total_delay < MAX_JOIN_DELAY) {
      delay(100);
      total_delay += 100;
    }
    if (WiFi.status() != WL_CONNECTED) {
      //Serial.println("WiFi join failed.");
      WiFi.printDiag(Serial);
      errorCode = 1;
      return;
    } else {
      //Serial.println("Joined existing network.");
    }
    ourIp = WiFi.localIP();
  }
  //Serial.println(ourIp);
  udp.beginMulticast(ourIp, MULTICAST_ADDRESS, PORT);
  udp.beginPacketMulticast(MULTICAST_ADDRESS, PORT, ourIp);
  controlPacket[0] = PACKET_TYPE_NEW_PEER;
  udp.write(controlPacket, sizeof(controlPacket));
  udp.endPacket();
}

// One iteration byte to detect missed packets.
// Four bytes for the time.
// Two bytes for the frequency.
// Two bytes for the strength.
uint8_t packet_size = 9;

uint8_t packetNo = 0;
uint16_t frequencies[] = {5800, 5740, 0, 0, 0, 0, 0};
uint16_t f_register[] = {0x2984, 0x2906, 0, 0, 0, 0, 0};
uint16_t lastValue = 0;
bool increasing = true;
uint16_t tuningFrequency = 0;
uint16_t tunedFrequency = 0;

const int MAX_CLIENTS = 4;
WiFiClient clients[MAX_CLIENTS];
uint8_t numClients = 0;

const int MAX_PEERS = 4;
WiFiClient peer[MAX_PEERS];
uint8_t numPeers = 0;

#define WIFI_MTU 1400 // buffer writes to the tcp connection to minimize tcp overhead

uint8_t tcp_client_buffer[WIFI_MTU * MAX_CLIENTS];
uint16_t tcp_client_buffer_size[MAX_CLIENTS];

uint8_t tcp_server_buffer[WIFI_MTU];

void loop() {
  // Handle errors by flashing/beeping an error code.
  if (errorCode > 0) {
    digitalWrite(BOARD_LED, LOW);
    delay(100);
    digitalWrite(BOARD_LED, HIGH);
    delay(75);
    digitalWrite(BOARD_LED, LOW);
    delay(100);
    digitalWrite(BOARD_LED, HIGH);
    delay(150);
    for (int i = 0; i < errorCode; i++) {
      digitalWrite(BOARD_LED, LOW);
      delay(350);
      digitalWrite(BOARD_LED, HIGH);
      delay(150);
    }
    delay(1000);
    return;
  }

  // Accept any new peers.
  WiFiClient newPeer = server.available();
  while (newPeer && numPeers < MAX_PEERS) {
    Serial.println("Accepted new peer tcp socket.");
    peer[numPeers] = newPeer;
    numPeers++;
    newPeer = server.available();
  }

  // Forward any tcp packets we've received to all of our clients.
  for (int i = 0; i < numPeers; i++) {
    if (peer[i].available()) {
      Serial.println("New peer tcp");
      uint16_t read_size = peer[i].read(tcp_server_buffer, WIFI_MTU);
      for (int j = 0; j < numClients; j++) {
        clients[j].write((const uint8_t *) tcp_server_buffer, read_size);
      }
    }
  }

  // Read any UDP hello packets we've received.
  while (udp.parsePacket() > 0) {
    Serial.print("Got udp packet of length ");
    Serial.println(udp.available());

    int packet_type = udp.read();
    if (packet_type == PACKET_TYPE_NEW_CLIENT) {
      udp.read();
      uint16_t tcp_port = ((uint16_t) udp.read());
      tcp_port = tcp_port | ((uint16_t) udp.read()) << 8;

      IPAddress new_client_ip = udp.remoteIP();
      bool client_exists = false;
      for (int j = 0; j < numClients; j++) {
        if (clients[j].remoteIP() == new_client_ip) {
          client_exists = true;
          break;
        }
      }

      if (!client_exists) {
        if (numClients == MAX_CLIENTS) {
          errorCode = 2;
          return;
        }
        if (clients[numClients].connect(new_client_ip, tcp_port)) {
          // We prefix our packets with the chip id so it can be differentiated from our peers.
          uint32_t chip_id = ESP.getChipId();
          uint16_t base_offset = WIFI_MTU * numClients;
          tcp_client_buffer[base_offset] = (char) (chip_id >> 24);
          tcp_client_buffer[base_offset + 1] = (char) (chip_id >> 16);
          tcp_client_buffer[base_offset + 2] = (char) (chip_id >> 8);
          tcp_client_buffer[base_offset + 3] = (char) chip_id;
          tcp_client_buffer_size[numClients] = 4;
          
          numClients += 1;

          // Request new client to our peers if we are the AP.
          if (server.status() == LISTEN) {
            Serial.println("Requesting peers to client up.");
            udp.beginPacketMulticast(MULTICAST_ADDRESS, PORT, ourIp);
            controlPacket[0] = PACKET_TYPE_NEW_CLIENT;
            controlPacket[1] = 0;
            controlPacket[2] = TCP_SERVER_PORT & 0xff;
            controlPacket[3] = TCP_SERVER_PORT >> 8;
            udp.write(controlPacket, sizeof(controlPacket));
            udp.endPacket();    
          }
        } else {
//          Serial.print("Failed to create client to ");
//          Serial.print(new_client_ip);
//          Serial.print(" ");
//          Serial.println(tcp_port);
        }
      }
    } else if (packet_type == PACKET_TYPE_NEW_PEER) {
      IPAddress new_peer_ip = udp.remoteIP();
      Serial.print("New peer ");
      Serial.println(new_peer_ip);
    }

//      udp.beginPacketMulticast(MULTICAST_ADDRESS, PORT, ourIp);
//      packet[0] = packetNo++;
//      packet[1] = (char) (lastReadTime >> 24);
//      packet[2] = (char) (lastReadTime >> 16);
//      packet[3] = (char) (lastReadTime >> 8);
//      packet[4] = (char) lastReadTime;
//      packet[5] = (char) (tunedFrequency >> 8);
//      packet[6] = (char) tunedFrequency;
//      packet[7] = (char) (lastValue >> 8);
//      packet[8] = lastValue;
//      udp.write(packet, sizeof(packet));
//      udp.endPacket();
    udp.flush();
  }

  // TODO(tannewt): Garbage collect stale WiFi clients so we can reuse them.

  // Turn on the LED to show we're working but only for the first frequency read.
  digitalWrite(BOARD_LED, LOW);
  int i = 0;
  while (frequencies[i] != 0) {
    if (tunedFrequency != 0) {
      packetNo++;
      for (int j = 0; j < numClients; j++) {
        uint16_t base_offset = WIFI_MTU * j + tcp_client_buffer_size[j];
        tcp_client_buffer[base_offset] = packetNo;
        tcp_client_buffer[base_offset + 1] = (char) (lastReadTime >> 24);
        tcp_client_buffer[base_offset + 2] = (char) (lastReadTime >> 16);
        tcp_client_buffer[base_offset + 3] = (char) (lastReadTime >> 8);
        tcp_client_buffer[base_offset + 4] = (char) lastReadTime;
        tcp_client_buffer[base_offset + 5] = (char) (tunedFrequency >> 8);
        tcp_client_buffer[base_offset + 6] = (char) tunedFrequency;
        tcp_client_buffer[base_offset + 7] = (char) (lastValue >> 8);
        tcp_client_buffer[base_offset + 8] = lastValue;
        tcp_client_buffer_size[j] += packet_size;
        if (WIFI_MTU - tcp_client_buffer_size[j] < packet_size) {
          // TODO(tannewt): Use something else. This blocks on receiving a TCP ack!
          clients[j].write(((const uint8_t *)tcp_client_buffer) + WIFI_MTU * j, tcp_client_buffer_size[j]);
          // Reset back to 4 buffer size because the first four bytes are chip id.
          tcp_client_buffer_size[j] = 4;
        }
      }
      
//      Serial.print(lastReadTime);
//      Serial.print(" ");
//      Serial.print(tunedFrequency);
//      Serial.print(" ");
//      Serial.println(lastValue);
    }
    if (tuningFrequency != 0) {
      if (tuningFrequency != tunedFrequency) {
        // Wait the remainder of the tune time if we actually had to tune.
        int delay_time = TUNE_TIME_MS - (millis() - lastTuneTime);
        //Serial.println(delay_time);
        if (delay_time > 0) {
          delay(delay_time);
        }
      }
      tunedFrequency = tuningFrequency;

      // Read value.
      lastValue = 0;
      for (uint8_t i = 0; i < RSSI_READS; i++) {
        lastValue += analogRead(A0);
      }
      lastValue = lastValue / RSSI_READS;
      //Serial.print(tunedFrequency);
      //Serial.print(" ");
      //Serial.println(lastValue);
      lastReadTime = millis();
    }
    // Tune radio.
    tuningFrequency = frequencies[i];
    if (tuningFrequency != tunedFrequency) {
      RCV_FREQ(f_register[i]);
    }
    
    lastTuneTime = millis();
    i++;
    digitalWrite(BOARD_LED, HIGH);
  }
}

/*
 * SPI driver based on fs_skyrf_58g-main.c Written by Simon Chambers
 * TVOUT by Myles Metzel
 * Scanner by Johan Hermen
 * Inital 2 Button version by Peter (pete1990)
 * Refactored and GUI reworked by Marko Hoepken
 * Universal version my Marko Hoepken
 * Diversity Receiver Mode and GUI improvements by Shea Ivey
 * OLED Version by Shea Ivey
 * Seperating display concerns by Shea Ivey
 * 
The MIT License (MIT)
Copyright (c) 2015 Marko Hoepken
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/
void RCV_FREQ(uint16_t channelData) {
  uint8_t j;
  // Second is the channel data from the lookup table
  // 20 bytes of register data are sent, but the MSB 4 bits are zeros
  // register address = 0x1, write, data0-15=channelData data15-19=0x0
  SERIAL_ENABLE_HIGH();
  SERIAL_ENABLE_LOW();

  // Register 0x1
  SERIAL_SENDBIT1();
  SERIAL_SENDBIT0();
  SERIAL_SENDBIT0();
  SERIAL_SENDBIT0();

  // Write to register
  SERIAL_SENDBIT1();

  // D0-D15
  //   note: loop runs backwards as more efficent on AVR
  for (j = 16; j > 0; j--)
  {
    // Is bit high or low?
    if (channelData & 0x1)
    {
      SERIAL_SENDBIT1();
    }
    else
    {
      SERIAL_SENDBIT0();
    }

    // Shift bits along to check the next one
    channelData >>= 1;
  }

  // Remaining D16-D19
  for (j = 4; j > 0; j--)
    SERIAL_SENDBIT0();

  // Finished clocking data in
  SERIAL_ENABLE_HIGH();
  delayMicroseconds(1);
  //delay(2);

  digitalWrite(RCV_CHIP_SELECT, LOW);
  digitalWrite(RCV_CLK, LOW);
  digitalWrite(RCV_DATA, LOW);
}

void SERIAL_SENDBIT1()
{
  digitalWrite(RCV_CLK, LOW);
  delayMicroseconds(1);

  digitalWrite(RCV_DATA, HIGH);
  delayMicroseconds(1);
  digitalWrite(RCV_CLK, HIGH);
  delayMicroseconds(1);

  digitalWrite(RCV_CLK, LOW);
  delayMicroseconds(1);
}

void SERIAL_SENDBIT0()
{
  digitalWrite(RCV_CLK, LOW);
  delayMicroseconds(1);

  digitalWrite(RCV_DATA, LOW);
  delayMicroseconds(1);
  digitalWrite(RCV_CLK, HIGH);
  delayMicroseconds(1);

  digitalWrite(RCV_CLK, LOW);
  delayMicroseconds(1);
}

void SERIAL_ENABLE_LOW()
{
  delayMicroseconds(1);
  digitalWrite(RCV_CHIP_SELECT, LOW);
  delayMicroseconds(1);
}

void SERIAL_ENABLE_HIGH()
{
  delayMicroseconds(1);
  digitalWrite(RCV_CHIP_SELECT, HIGH);
  delayMicroseconds(1);
}
