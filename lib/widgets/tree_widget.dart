import 'package:flutter/material.dart';
import 'package:tractian_mobile_challange/core/models/tree_node_model.dart';

class TreeWidget extends StatelessWidget {
  final List<dynamic> nodes;
  const TreeWidget({
    super.key,
    required this.nodes,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: _buildTreeNodes(nodes),
    );
  }

  _getIconImageByNodeType(TreeNodeType nodeType) {
    if (nodeType == TreeNodeType.location) {
      return Image.asset('assets/images/location_icon.png');
    } else if (nodeType == TreeNodeType.asset) {
      return Image.asset('assets/images/asset_icon.png');
    } else {
      return Image.asset('assets/images/component_icon.png');
    }
  }

  List<Widget> _buildTreeNodes(List<dynamic> nodes) {
    return nodes.map((node) {
      if (node.children.isEmpty) {
        return ListTile(
          title: Row(
            children: [
              _getIconImageByNodeType(node.nodeType),
              Text(node.title),
            ],
          ),
        );
      } else {
        return ExpansionTile(
          title: Row(
            children: [
              _getIconImageByNodeType(node.nodeType),
              Text(node.title),
            ],
          ),
          children: _buildTreeNodes(node.children),
        );
      }
    }).toList();
  }
}
