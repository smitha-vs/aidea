class ClusterInfoCard {
  final String message;
  final int completed;
  final int ongoing;
  final int notStarted;
  final List<Payload> payload;

  ClusterInfoCard({
    required this.message,
    required this.completed,
    required this.ongoing,
    required this.notStarted,
    required this.payload,
  });

  factory ClusterInfoCard.fromJson(Map<String, dynamic> json) =>
      ClusterInfoCard(
        message: json["message"],
        completed: json["completed"],
        ongoing: json["ongoing"],
        notStarted: json["notStarted"],
        payload: List<Payload>.from(
          json["payload"].map((x) => Payload.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "message": message,
    "completed": completed,
    "ongoing": ongoing,
    "notStarted": notStarted,
    "payload": List<dynamic>.from(payload.map((x) => x.toJson())),
  };
}

class Payload {
  final String keyplotId;
  final Village village;
  final Localbody localbody;
  final String blockcode;
  final String survyno;
  final double area;
  final int clusterId;
  final ClusterType clusterType;
  final Status status;

  Payload({
    required this.keyplotId,
    required this.village,
    required this.localbody,
    required this.blockcode,
    required this.survyno,
    required this.area,
    required this.clusterId,
    required this.clusterType,
    required this.status,
  });

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
    keyplotId: json["keyplotId"],
    village: villageValues.map[json["village"]]!,
    localbody: localbodyValues.map[json["localbody"]]!,
    blockcode: json["blockcode"],
    survyno: json["survyno"],
    area: (json["area"] ?? 0).toDouble(),
    clusterId: json["clusterId"],
    clusterType: clusterTypeValues.map[json["clusterType"]]!,
    status: statusValues.map[json["status"]]!,
  );

  Map<String, dynamic> toJson() => {
    "keyplotId": keyplotId,
    "village": villageValues.reverse[village],
    "localbody": localbodyValues.reverse[localbody],
    "blockcode": blockcode,
    "survyno": survyno,
    "area": area,
    "clusterId": clusterId,
    "clusterType": clusterTypeValues.reverse[clusterType],
    "status": statusValues.reverse[status],
  };
}

// Enums and their string mappers

enum ClusterType { DRY, WET }

final clusterTypeValues = EnumValues({
  "dry": ClusterType.DRY,
  "wet": ClusterType.WET,
});

enum Localbody { KILIMANOOR, NAGAROOR }

final localbodyValues = EnumValues({
  "Kilimanoor": Localbody.KILIMANOOR,
  "Nagaroor": Localbody.NAGAROOR,
});

enum Status { NOT_STARTED, ON_GOING }

final statusValues = EnumValues({
  "Not Started": Status.NOT_STARTED,
  "On Going": Status.ON_GOING,
});

enum Village { KILIMANOOR, NAGAROOR, VELLALLOOR }

final villageValues = EnumValues({
  "KILIMANOOR": Village.KILIMANOOR,
  "NAGAROOR": Village.NAGAROOR,
  "VELLALLOOR": Village.VELLALLOOR,
});

class EnumValues<T> {
  final Map<String, T> map;
  Map<T, String>? _reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse =>
      _reverseMap ??= map.map((k, v) => MapEntry(v, k));
}
