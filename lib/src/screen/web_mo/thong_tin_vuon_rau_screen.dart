import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:dongphuc296web/src/extensions/extensions.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../data/model/device_model.dart';
import '../../data/model/sensor_model.dart';
import '../../util/colors.dart';
import '../../util/strings.dart';

class ThongTinVuonRauScreen extends StatefulWidget {
  const ThongTinVuonRauScreen({
    super.key,
  });

  @override
  ThongTinVuonRauScreenState createState() => ThongTinVuonRauScreenState();
}

class ThongTinVuonRauScreenState extends State<ThongTinVuonRauScreen> {
  double tds = 0;
  double disA = 0;
  double disB = 0;
  double disTDS = 0;
  double disIn = 0;
  double disDe = 0;
  double pH = 0;
  double temp = 0;

  bool isShowAlertTDS = false;
  bool isShowAlertTemp = false;
  bool isShowAlertWaterHeight = false;
  bool isShowAlertPlantDate = false;
  int numberOfPlantedDate = 0;

  final tdsController = TextEditingController();
  final disAController = TextEditingController();
  final disBController = TextEditingController();
  final disTDSController = TextEditingController();
  final disDeController = TextEditingController();
  final disInController = TextEditingController();
  final pHController = TextEditingController();
  final tempController = TextEditingController();

  final alertTdsController = TextEditingController();
  final alertTemperatureController = TextEditingController();
  final alertWaterHeightController = TextEditingController();
  final alertPlantDateController = TextEditingController();
  final alertController = TextEditingController();
  Map<String, String> mapAlertString = {
    'tds': '',
    'temp': '',
    'waterHeight': '',
    'plantDate': '',
  };

  DateTime selectedDate = DateTime.now();

  SensorModel sensorModelFromFB = SensorModel(
    tds: 0,
    disA: 0,
    disB: 0,
    disTDS: 0,
    disDe: 0,
    disIn: 0,
    temp: 0,
    pH: 0,
  );

  @override
  void initState() {
    super.initState();
    initRealTimeDB();
    // Next, initialize the controller. This returns a Future.
  }

