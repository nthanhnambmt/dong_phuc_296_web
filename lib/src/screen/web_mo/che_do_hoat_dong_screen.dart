import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../data/model/device_model.dart';
import '../../data/model/sensor_model.dart';
import '../../util/colors.dart';
import '../../util/strings.dart';
import '../../util/utils.dart';

class CheDoHoatDongScreen extends StatefulWidget {
  const CheDoHoatDongScreen({
    super.key,
  });

  @override
  CheDoHoatDongScreenState createState() => CheDoHoatDongScreenState();
}

class CheDoHoatDongScreenState extends State<CheDoHoatDongScreen> {
  bool swPumpA = false;
  bool swPumpAe = false;
  bool swPumpB = false;
  bool swPumpInpH = false;
  bool swPumpDepH = false;
  bool swPumpWater = false;
  bool swAuto = false;

  bool isShowAlertTDS = false;
  bool isShowAlertTemp = false;
  bool isShowAlertWaterHeight = false;
  bool isShowAlertPlantDate = false;
  int numberOfPlantedDate = 0;

  final tdsController = TextEditingController();
  final temperatureController = TextEditingController();
  final waterHeightController = TextEditingController();
  final humidityController = TextEditingController();

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

  DeviceModel deviceModelFromFB = DeviceModel(
    pumpA: 0,
    pumpB: 0,
    pumpAeration: 0,
    pumpInpH: 0,
    Mode: 0,
  );

  @override
  void initState() {
    super.initState();
    initRealTimeDB();
    // Next, initialize the controller. This returns a Future.
  }

