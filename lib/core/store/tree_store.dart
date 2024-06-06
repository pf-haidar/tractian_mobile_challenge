import 'package:get/get.dart';
import 'package:tractian_mobile_challange/core/controller/company_controller.dart';
import 'package:tractian_mobile_challange/core/models/tree_node_model.dart';

class TreeStore extends GetxController {
  CompanyController companyController = CompanyController();

  List<TreeNodeModel> treeNodes = [];
  RxList<dynamic> filteredTreeNodes = [].obs;
  RxBool isLoading = false.obs;

  ordenateTreeNode() {
    final Map<String, TreeNodeModel> nodeMap = {
      for (var node in treeNodes) node.id: node
    };

    final List<TreeNodeModel> nodesToRemove = [];
    for (var node in treeNodes) {
      if (node.locationId != null && nodeMap.containsKey(node.locationId)) {
        nodeMap[node.locationId]!.children.add(node);
        nodesToRemove.add(node);
      } else if (node.parentId != null && nodeMap.containsKey(node.parentId)) {
        nodeMap[node.parentId]!.children.add(node);
        nodesToRemove.add(node);
      }
    }

    treeNodes.removeWhere((node) => nodesToRemove.contains(node));
    filteredTreeNodes.value = treeNodes;
    isLoading.value = false;
  }

  getLocations(companyId) async {
    List<TreeNodeModel> locationsList = [];
    isLoading.value = true;
    treeNodes.clear();
    var data = await companyController.getCompanyLocations(companyId);
    locationsList = data.map((json) => TreeNodeModel.fromJson(json)).toList();
    treeNodes.addAll(locationsList);
    getAssets(companyId);
  }

  getAssets(companyId) async {
    List<TreeNodeModel> assetsList = [];
    var data = await companyController.getCompanyAssets(companyId);
    assetsList = data.map((json) => TreeNodeModel.fromJson(json)).toList();
    for (var asset in assetsList) {
      asset.nodeType = TreeNodeModel.setTreeNodeType(asset);
    }
    treeNodes.addAll(assetsList);
    ordenateTreeNode();
  }
}
