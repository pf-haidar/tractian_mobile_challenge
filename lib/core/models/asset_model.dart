class AssetModel {
  final String id;
  final String name;
  final String? parentId;
  final String? sensorId;
  final String? sensorType;
  final String? status;
  final String? gatewayId;
  final String? locationId;

  const AssetModel({
    required this.id,
    required this.name,
    this.status,
    this.gatewayId,
    this.sensorId,
    this.sensorType,
    this.locationId,
    this.parentId,
  });

  factory AssetModel.fromJson(Map<String, dynamic> json) {
    return AssetModel(
      id: json['id'] as String,
      name: json['name'] as String,
      parentId: json['parentId'] as String?,
      sensorId: json['sensorId'] as String?,
      sensorType: json['sensorType'] as String?,
      status: json['status'] as String?,
      gatewayId: json['gatewayId'] as String?,
      locationId: json['locationId'] as String?,
    );
  }
}
