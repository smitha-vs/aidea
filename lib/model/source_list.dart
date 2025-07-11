import 'dart:convert';
class Sources {
  List<IriSources> payload;
  String message;

  Sources({
    required this.payload,
    required this.message,
  });

  factory Sources.fromJson(Map<String, dynamic> json) => Sources(
    payload: List<IriSources>.from(json["payload"].map((x) => IriSources.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "payload": List<dynamic>.from(payload.map((x) => x.toJson())),
    "message": message,
  };
}
class IriSources {
  int sourceId;
  String irrigationType;
  IriSources({
    required this.sourceId,
    required this.irrigationType,
  });

  factory IriSources.fromJson(Map<String, dynamic> json) => IriSources(
    sourceId: json["sourceId"],
    irrigationType: json["irrigationType"],
  );

  Map<String, dynamic> toJson() => {
    "sourceId": sourceId,
    "irrigationType": irrigationType,
  };
}
