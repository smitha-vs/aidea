class KeyPlotOwnerModel {
  final String name;
  final String mobileNumber;
  final String address;
  final String clusterId;

  KeyPlotOwnerModel({
    required this.name,
    required this.mobileNumber,
    required this.address,
    required this.clusterId,
  });

  Map<String, dynamic> toJson() => {
    "name": name,
    "phone_number": mobileNumber,
    "address": address,
  };
}
