// ignore_for_file: unused_local_variable
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:syncfusion_flutter_charts/charts.dart' as charts;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_school/components/change_mode.dart';
import 'package:my_school/components/dual_display.dart';
import 'package:my_school/components/on_off.dart';
import 'dart:async';

import 'package:my_school/components/on_offtile.dart';

class ControlScreen extends StatefulWidget {
  const ControlScreen({super.key});

  @override
  State<ControlScreen> createState() => _ControlScreenState();
}

class _ControlScreenState extends State<ControlScreen> {
  bool light_mode = false;
  bool light_state = false;

  bool fan_mode = false;
  bool fan_state = false;

  bool humidifier_mode = false;
  bool humidifier_state = false;

  bool servo_mode = false;
  bool servo_state = false;

  int light_level = 0;
  int dust = 0;
  double temp = 0;
  double humidity = 0;
  double ppm = 0;
  bool is_rain = false;
  bool is_fire = false;
  List<ChartDetails> chart_data = [];

  String mess = "";
  bool hmess = false, dmess = false;

  final DatabaseReference _ref = FirebaseDatabase.instance.ref();
  Map<dynamic, dynamic>? _data;

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _fetchData();
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      _fetchData();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _fetchData() async {
    DatabaseEvent event = await _ref.once();
    _data = event.snapshot.value as Map<dynamic, dynamic>;
    setState(() {
      light_level = _data!['light-level'];
      dust = _data!['dust-density'].toInt();
      temp = _data!['temperature-celsius'].toDouble();
      humidity = _data!['humidity'].toDouble();
      is_rain = _data!['is-rain'];
      is_fire = _data!['is-fire'];
      ppm = _data!['ppm'].toDouble();
      List<dynamic> jsonData = _data!["chart-data"];
      chart_data = jsonData
          .map((data) => ChartDetails(
                data['day'].toString(),
                data['temp'],
                data['humid'],
              ))
          .toList();

      if (!light_mode) {
        light_state = _data!['light-state'] == "on";
      }
      if (!fan_mode) {
        fan_state = _data!['fan-state'] == "off";
      }
      if (!humidifier_mode) {
        humidifier_state = _data!['humidifier-state'] == "on";
      }
      if (!servo_mode) {
        servo_state = _data!['door-state'] == "close";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        const SizedBox(height: 5),

        //Light Control
        ChangeMode(
            onAuto: () {
              setState(() {
                light_mode = false;
              });
              _ref.child("light-mode").set("auto");
            },
            onManual: () {
              setState(() {
                light_mode = true;
              });
              _ref.child("light-mode").set("manual");
            },
            mode: light_mode,
            title: "LIGHTS CONTROL"),
        const SizedBox(height: 3),
        OnOff(
          state: light_state,
          title: "LIGHT STATUS",
          changeState: () {
            if (light_mode) {
              if (light_state) {
                _ref.child('light-state').set('off');
                setState(() {
                  light_state = false;
                });
              } else {
                _ref.child('light-state').set('on');
                setState(() {
                  light_state = true;
                });
              }
            }
          },
        ),

        const SizedBox(height: 5),

        // Fan Control
        ChangeMode(
            onAuto: () {
              setState(() {
                fan_mode = false;
              });
              _ref.child("fan-mode").set("auto");
            },
            onManual: () {
              setState(() {
                fan_mode = true;
              });
              _ref.child("fan-mode").set("manual");
            },
            mode: fan_mode,
            title: "FAN CONTROL"),
        const SizedBox(height: 3),
        OnOff(
          state: fan_state,
          title: "FAN STATUS",
          changeState: () {
            if (fan_mode) {
              if (fan_state) {
                _ref.child('fan-state').set('on');
                setState(() {
                  fan_state = false;
                });
              } else {
                _ref.child('fan-state').set('off');
                setState(() {
                  fan_state = true;
                });
              }
            }
          },
        ),

        const SizedBox(height: 5),

        //Humidifier Control
        ChangeMode(
            onAuto: () {
              setState(() {
                humidifier_mode = false;
              });
              _ref.child("humidifier-mode").set("auto");
            },
            onManual: () {
              setState(() {
                humidifier_mode = true;
              });
              _ref.child("humidifier-mode").set("manual");
            },
            mode: humidifier_mode,
            title: "HUMIDIFIER CONTROL"),
        const SizedBox(height: 3),
        OnOff(
          state: humidifier_state,
          title: "HUMIDIFIER STATUS",
          changeState: () {
            if (humidifier_mode) {
              if (humidifier_state) {
                _ref.child('humidifier-state').set('off');
                setState(() {
                  humidifier_state = false;
                });
              } else {
                _ref.child('humidifier-state').set('on');
                setState(() {
                  humidifier_state = true;
                });
              }
            }
          },
        ),

        const SizedBox(height: 5),

        // Window Control
        ChangeMode(
            onAuto: () {
              setState(() {
                servo_mode = false;
              });
              _ref.child("servo-mode").set("auto");
            },
            onManual: () {
              setState(() {
                servo_mode = true;
              });
              _ref.child("servo-mode").set("manual");
            },
            mode: servo_mode,
            title: "WINDOW CONTROL"),
        OnOffTile(
            leftClick: () async {
              if (servo_mode) {
                _ref.child('door-state').set('open');
                setState(() {
                  servo_state = false;
                });
              }
            },
            rightClick: () async {
              if (servo_mode) {
                _ref.child('door-state').set('close');
                setState(() {
                  servo_state = true;
                });
              }
            },
            leftTitle: "OPEN",
            rightTitle: "CLOSE",
            state: servo_state),

        const Divider(color: Colors.black, thickness: 1.5),
        const SizedBox(height: 3),

        DualDisplay(
            leftText: "LIGHT LEVEL",
            leftValue: "$light_level lx",
            rightText: "DUST DENSITY",
            rightValue: "$dust µm/m³"),
        DualDisplay(
            leftText: "TEMPERATURE ᵒC",
            leftValue: "$tempᵒC",
            rightText: "HUMIDITY",
            rightValue: "$humidity%"),

        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: EdgeInsets.all(3.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    SizedBox(
                        width: screenWidth * 0.92,
                        height: screenHeight * 0.038,
                        child: Container(
                          padding: EdgeInsets.all(3.5),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 2)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "AIR QUALITY",
                                style: GoogleFonts.robotoMono(
                                    color: Colors.grey,
                                    letterSpacing: .1,
                                    fontWeight: FontWeight.w700,
                                    fontSize: screenWidth * 0.03),
                              ),
                              Text(
                                "$ppm ppm",
                                style: GoogleFonts.robotoMono(
                                    color: Colors.black,
                                    letterSpacing: .1,
                                    fontWeight: FontWeight.w700,
                                    fontSize: screenWidth * 0.03),
                              ),
                            ],
                          ),
                        ))
                  ],
                )
              ],
            ),
          ),
        ]),

        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: EdgeInsets.all(3.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    SizedBox(
                        width: screenWidth * 0.92,
                        height: screenHeight * 0.038,
                        child: Container(
                          padding: EdgeInsets.all(3.5),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 2)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "ENVIRONMENTAL STATUS",
                                style: GoogleFonts.robotoMono(
                                    color: Colors.grey,
                                    letterSpacing: .1,
                                    fontWeight: FontWeight.w700,
                                    fontSize: screenWidth * 0.03),
                              ),
                              Row(children: [
                                Text(
                                  is_rain == true ? "🌧️" : "",
                                  style: GoogleFonts.robotoMono(
                                      color: Colors.black,
                                      letterSpacing: .1,
                                      fontWeight: FontWeight.w700,
                                      fontSize: screenWidth * 0.04),
                                ),
                                Text(
                                  is_fire == true ? "🔥" : "",
                                  style: GoogleFonts.robotoMono(
                                      color: Colors.black,
                                      letterSpacing: .1,
                                      fontWeight: FontWeight.w700,
                                      fontSize: screenWidth * 0.04),
                                )
                              ]),
                            ],
                          ),
                        ))
                  ],
                )
              ],
            ),
          ),
        ]),

        const SizedBox(height: 5),
        const Divider(color: Colors.black, thickness: 1.5),
        const SizedBox(height: 5),
        chart(screenWidth, screenHeight),
        chatbox(screenWidth, screenHeight)
      ],
    );
  }

  Widget chart(double screenWidth, double screenHeight) {
    return SafeArea(
        child: Center(
            child: Container(
                height: screenHeight * 0.29,
                width: screenWidth,
                child: charts.SfCartesianChart(
                    enableAxisAnimation: true,
                    primaryXAxis: charts.CategoryAxis(
                      labelPlacement: charts.LabelPlacement.onTicks,
                    ),
                    primaryYAxis: charts.NumericAxis(
                      minimum: 0,
                      maximum: 100,
                    ),
                    legend: charts.Legend(
                        isVisible: true,
                        position: charts.LegendPosition.bottom),
                    series: <charts.LineSeries<ChartDetails, String>>[
                      charts.LineSeries<ChartDetails, String>(
                          name: "Temp (ᵒC)",
                          color: Colors.orange[700],
                          dataSource: chart_data,
                          xValueMapper: (ChartDetails data, _) => data.day,
                          yValueMapper: (ChartDetails data, _) => data.temp),
                      charts.LineSeries<ChartDetails, String>(
                          name: "Humidity (%)",
                          color: Colors.blue[400],
                          dataSource: chart_data,
                          xValueMapper: (ChartDetails data, _) => data.day,
                          yValueMapper: (ChartDetails data, _) => data.humid),
                    ]))));
  }

  Widget chatbox(double screenWidth, double screenHeight) {
    DatabaseReference dataReference = FirebaseDatabase.instance.ref();

    dataReference.child('air-purifier-state').onValue.listen((event) {
      if (event.snapshot.value.toString() == "on") {
        setState(() {
          mess =
              "Dust density exceeds the safety threshold. Turning the air purifier on";
          dmess = true;
        });
      } else {
        dmess = false;
        if (!hmess) mess = "";
      }
    });

    dataReference.child('dehumidifier-state').onValue.listen((event) {
      if (event.snapshot.value.toString() == "on") {
        setState(() {
          mess =
              "Humidity exceeds the safety threshold. Turning the dehumidifier on";
          hmess = true;
        });
      } else {
        hmess = false;
        if (!dmess) mess = "";
      }
    });

    return Container(
        width: screenWidth * 0.9,
        height: screenHeight * 0.04,
        decoration: BoxDecoration(color: Color(0xFF25262b)),
        child: Center(
            child: Text(
          "$mess",
          textAlign: TextAlign.center,
          style: GoogleFonts.robotoCondensed(
              color: Colors.red,
              fontWeight: FontWeight.w700,
              fontSize: screenWidth * 0.028),
        )));
  }
}

class ChartDetails {
  ChartDetails(
    this.day,
    this.temp,
    this.humid,
  );
  final String day;
  final int temp;
  final int humid;
}
