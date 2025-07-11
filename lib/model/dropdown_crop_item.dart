class MenuItems {
  final int id;
  final String label;
  MenuItems(this.id, this.label);
}
class CropsList {
  List<Crops> crops;
  String message;

  CropsList({
    required this.crops,
    required this.message,
  });
  factory CropsList.fromJson(Map<String, dynamic> json) => CropsList(
    crops: List<Crops>.from(json["payload"].map((x) => Crops.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "payload": List<dynamic>.from(crops.map((x) => x.toJson())),
    "message": message,
  };
}
class Crops {
  int cropId;
  String cropNameEn;
  String cropNameMal;
  UnitType unitType;
  bool isActive;
  Crops({
    required this.cropId,
    required this.cropNameEn,
    required this.cropNameMal,
    required this.unitType,
    required this.isActive,
  });

  factory Crops.fromJson(Map<String, dynamic> json) =>Crops(
    cropId: json["cropId"],
    cropNameEn: json["cropNameEn"],
    cropNameMal: json["cropNameMal"],
    unitType: unitTypeValues.map[json["unitType"]]!,
    isActive: json["isActive"],
  );
  Map<String, dynamic> toJson() => {
    "cropId": cropId,
    "cropNameEn": cropNameEn,
    "cropNameMal": cropNameMal,
    "unitType": unitTypeValues.reverse[unitType],
    "isActive": isActive,
  };
}
enum UnitType {
  CENT,
  COUNT,
  EMPTY
}
final unitTypeValues = EnumValues({
  "cent": UnitType.CENT,
  "count": UnitType.COUNT,
  "": UnitType.EMPTY
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