  Future<void> initRealTimeDB() async {
    debugPrint('--------------------->>>>>>>>> initRealTimeDB ');

    DatabaseReference sensorRef = FirebaseDatabase.instance.ref('Node1/Sensor');
    sensorRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      updateSensorData(data);
    });
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    super.dispose();
    tdsController.dispose();
    disAController.dispose();
    disBController.dispose();
    disTDSController.dispose();
    disInController.dispose();
    disDeController.dispose();
    pHController.dispose();
    tempController.dispose();

    alertTdsController.dispose();
    alertTemperatureController.dispose();
    alertWaterHeightController.dispose();
    alertPlantDateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(textThongTinVuonRau)),
      // You must wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner until the
      // controller has finished initializing.
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // buildAlertWidget(),
              // Padding(
              //   padding: const EdgeInsets.all(10),
              //   child: Center(
              //     child: LoadingAnimationWidget.dotsTriangle(
              //       color: web296Pink300,
              //       size: 50,
              //     ),
              //   ),
              // ),
              // buildDateText(),
              // Padding(
              //   padding: const EdgeInsets.all(10),
              //   child: Center(
              //     child: LoadingAnimationWidget.dotsTriangle(
              //       color: web296Pink300,
              //       size: 50,
              //     ),
              //   ),
              // ),
              // buildSwitchButton(),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: LoadingAnimationWidget.dotsTriangle(
                    color: web296Pink300,
                    size: 50,
                  ),
                ),
              ),
              buildSensorText(),
            ]),
      )),
    );
  }

  Column buildSensorText() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // const Text(
          //   textSensorData,
          //   style: TextStyle(
          //       color: web296Pink300,
          //       fontSize: 25,
          //       fontWeight: FontWeight.bold),
          // ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                  child: Container(
                      child: SfRadialGauge()
              //         SfRadialGauge(axes: <RadialAxis>[
              //   RadialAxis(minimum: 0, maximum: 150, ranges: <GaugeRange>[
              //     GaugeRange(startValue: 0, endValue: 50, color: Colors.green),
              //     GaugeRange(
              //         startValue: 50, endValue: 100, color: Colors.orange),
              //     GaugeRange(startValue: 100, endValue: 150, color: Colors.red)
              //   ], pointers: <GaugePointer>[
              //     NeedlePointer(value: 90)
              //   ], annotations: <GaugeAnnotation>[
              //     GaugeAnnotation(
              //         widget: Container(
              //             child: Text('90.0',
              //                 style: TextStyle(
              //                     fontSize: 25, fontWeight: FontWeight.bold))),
              //         angle: 90,
              //         positionFactor: 0.5)
              //   ])
              // ])
                  )),
              buildItemRow(
                textNhietDo,
                tempController.text + 'C',
              ),
              const SizedBox(
                width: 10,
              ),
              buildItemRow(
                textTDSDinhDuong,
                tdsController.text,
              ),
              const SizedBox(
                width: 10,
              ),
              buildItemRow(
                textPH,
                pHController.text,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),

          Container(
            margin: const EdgeInsets.only(
                top: 50, bottom: 50, left: 100, right: 100),
            padding: const EdgeInsets.all(8),
            // height: 170.0,
            // width: 170.0,
            decoration: BoxDecoration(
                color: web296Pink50,
                border: Border.all(
                  color: Colors.black,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(10.0),
                gradient: LinearGradient(colors: [web296Pink75, web296Pink50]),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      blurRadius: 2.0,
                      offset: Offset(2.0, 2.0))
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  textMucNuoc,
                  style: TextStyle(fontSize: 40),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buildItemRow2(
                      textChatDinhDuong,
                      disTDSController.text,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    buildItemRow2(
                      textDungDichA,
                      disAController.text,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    buildItemRow2(
                      textDungDichB,
                      disBController.text,
                    ),
                    // const SizedBox(
                    //   width: 10,
                    // ),
                    // buildItemRow2(
                    //   textDungDichIn,
                    //   disInController.text,
                    // ),
                    // const SizedBox(
                    //   width: 10,
                    // ),
                    // buildItemRow2(
                    //   textDungDichDe,
                    //   disDeController.text,
                    // ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buildItemRow2(
                      textDungDichIn,
                      disInController.text,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    buildItemRow2(
                      textDungDichDe,
                      disDeController.text,
                    ),
                  ],
                ),
              ],
            ),
          )
        ]);
  }

  Widget buildItemRow(String name, String value) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: 170.0,
      width: 170.0,
      decoration: BoxDecoration(
          color: web296Pink100,
          border: Border.all(
            color: Colors.black,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
          gradient: LinearGradient(colors: [web296Pink300, web296Pink100]),
          boxShadow: [
            BoxShadow(
                color: Colors.grey, blurRadius: 2.0, offset: Offset(2.0, 2.0))
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            name,
            style: TextStyle(color: Colors.black, fontSize: 24),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            value,
            style: TextStyle(color: Colors.amber, fontSize: 30),
          )
        ],
      ),
    );
  }

  Widget buildItemRow2(String name, String value) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: 130.0,
      decoration: BoxDecoration(
          color: web296Pink100,
          border: Border.all(
            color: Colors.black,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
          gradient: LinearGradient(colors: [web296Pink300, web296Pink100]),
          boxShadow: [
            BoxShadow(
                color: Colors.grey, blurRadius: 2.0, offset: Offset(2.0, 2.0))
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            name,
            style: TextStyle(color: Colors.black, fontSize: 24),
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            value,
            style: TextStyle(color: Colors.lightBlue, fontSize: 30),
          )
        ],
      ),
    );
  }

  void updateSensorData(Object? data) {
    final map = data as Map<dynamic, dynamic>;
    setState(() {
      sensorModelFromFB = SensorModel.fromMap(map);
      tdsController.text = sensorModelFromFB.tds.toString();
      pHController.text = sensorModelFromFB.pH.toString();
      tempController.text = sensorModelFromFB.temp.toString();

      disAController.text = sensorModelFromFB.disA.toString();
      disBController.text = sensorModelFromFB.disB.toString();
      disInController.text = sensorModelFromFB.disIn.toString();
      disDeController.text = sensorModelFromFB.disDe.toString();
      disTDSController.text = sensorModelFromFB.disTDS.toString();

      debugPrint(
          '--------------------->>>>>>>>> updateSensorData: ${sensorModelToJson(sensorModelFromFB)} ');
    });
  }

  void pushSensorDataToFireBase(String key, SensorModel value) async {
    FirebaseDatabase.instance
        .ref('Node1/Sensor')
        .child(key)
        .set(value)
        .then((_) {
      debugPrint(
          '--------------------->>>>>>>>> updateRealtimeSensorData successsss ');
    }).catchError((error) {
      debugPrint(
          '--------------------->>>>>>>>> updateRealtimeSensorData fail: $error ');
    });
  }

  Widget buildAlertWidget() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            color: Colors.amber,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text(
                    textCurrentStatus,
                    style: TextStyle(
                        color: web296Pink300,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(alertController.text,
                      // '${alertTemperatureController.text}\n${alertTdsController.text}',
                      style:
                          const TextStyle(color: Colors.black, fontSize: 24)),
                ],
              ),
            ),
          )
        ]);
  }
}
