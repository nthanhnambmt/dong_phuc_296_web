import 'dart:convert';

class SensorModel {
  double? tds;
  double? disA;
  double? disB;
  double? disTDS;
  double? disIn;
  double? disDe;
  double? pH;
  double? temp;

  SensorModel({
    this.tds,
    this.disA,
    this.disB,
    this.disTDS,
    this.disIn,
    this.disDe,
    this.pH,
    this.temp,
  });

  factory SensorModel.fromMap(Map<dynamic, dynamic> json) => SensorModel(
        tds: json["TDS"],
        disA: json["distance_A"],
        disB: json["distance_B"],
        disTDS: json["distance_TDS"],
        disDe: json["distance_depH"],
        disIn: json["distance_inpH"],
        temp: json["temperature"],
        pH: json["pH"],
      );

  Map<String, dynamic> toMap() => {
        "TDS": tds,
        "distance_A": disA,
        "distance_B": disB,
        "distance_TDS": disTDS,
        "distance_depH": disDe,
        "distance_inpH": disIn,
        "temperature": temp,
        "pH": pH,
      };
}

SensorModel sensorModelFromJson(String str) {
  final jsonData = json.decode(str);
  return SensorModel.fromMap(jsonData);
}

String sensorModelToJson(SensorModel data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}
