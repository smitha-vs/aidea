import 'cluster_label_area.dart';

class ClusterList {
  String message;
  int completed;
  int ongoing;
  int notStarted;
  int underreview;
  List<ClusterPayload> payload;
  ClusterList({
    required this.message,
    required this.completed,
    required this.ongoing,
    required this.notStarted,
    required this.underreview,
    required this.payload,
  });
  factory ClusterList.fromJson(Map<String, dynamic> json) => ClusterList(
    message: json["message"],
    completed: json["completed"],
    ongoing: json["ongoing"],
    notStarted: json["notStarted"],
    underreview: json["underreview"],
    payload: List<ClusterPayload>.from(json["payload"].map((x) => ClusterPayload.fromJson(x))),
  );
  Map<String, dynamic> toJson() => {
    "message": message,
    "completed": completed,
    "ongoing": ongoing,
    "notStarted": notStarted,
    "underreview": underreview,
    "payload": List<dynamic>.from(payload.map((x) => x.toJson())),
  };
}
class ClusterPayload{
  int clusterNo;
  String keyplotId;
  String village;
  String localbody;
  String blockcode;
  String survyno;
  double area;
  int clusterId;
  ClusterType clusterType;
  Status status;
  bool cce;
  ClusterPayload({
    required this.clusterNo,
    required this.keyplotId,
    required this.village,
    required this.localbody,
    required this.blockcode,
    required this.survyno,
    required this.area,
    required this.clusterId,
    required this.clusterType,
    required this.status,
    required this.cce,
  });
  factory ClusterPayload.fromJson(Map<String, dynamic> json) => ClusterPayload(
    clusterNo: json["clusterNo"],
    keyplotId: json["keyplotId"],
    village: json["village"] ?? "Village not found", // now string
    localbody: json["localbody"] ?? "Local body not found", // dynamic string
    clusterType: clusterTypeValues.map[json["clusterType"]] ?? ClusterType.DRY,
    status: statusValues.map[json["status"]] ?? Status.NOT_STARTED,
    blockcode: json["blockcode"],
    survyno: json["survyno"],
    area: json["area"]?.toDouble(),
    clusterId: json["clusterId"],
       cce: json["cce"],
  );
  Map<String, dynamic> toJson() => {
    "clusterNo": clusterNo,
    "keyplotId": keyplotId,
    "village": village, // string
    "localbody": localbody,
    "blockcode": blockcode,
    "survyno": survyno,
    "area": area,
    "clusterId": clusterId,
    "clusterType": clusterTypeValues.reverse[clusterType],
    "status": statusValues.reverse[status],
    "cce": cce,
  };
}
enum ClusterType {
  DRY,
  WET
}
final clusterTypeValues = EnumValues({
  "dry": ClusterType.DRY,
  "wet": ClusterType.WET
});

enum Status {
  NOT_STARTED,
  ON_GOING,
  UNDER_REVIEW,
  COMPLETED
}
final statusValues = EnumValues({
  "Not Started": Status.NOT_STARTED,
  "On Going": Status.ON_GOING,
  "Under Review": Status.UNDER_REVIEW,
  "Completed": Status.COMPLETED,
});
enum Village {
  KILIMANOOR,
  NAGAROOR,
  VELLALLOOR
}
final villageValues = EnumValues({
  "KILIMANOOR": Village.KILIMANOOR,
  "NAGAROOR": Village.NAGAROOR,
  "VELLALLOOR": Village.VELLALLOOR
});
class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
class ClusterSidePlotData {
  final Map<String, List<DirectionLabel >> labels;
  final Map<String, double> totalArea;
  List<Crop> crops;
  final int clusterId;

  ClusterSidePlotData({
    required this.labels,
    required this.totalArea,
    required this.clusterId,
    required this.crops,
  });

  factory ClusterSidePlotData.fromJson(Map<String, dynamic> json) {
    return ClusterSidePlotData(
      totalArea: Map<String, double>.from(json['total_area']),
      clusterId: json['clusterId'],
      crops: json["crops"] != null
          ? List<Crop>.from(json["crops"].map((x) => Crop.fromJson(x)))
          : [],
      labels: (json['labels'] as Map<String, dynamic>).map((direction, plots) {
        return MapEntry(
          direction,
          (plots as List)
              .map((plot) => DirectionLabel .fromJson(plot))
              .toList(),
        );
      }),
    );
  }
}
class DirectionLabel {
  final double area;
  final int clusterPlotId;
  final String svNo;

  DirectionLabel({
    required this.area,
    required this.clusterPlotId,
    required this.svNo,
  });

  factory DirectionLabel.fromJson(Map<String, dynamic> json) {
    return DirectionLabel(
      area: json['area'].toDouble(),
      clusterPlotId: json['cluster_plot_id'],
      svNo: json['svno'],
    );
  }
}
