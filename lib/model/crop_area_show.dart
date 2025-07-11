// models/area_model.dart
class AreaModel {
  final double plotArea;
  final double cropArea;
  final double enumeratedArea;

  AreaModel({
    required this.plotArea,
    required this.cropArea,
    required this.enumeratedArea,
  });

  factory AreaModel.fromJson(Map<String, dynamic> json) {
    return AreaModel(
      plotArea: json['plot_area']?.toDouble() ?? 0.0,
      cropArea: json['crop_area']?.toDouble() ?? 0.0,
      enumeratedArea: json['enumerated_area']?.toDouble() ?? 0.0,
    );
  }
}
