import 'package:flutter/material.dart';
import 'package:tractian_mobile_challange/core/models/tree_node_model.dart';

class TreeWidget extends StatefulWidget {
  final List<dynamic> nodes;

  const TreeWidget({
    super.key,
    required this.nodes,
  });

  @override
  State<TreeWidget> createState() => _TreeWidgetState();
}

class _TreeWidgetState extends State<TreeWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: _buildTreeNodes(widget.nodes),
    );
  }

  Widget _getIconImageByNodeType(TreeNodeType nodeType) {
    if (nodeType == TreeNodeType.location) {
      return Image.asset('assets/images/location_icon.png');
    } else if (nodeType == TreeNodeType.asset) {
      return Image.asset('assets/images/asset_icon.png');
    } else {
      return Image.asset('assets/images/component_icon.png');
    }
  }

  Widget _getTrailingIconByNodeStatusOrSensorType(
      String? nodeStatus, String? nodeSensor) {
    if (nodeStatus == 'alert' && nodeSensor == 'energy') {
      return const Row(
        children: [
          Icon(
            Icons.circle,
            color: Color.fromRGBO(237, 56, 51, 1),
            size: 10,
          ),
          Icon(
            Icons.bolt,
            color: Color.fromRGBO(82, 196, 26, 1),
            size: 20,
          )
        ],
      );
    } else if (nodeStatus == 'alert') {
      return const Icon(
        Icons.circle,
        color: Color.fromRGBO(237, 56, 51, 1),
        size: 10,
      );
    } else if (nodeSensor == 'energy') {
      return const Icon(
        Icons.bolt,
        color: Color.fromRGBO(82, 196, 26, 1),
        size: 20,
      );
    } else {
      return const SizedBox();
    }
  }

  double _getPadding(treeLevel) {
    return 8.0 + treeLevel;
  }

  List<Widget> _buildTreeNodes(List<dynamic> nodes,
      {bool willIncrementLevel = false, double treeLevel = 0}) {
    if (willIncrementLevel) treeLevel++;
    return nodes.map((node) {
      if (node.children.isEmpty) {
        return Padding(
          padding: EdgeInsets.only(left: _getPadding(treeLevel)),
          child: ListTile(
            minTileHeight: 30,
            leading: treeLevel == 0 ? null : const SizedBox(),
            // contentPadding:
            //     treeLevel == 0 ? null : const EdgeInsets.only(left: 16),
            title: Row(
              children: [
                _getIconImageByNodeType(node.nodeType),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    node.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 22 / 14,
                      color: Color.fromRGBO(23, 25, 45, 1),
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                _getTrailingIconByNodeStatusOrSensorType(
                  node.status,
                  node.sensorType,
                ),
              ],
            ),
          ),
        );
      } else {
        return CustomExpandedTile(
          treeLevelPadding: _getPadding(treeLevel),
          nodeTypeIcon: _getIconImageByNodeType(node.nodeType),
          node: node,
          buildTreeNode: _buildTreeNodes(
            node.children,
            willIncrementLevel: true,
            treeLevel: treeLevel,
          ),
        );
      }
    }).toList();
  }
}

class CustomExpandedTile extends StatefulWidget {
  final double treeLevelPadding;
  final Widget nodeTypeIcon;
  final dynamic node;
  final List<Widget> buildTreeNode;
  const CustomExpandedTile({
    super.key,
    required this.treeLevelPadding,
    required this.nodeTypeIcon,
    required this.node,
    required this.buildTreeNode,
  });

  @override
  State<CustomExpandedTile> createState() => _CustomExpandedTileState();
}

class _CustomExpandedTileState extends State<CustomExpandedTile> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: widget.treeLevelPadding),
      child: ExpansionTile(
        minTileHeight: 30,
        tilePadding: widget.treeLevelPadding == 8
            ? const EdgeInsets.only(left: 7)
            : null,
        onExpansionChanged: (value) => setState(() {
          isExpanded = value;
        }),
        shape: const Border(),
        leading: isExpanded
            ? const Icon(
                Icons.expand_less,
                size: 24,
                color: Color.fromRGBO(23, 25, 45, 1),
              )
            : const Icon(
                Icons.expand_more,
                size: 24,
                color: Color.fromRGBO(23, 25, 45, 1),
              ),
        trailing: const SizedBox(),
        title: Row(
          children: [
            widget.nodeTypeIcon,
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                maxLines: 2,
                widget.node.title,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  height: 22 / 14,
                  color: Color.fromRGBO(23, 25, 45, 1),
                ),
              ),
            ),
          ],
        ),
        children: widget.buildTreeNode,
      ),
    );
  }
}
