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

  TreeNodeModel({
    required this.id,
    required this.title,
    required this.nodeType,
    required this.children,
    this.parentId,
    this.sensorType,
    this.status,
    this.locationId,
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

  static setTreeNodeType(TreeNodeModel model) {
    if (model.sensorType != null) {
      return TreeNodeType.component;
    } else {
      return TreeNodeType.asset;
    }
  }
}
