// To parse this JSON data, do
//
//     final availablePlotList = availablePlotListFromJson(jsonString);

import 'dart:convert';

AvailablePlotList availablePlotListFromJson(String str) => AvailablePlotList.fromJson(json.decode(str));

String availablePlotListToJson(AvailablePlotList data) => json.encode(data.toJson());

class AvailablePlotList {
  List<Available> payload;
  String message;

  AvailablePlotList({
    required this.payload,
    required this.message,
  });

  factory AvailablePlotList.fromJson(Map<String, dynamic> json) => AvailablePlotList(
    payload: List<Available>.from(json["payload"].map((x) => Available.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "payload": List<dynamic>.from(payload.map((x) => x.toJson())),
    "message": message,
  };
}

class Available {
  String cceAvailablePlotId;
  String plotId;
  int clusterId;
  int zoneId;
  int cropId;
  String cceSourceType;
  String addedBy;
  DateTime createdAt;
  DateTime agriStartYear;
  DateTime agriEndYear;
  bool isActive;

  Available({
    required this.cceAvailablePlotId,
    required this.plotId,
    required this.clusterId,
    required this.zoneId,
    required this.cropId,
    required this.cceSourceType,
    required this.addedBy,
    required this.createdAt,
    required this.agriStartYear,
    required this.agriEndYear,
    required this.isActive,
  });

  factory Available.fromJson(Map<String, dynamic> json) => Available(
    cceAvailablePlotId: json["cceAvailablePlotId"],
    plotId: json["plotId"],
    clusterId: json["clusterId"],
    zoneId: json["zoneId"],
    cropId: json["cropId"],
    cceSourceType: json["cceSourceType"],
    addedBy: json["addedBy"],
    createdAt: DateTime.parse(json["createdAt"]),
    agriStartYear: DateTime.parse(json["agriStartYear"]),
    agriEndYear: DateTime.parse(json["agriEndYear"]),
    isActive: json["isActive"],
  );

  Map<String, dynamic> toJson() => {
    "cceAvailablePlotId": cceAvailablePlotId,
    "plotId": plotId,
    "clusterId": clusterId,
    "zoneId": zoneId,
    "cropId": cropId,
    "cceSourceType": cceSourceType,
    "addedBy": addedBy,
    "createdAt": createdAt.toIso8601String(),
    "agriStartYear": "${agriStartYear.year.toString().padLeft(4, '0')}-${agriStartYear.month.toString().padLeft(2, '0')}-${agriStartYear.day.toString().padLeft(2, '0')}",
    "agriEndYear": "${agriEndYear.year.toString().padLeft(4, '0')}-${agriEndYear.month.toString().padLeft(2, '0')}-${agriEndYear.day.toString().padLeft(2, '0')}",
    "isActive": isActive,
  };
}
