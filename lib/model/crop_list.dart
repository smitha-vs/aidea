import 'dart:convert';
List<AllCropsList> allCropsListFromJson(String str) => List<AllCropsList>.from(json.decode(str).map((x) => AllCropsList.fromJson(x)));
String allCropsListToJson(List<AllCropsList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
class AllCropsList {
  int mappingId;
  int cropId;
  String cropNameEn;
  MasterCropTypeResponse masterCropTypeResponse;
  SeasonalClassificationName seasonalClassificationName;

  AllCropsList({
    required this.mappingId,
    required this.cropId,
    required this.cropNameEn,
    required this.masterCropTypeResponse,
    required this.seasonalClassificationName,
  });

  factory AllCropsList.fromJson(Map<String, dynamic> json) => AllCropsList(
    mappingId: json["mappingId"],
    cropId: json["cropId"],
    cropNameEn: json["cropNameEn"],
    masterCropTypeResponse: MasterCropTypeResponse.fromJson(json["masterCropTypeResponse"]),
    seasonalClassificationName: seasonalClassificationNameValues.map[json["seasonalClassificationName"]]!,
  );

  Map<String, dynamic> toJson() => {
    "mappingId": mappingId,
    "cropId": cropId,
    "cropNameEn": cropNameEn,
    "masterCropTypeResponse": masterCropTypeResponse.toJson(),
    "seasonalClassificationName": seasonalClassificationNameValues.reverse[seasonalClassificationName],
  };
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AllCropsList &&
              runtimeType == other.runtimeType &&
              mappingId == other.mappingId;

  @override
  int get hashCode => mappingId.hashCode;
}

class MasterCropTypeResponse {
  int cropTypeId;
  CropType cropType;

  MasterCropTypeResponse({
    required this.cropTypeId,
    required this.cropType,
  });

  factory MasterCropTypeResponse.fromJson(Map<String, dynamic> json) => MasterCropTypeResponse(
    cropTypeId: json["cropTypeId"],
    cropType: cropTypeValues.map[json["cropType"]]!,
  );

  Map<String, dynamic> toJson() => {
    "cropTypeId": cropTypeId,
    "cropType": cropTypeValues.reverse[cropType],
  };
}

enum CropType {
  ANNUAL,
  PERENNIAL,
  SEASONAL
}

final cropTypeValues = EnumValues({
  "annual": CropType.ANNUAL,
  "perennial": CropType.PERENNIAL,
  "seasonal": CropType.SEASONAL
});

enum SeasonalClassificationName {
  A,
  ADULT,
  B,
  BEARING,
  C,
  CHILD,
  HIGH_YIELD,
  LOW_YIELD,
  NO_CLASSIFICATION,
  YOUNG
}

final seasonalClassificationNameValues = EnumValues({
  "A": SeasonalClassificationName.A,
  "adult": SeasonalClassificationName.ADULT,
  "B": SeasonalClassificationName.B,
  "bearing": SeasonalClassificationName.BEARING,
  "C": SeasonalClassificationName.C,
  "child": SeasonalClassificationName.CHILD,
  "high yield": SeasonalClassificationName.HIGH_YIELD,
  "low yield": SeasonalClassificationName.LOW_YIELD,
  "no classification": SeasonalClassificationName.NO_CLASSIFICATION,
  "young": SeasonalClassificationName.YOUNG
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
class CropTypeItem {
  final int cropTypeId;
  final CropType cropType;

  CropTypeItem(this.cropTypeId, this.cropType);
}