  Future<void> initRealTimeDB() async {
    debugPrint('--------------------->>>>>>>>> initRealTimeDB ');
    DatabaseReference deviceRef = FirebaseDatabase.instance.ref('Node1/Device');
    deviceRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      updateDeviceData(data);
    });

    // try {
    //   final ref = FirebaseDatabase.instance.ref();
    //   final snapshot = await ref.child('Node1/Device').get();
    //   Utils.showAlertDialog(context, 'updateDeviceData:');
    //   if (snapshot.exists) {
    //     updateDeviceData(snapshot.value);
    //   } else {
    //     Utils.showAlertDialog(context, 'updateDeviceData FAIL:');
    //   }
    // } catch (e) {
    //   Utils.showAlertDialog(context, 'updateDeviceData FAIL: ${e}');
    // }
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    super.dispose();
    tdsController.dispose();
    temperatureController.dispose();
    waterHeightController.dispose();
    humidityController.dispose();

    alertTdsController.dispose();
    alertTemperatureController.dispose();
    alertWaterHeightController.dispose();
    alertPlantDateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(cheDoHoatDong)),
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
              Padding(
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: LoadingAnimationWidget.dotsTriangle(
                    color: web296Pink300,
                    size: 50,
                  ),
                ),
              ),
              buildSwitchButton(),
              // Padding(
              //   padding: const EdgeInsets.all(10),
              //   child: Center(
              //     child: LoadingAnimationWidget.dotsTriangle(
              //       color: web296Pink300,
              //       size: 50,
              //     ),
              //   ),
              // ),
              // buildSensorText(),
            ]),
      )),
    );
  }

  Column buildDateText() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            cheDoHoatDong,
            style: TextStyle(
                color: web296Pink300,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const Text(
                textInputPlantDate,
                style: TextStyle(color: Colors.black, fontSize: 24),
              ),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () => dateSelected(context),
                child: Text(
                  "${selectedDate.toLocal()}".split(' ')[0],
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Expanded(
                flex: 1, // you can play with this value, by default it is 1
                child: Text(
                  textNumberOfPlantedDate,
                  style: TextStyle(color: Colors.black, fontSize: 24),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  numberOfPlantedDate.toString(),
                  style: const TextStyle(color: Colors.black, fontSize: 24),
                ),
              ),
            ],
          ),
        ]);
  }

  Widget buildSwitchButton() {
    // return NineGridView(
    //   type: NineGridType.normal,
    //   itemCount: 6,
    //   itemBuilder: (BuildContext context, int index) {
    //
    //     return Row(
    //       children: [
    //         const Expanded(
    //           flex: 1, // you can play with this value, by default it is 1
    //           child: Text(
    //             textPumpA,
    //             style: TextStyle(color: Colors.black, fontSize: 24),
    //           ),
    //         ),
    //         Expanded(
    //           flex: 1,
    //           child: FlutterSwitch(
    //             width: 125.0,
    //             height: 35.0,
    //             valueFontSize: 15.0,
    //             toggleSize: 45.0,
    //             value: swPumpA,
    //             borderRadius: 30.0,
    //             padding: 8.0,
    //             showOnOff: true,
    //             onToggle: (val) {
    //               setState(() {
    //                 swPumpA = val;
    //                 pushDeviceDataToFireBase('pump_A', swPumpA == true ? 1 : 0);
    //               });
    //             },
    //           ),
    //         ),
    //       ],
    //     );
    //   },
    // );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                cheDoHoatDongAuto,
                style: TextStyle(
                    color: web296Pink300,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 20,
              ),
              FlutterSwitch(
                width: 125.0,
                height: 35.0,
                valueFontSize: 15.0,
                toggleSize: 45.0,
                value: swAuto,
                borderRadius: 30.0,
                padding: 8.0,
                showOnOff: true,
                onToggle: (val) {
                  setState(() {
                    swAuto = val;
                    pushDeviceDataToFireBase('Mode', swAuto == true ? 1 : 0);
                  });
                },
              )
            ]),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildItemRow(
              textPumpA,
              'pump_A',
              swPumpA,
            ),
            const SizedBox(
              width: 10,
            ),
            buildItemRow(
              textPumpB,
              'pump_B',
              swPumpB,
            ),
            const SizedBox(
              width: 10,
            ),
            buildItemRow(
              textPumpAe,
              'pump_aeration',
              swPumpAe,
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildItemRow(
              textPumpInpH,
              'pump_inpH',
              swPumpInpH,
            ),
            const SizedBox(
              width: 10,
            ),
            buildItemRow(
              textPumpDepH,
              'pump_depH',
              swPumpDepH,
            ),
            const SizedBox(
              width: 10,
            ),
            buildItemRow(
              textPumpWater,
              'pump_water',
              swPumpWater,
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget buildItemRow(String name, String key, bool value) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: 200.0,
      width: 200.0,
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
          FlutterSwitch(
            disabled: swAuto,
            width: 125.0,
            height: 35.0,
            valueFontSize: 15.0,
            toggleSize: 45.0,
            value: value,
            borderRadius: 30.0,
            padding: 8.0,
            showOnOff: true,
            onToggle: (val) {
              setState(() {
                value = val;
                pushDeviceDataToFireBase(key, value == true ? 1 : 0);
              });
            },
          )
        ],
      ),
    );
  }

  void updateDeviceData(Object? data) {
    final map = data as Map<dynamic, dynamic>;
    setState(() {
      deviceModelFromFB = DeviceModel.fromMap(map);
      swPumpA = deviceModelFromFB.pumpA == 1;
      swPumpB = deviceModelFromFB.pumpB == 1;
      swPumpAe = deviceModelFromFB.pumpAeration == 1;
      swPumpInpH = deviceModelFromFB.pumpInpH == 1;
      swPumpDepH = deviceModelFromFB.pumpDepH == 1;
      swPumpWater = deviceModelFromFB.pumpWater == 1;
      swAuto = deviceModelFromFB.Mode == 1;

      debugPrint(
          '--------------------->>>>>>>>> updateDeviceData: ${deviceModelToJson(deviceModelFromFB)} ');
    });
  }

  void showError(String error) {
    Utils.showAlertDialog(context, error);
  }

  void updateAlertText() {
    if (!isShowAlertPlantDate &&
        !isShowAlertWaterHeight &&
        !isShowAlertTemp &&
        !isShowAlertTDS) {
      alertController.text = textCurrentStatusOk;
    } else {
      alertController.text =
          '${alertTdsController.text}${alertTemperatureController.text}${alertWaterHeightController.text}${alertPlantDateController.text}';
    }
  }

  void dateSelected(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        numberOfPlantedDate = DateTime.now().difference(selectedDate).inDays;

        //Check plant date
        if (numberOfPlantedDate > 35) {
          isShowAlertPlantDate = true;
          alertPlantDateController.text = '$textAlertPlantDate\n';
        } else {
          isShowAlertPlantDate = false;
          alertPlantDateController.text = '';
        }

        updateAlertText();
      });
    }
  }

  void pushDeviceDataToFireBase(String key, int value) async {
    FirebaseDatabase.instance
        .ref('Node1/Device')
        .child(key)
        .set(value)
        .then((_) {
      debugPrint(
          '--------------------->>>>>>>>> updateRealtimeDeviceData successsss ');
    }).catchError((error) {
      debugPrint(
          '--------------------->>>>>>>>> updateRealtimeDeviceData fail: $error ');
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
