class ZoneDetails {
  Payload payload;
  String message;

  ZoneDetails({
    required this.payload,
    required this.message,
  });

  factory ZoneDetails.fromJson(Map<String, dynamic> json) {
    return ZoneDetails(
      payload: Payload.fromJson(json['payload']),
      message: json['message'] ?? '',
    );
  }
}

class Payload {
  String status;
  String message;
  String district;
  String taluk;
  String localType;
  String zoneName;
  List<ZoneData> data;
  List<String> panchayth;
  int totalCount;
  double totalArea;
  double totalWetArea;
  double totalDryArea;
  List<dynamic> unclassifiedPanchayaths;

  Payload({
    required this.status,
    required this.message,
    required this.district,
    required this.taluk,
    required this.localType,
    required this.zoneName,
    required this.data,
    required this.panchayth,
    required this.totalCount,
    required this.totalArea,
    required this.totalWetArea,
    required this.totalDryArea,
    required this.unclassifiedPanchayaths,
  });

  factory Payload.fromJson(Map<String, dynamic> json) {
    return Payload(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      district: json['district'] ?? '',
      taluk: json['taluk'] ?? '',
      localType: json['local_type'] ?? '',
      zoneName: json['zone_name'] ?? '',
      data: List<ZoneData>.from(json['data'].map((e) => ZoneData.fromJson(e))),
      panchayth: List<String>.from(json['panchayth']),
      totalCount: json['totalCount'] ?? 0,
      totalArea: (json['totalArea'] ?? 0).toDouble(),
      totalWetArea: (json['totalWetArea'] ?? 0).toDouble(),
      totalDryArea: (json['totalDryArea'] ?? 0).toDouble(),
      unclassifiedPanchayaths: List<dynamic>.from(json['unclassifiedPanchayaths'] ?? []),
    );
  }
}

class ZoneData {
  double wetArea;
  int dryPlot;
  List<String> villages;
  double totalArea;
  String pName;
  List<String> blocks;
  int wetPlot;
  double dryArea;
  int tPlot;

  ZoneData({
    required this.wetArea,
    required this.dryPlot,
    required this.villages,
    required this.totalArea,
    required this.pName,
    required this.blocks,
    required this.wetPlot,
    required this.dryArea,
    required this.tPlot,
  });

  factory ZoneData.fromJson(Map<String, dynamic> json) {
    return ZoneData(
      wetArea: (json['Wet_area'] ?? 0).toDouble(),
      dryPlot: json['dry_plot'] ?? 0,
      villages: List<String>.from(json['villages']),
      totalArea: (json['Total_area'] ?? 0).toDouble(),
      pName: json['p_name'] ?? '',
      blocks: List<String>.from(json['blocks']),
      wetPlot: json['Wet_plot'] ?? 0,
      dryArea: (json['Dry_area'] ?? 0).toDouble(),
      tPlot: json['t_plot'] ?? 0,
    );
  }
}
