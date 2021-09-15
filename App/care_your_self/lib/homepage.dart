import 'package:flutter/material.dart';
import 'package:care_your_self/utils/routes.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  String server = 'broker.hivemq.com';
  int port = 1883;
  String subTopictemp =  '/iot/user1/data/temp';
  String subTopichumi =  '/iot/user1/data/humi';
  String subTopicheart =  '/iot/user1/data/heart';
  String subTopicspo2 =  '/iot/user1/data/spo2';
  String subTopicbody =  '/iot/user1/data/body';
  var temp;
  var humi;
  var heart;
  var spo2;
  var body;
  TextEditingController tempmqtt = new TextEditingController();
  TextEditingController humimqtt = new TextEditingController();
  TextEditingController heartmqtt = new TextEditingController();
  TextEditingController spo2mqtt = new TextEditingController();
  TextEditingController bodymqtt = new TextEditingController();
  // connection succeeded
  void onConnected() {
    print('Connected');
  }

// unconnected
  void onDisconnected() {
    print('Disconnected');
  }

// subscribe to topic succeeded
  void onSubscribed(String topic) {
    print('Subscribed topic: $topic');
  }

// subscribe to topic failed
  void onSubscribeFail(String topic) {
    print('Failed to subscribe $topic');
  }

// unsubscribe succeeded
  void onUnsubscribed(String topic) {
    print('Unsubscribed topic: $topic');
  }

// PING response received
  void pong() {
    print('Ping response client callback invoked');
  }

  Future<void> connect() async {
    MqttServerClient client =
    MqttServerClient.withPort('broker.hivemq.com', 'user1_client', 1883);
    client.logging(on: true);
    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    client.onUnsubscribed = onUnsubscribed;
    client.onSubscribed = onSubscribed;
    client.onSubscribeFail = onSubscribeFail;
    client.pongCallback = pong;

    try {
      await client.connect();
    } catch (e) {
      print('Exception: $e');
      client.disconnect();
    }

    Stream<List<MqttReceivedMessage<MqttMessage>>> mqttSubscribe(String topic) {
      client.subscribe(topic, MqttQos.exactlyOnce);
      return client.updates;
    }
    client.subscribe(subTopictemp, MqttQos.atLeastOnce);
    client.subscribe(subTopichumi, MqttQos.atLeastOnce);
    client.subscribe(subTopicheart, MqttQos.atLeastOnce);
    client.subscribe(subTopicspo2, MqttQos.atLeastOnce);
    client.subscribe(subTopicbody, MqttQos.atLeastOnce);
    client.updates!.listen((dynamic c) {
      final MqttPublishMessage recMess = c[0].payload;
      final pt = MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      temp = pt;
    });
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                "assets/images/homepage.png",
                fit: BoxFit.fill,
                height: 200,
                width: 300,
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            "assets/images/roomtemperature.png",
                            height: 60,
                            width: 80,
                          ),
                          Text(
                            "Room Temperature",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 20),
                          Container(
                            child: TextFormField(
                                controller: tempmqtt,
                                onChanged: (content) {
                                  tempmqtt.text = temp;
                                },
                                textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: ""
                              ),
                              style: TextStyle(
                                fontSize: 16,
                              )
                            ),
                             height: 40,
                             width: 60,
                           ),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            "assets/images/humidity.png",
                            height: 60,
                            width: 80,
                          ),
                          Text(
                            "Room Humidity",
                            // textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 45),
                          Container(
                            child: TextField(
                                controller: humimqtt,
                                onChanged: (content) {
                                  humimqtt.text = humi;
                                },
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: ""
                                ),
                                style: TextStyle(
                                  fontSize: 16,
                                )
                            ),
                            height: 40,
                            width: 60,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            "assets/images/clock.png",
                            height: 60,
                            width: 80,
                          ),
                          Text(
                            "Heart Rate",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 79),
                          Container(
                            child: TextField(
                                controller: heartmqtt,
                                onChanged: (content) {
                                  heartmqtt.text = heart;
                                },
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: ""
                                ),
                                style: TextStyle(
                                  fontSize: 16,
                                )
                            ),
                            height: 40,
                            width: 60,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            "assets/images/heart.png",
                            height: 60,
                            width: 80,
                          ),
                          Text(
                            "Blood Oxygen",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 56),
                          Container(
                            child: TextField(
                                controller: spo2mqtt,
                                onChanged: (content) {
                                  spo2mqtt.text = spo2;
                                },
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: ""
                                ),
                                style: TextStyle(
                                  fontSize: 16,
                                )
                            ),
                            height: 40,
                            width: 60,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            "assets/images/bodytemperature.png",
                            height: 60,
                            width: 80,
                          ),
                          Text(
                            "Body Temperature",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 25),
                          Container(
                            child: TextField(
                                controller: bodymqtt,
                                onChanged: (content) {
                                  bodymqtt.text = body;
                                },
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: ""
                                ),
                                style: TextStyle(
                                  fontSize: 16,
                                )
                            ),
                            height: 40,
                            width: 60,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      ElevatedButton(
                        child: Text("GET DATA"),
                        style: TextButton.styleFrom(minimumSize: Size(150, 40)),
                        onPressed: () {
                          connect();
                        },
                      ),
                    ],
                  )
              ),
            ],
          ),
        ));
  }
}