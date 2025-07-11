class ClusterLabelArea {
  TotalArea totalArea;
  int clusterId;

  Labels labels;
  ClusterLabelArea({
    required this.totalArea,
    required this.clusterId,

    required this.labels,
  });
  factory ClusterLabelArea.fromJson(Map<String, dynamic> json) =>
      ClusterLabelArea(
        totalArea: TotalArea.fromJson(json["total_area"]),
        clusterId: json["clusterId"],

        labels: Labels.fromJson(json["labels"]),
      );
  Map<String, dynamic> toJson() => {
    "total_area": totalArea.toJson(),
    "clusterId": clusterId,

    "labels": labels.toJson(),
  };
}

class Crop {
  int cropId;
  String cropName;
  Crop({required this.cropId, required this.cropName});
  factory Crop.fromJson(Map<String, dynamic> json) =>
      Crop(cropId: json["cropId"], cropName: json["cropName"]);
  Map<String, dynamic> toJson() => {"cropId": cropId, "cropName": cropName};
}

class Labels {
  List<E> n;
  List<E> e;
  List<E> s;
  List<E> w;
  Labels({required this.n, required this.e, required this.s, required this.w});
  factory Labels.fromJson(Map<String, dynamic> json) => Labels(
    n: List<E>.from(json["N"].map((x) => E.fromJson(x))),
    e: List<E>.from(json["E"].map((x) => E.fromJson(x))),
    s: List<E>.from(json["S"].map((x) => E.fromJson(x))),
    w: List<E>.from(json["W"].map((x) => E.fromJson(x))),
  );
  Map<String, dynamic> toJson() => {
    "N": List<dynamic>.from(n.map((x) => x.toJson())),
    "E": List<dynamic>.from(e.map((x) => x.toJson())),
    "S": List<dynamic>.from(s.map((x) => x.toJson())),
    "W": List<dynamic>.from(w.map((x) => x.toJson())),
  };
}

class E {
  double area;
  int clusterPlotId;
  String svno;
  E({required this.area, required this.clusterPlotId, required this.svno});
  factory E.fromJson(Map<String, dynamic> json) => E(
    area: json["area"]?.toDouble(),
    clusterPlotId: json["cluster_plot_id"],
    svno: json["svno"],
  );
  Map<String, dynamic> toJson() => {
    "area": area,
    "cluster_plot_id": clusterPlotId,
    "svno": svno,
  };
}
class TotalArea {
  double n;
  double e;
  double s;
  int w;
  TotalArea({
    required this.n,
    required this.e,
    required this.s,
    required this.w,
  });
  factory TotalArea.fromJson(Map<String, dynamic> json) => TotalArea(
    n: json["N"]?.toDouble(),
    e: json["E"]?.toDouble(),
    s: json["S"]?.toDouble(),
    w: json["W"],
  );
  Map<String, dynamic> toJson() => {"N": n, "E": e, "S": s, "W": w};
}
