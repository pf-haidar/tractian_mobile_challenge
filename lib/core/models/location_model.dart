class LocationModel {
  final String id;
  final String name;
  final String? parentId;

  const LocationModel({
    required this.id,
    required this.name,
    this.parentId,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'parentId': parentId,
    };
  }

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'] as String,
      name: json['name'] as String,
      parentId: json['parentId'] as String?,
    );
  }
}
