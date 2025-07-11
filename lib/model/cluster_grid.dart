// class ClusterList {
//   String message;
//   int completed;
//   int ongoing;
//   int notStarted;
//   int underreview;
//   List<ClusterPayload> payload;
//   ClusterList({
//     required this.message,
//     required this.completed,
//     required this.ongoing,
//     required this.notStarted,
//     required this.underreview,
//     required this.payload,
//   });
//   factory ClusterList.fromJson(Map<String, dynamic> json) => ClusterList(
//     message: json["message"],
//     completed: json["completed"],
//     ongoing: json["ongoing"],
//     notStarted: json["notStarted"],
//     underreview: json["underreview"],
//     payload: List<ClusterPayload>.from(json["payload"].map((x) => ClusterPayload.fromJson(x))),
//   );
//   Map<String, dynamic> toJson() => {
//     "message": message,
//     "completed": completed,
//     "ongoing": ongoing,
//     "notStarted": notStarted,
//     "underreview": underreview,
//     "payload": List<dynamic>.from(payload.map((x) => x.toJson())),
//   };
// }
// class ClusterPayload{
//   int clusterNo;
//   String keyplotId;
//   Village village;
//   Localbody localbody;
//   String blockcode;
//   String survyno;
//   double area;
//   int clusterId;
//   ClusterType clusterType;
//   Status status;
//   bool cce;
//   ClusterPayload({
//     required this.clusterNo,
//     required this.keyplotId,
//     required this.village,
//     required this.localbody,
//     required this.blockcode,
//     required this.survyno,
//     required this.area,
//     required this.clusterId,
//     required this.clusterType,
//     required this.status,
//     required this.cce,
//   });
//   factory ClusterPayload.fromJson(Map<String, dynamic> json) => ClusterPayload(
//     clusterNo: json["clusterNo"],
//     keyplotId: json["keyplotId"],
//     village: villageValues.map[json["village"]]!,
//     localbody: localbodyValues.map[json["localbody"]]!,
//     blockcode: json["blockcode"],
//     survyno: json["survyno"],
//     area: json["area"]?.toDouble(),
//     clusterId: json["clusterId"],
//     clusterType: clusterTypeValues.map[json["clusterType"]]!,
//     status: statusValues.map[json["status"]]!,
//     cce: json["cce"],
//   );
//   Map<String, dynamic> toJson() => {
//     "clusterNo": clusterNo,
//     "keyplotId": keyplotId,
//     "village": villageValues.reverse[village],
//     "localbody": localbodyValues.reverse[localbody],
//     "blockcode": blockcode,
//     "survyno": survyno,
//     "area": area,
//     "clusterId": clusterId,
//     "clusterType": clusterTypeValues.reverse[clusterType],
//     "status": statusValues.reverse[status],
//     "cce": cce,
//   };
// }
// enum ClusterType {
//   DRY,
//   WET
// }
// final clusterTypeValues = EnumValues({
//   "dry": ClusterType.DRY,
//   "wet": ClusterType.WET
// });
// enum Localbody {
//   LOCAL_BODY_NOT_FOUND
// }
// final localbodyValues = EnumValues({
//   "Local body not found": Localbody.LOCAL_BODY_NOT_FOUND
// });
// enum Status {
//   NOT_STARTED,
//   ON_GOING
// }
// final statusValues = EnumValues({
//   "Not Started": Status.NOT_STARTED,
//   "On Going": Status.ON_GOING
// });
// enum Village {
//   KILIMANOOR,
//   NAGAROOR,
//   VELLALLOOR
// }
// final villageValues = EnumValues({
//   "KILIMANOOR": Village.KILIMANOOR,
//   "NAGAROOR": Village.NAGAROOR,
//   "VELLALLOOR": Village.VELLALLOOR
// });
// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }