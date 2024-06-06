enum TreeNodeType { location, asset, component }

class TreeNodeModel {
  String id;
  String title;
  List<TreeNodeModel> children;
  TreeNodeType nodeType;
  String? parentId;

  TreeNodeModel({
    required this.id,
    required this.title,
    required this.children,
    required this.nodeType,
    this.parentId,
  });
}
