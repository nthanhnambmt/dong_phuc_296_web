import 'dart:convert';

class DeviceModel {
  int? pumpA;
  int? pumpB;
  int? pumpAeration;
  int? pumpInpH;
  int? pumpDepH;
  int? pumpWater;
  int? Mode;

  DeviceModel({
    this.pumpA,
    this.pumpB,
    this.pumpAeration,
    this.pumpInpH,
    this.pumpDepH,
    this.pumpWater,
    this.Mode,
  });

  factory DeviceModel.fromMap(Map<dynamic, dynamic> json) => DeviceModel(
        pumpA: json["pump_A"],
        pumpB: json["pump_B"],
        pumpAeration: json["pump_aeration"],
        pumpDepH: json["pump_depH"],
        pumpInpH: json["pump_inpH"],
        pumpWater: json["pump_water"],
        Mode: json["Mode"],
      );

  Map<String, dynamic> toMap() => {
        "pump_A": pumpA,
        "pump_B": pumpB,
        "pump_aeration": pumpAeration,
        "pump_depH": pumpDepH,
        "pump_inpH": pumpInpH,
        "pump_water": pumpWater,
        "Mode": Mode,
      };
}

DeviceModel deviceModelFromJson(String str) {
  final jsonData = json.decode(str);
  return DeviceModel.fromMap(jsonData);
}

String deviceModelToJson(DeviceModel data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}
