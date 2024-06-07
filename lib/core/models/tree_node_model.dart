enum TreeNodeType { location, asset, component }

class TreeNodeModel {
  String id;
  String title;
  List<TreeNodeModel> children = [];
  TreeNodeType nodeType;
  String? parentId;
  String? sensorType;
  String? status;
  String? locationId;
  bool isExpanded;

  TreeNodeModel({
    required this.id,
    required this.title,
    required this.nodeType,
    required this.children,
    this.parentId,
    this.sensorType,
    this.status,
    this.locationId,
    this.isExpanded = false,
  });

  factory TreeNodeModel.fromJson(Map<String, dynamic> json) {
    return TreeNodeModel(
      id: json['id'] as String,
      title: json['name'] as String,
      parentId: json['parentId'] as String?,
      children: [],
      nodeType: TreeNodeType.location,
      sensorType: json['sensorType'] as String?,
      status: json['status'] as String?,
      locationId: json['locationId'] as String?,
    );
  }

  TreeNodeModel copyWith({List<TreeNodeModel>? children}) {
    return TreeNodeModel(
      id: id,
      title: title,
      parentId: parentId,
      nodeType: nodeType,
      sensorType: sensorType,
      status: status,
      locationId: locationId,
      isExpanded: true,
      children: children ?? this.children,
    );
  }

  static setTreeNodeType(TreeNodeModel model) {
    if (model.sensorType != null) {
      return TreeNodeType.component;
    } else {
      return TreeNodeType.asset;
    }
  }
}
