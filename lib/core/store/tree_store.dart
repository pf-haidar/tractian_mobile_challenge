import 'package:get/get.dart';
import 'package:tractian_mobile_challange/core/controller/company_controller.dart';
import 'package:tractian_mobile_challange/core/models/tree_node_model.dart';

class TreeStore extends GetxController {
  CompanyController companyController = CompanyController();

  List<TreeNodeModel> treeNodes = [];
  RxList<dynamic> filteredTreeNodes = [].obs;
  RxBool isLoading = false.obs;
  RxBool isEnergySensorFilterOn = false.obs;
  RxBool isCriticStatusFilterOn = false.obs;
  RxString onChangedSearchString = ''.obs;

  ordenateTreeNodeByCriticStatus() {
    isLoading.value = true;
    isCriticStatusFilterOn.value = !isCriticStatusFilterOn.value;
    if (isCriticStatusFilterOn.value) {
      filteredTreeNodes.value = _filterTreeNodesByCriticStatus(treeNodes);
    } else {
      filteredTreeNodes.value = treeNodes;
    }
    isLoading.value = false;
  }

  ordenateTreeNodeByEnergySensorType() {
    isLoading.value = true;
    isEnergySensorFilterOn.value = !isEnergySensorFilterOn.value;
    if (isEnergySensorFilterOn.value) {
      filteredTreeNodes.value = _filterTreeNodesByEnergySensor(treeNodes);
    } else {
      filteredTreeNodes.value = treeNodes;
    }
    isLoading.value = false;
  }

  ordenateTreeNodeByTitle() {
    isLoading.value = true;
    if (onChangedSearchString.value == '') {
      filteredTreeNodes.value = treeNodes;
    } else {
      filteredTreeNodes.value = _filterTreeNodesByTitle(treeNodes);
    }
    isLoading.value = false;
  }

  List<TreeNodeModel> _filterTreeNodesByTitle(List<TreeNodeModel> nodes) {
    List<TreeNodeModel> filteredNodes = [];

    for (var node in nodes) {
      List<TreeNodeModel> filteredChildren =
          _filterTreeNodesByTitle(node.children);
      if (filteredChildren.isNotEmpty ||
          node.title
              .toLowerCase()
              .contains(onChangedSearchString.value.toLowerCase())) {
        node.children = filteredChildren;
        filteredNodes.add(node);
      }
    }

    return filteredNodes;
  }

  List<TreeNodeModel> _filterTreeNodesByEnergySensor(
      List<TreeNodeModel> nodes) {
    List<TreeNodeModel> filteredNodes = [];

    for (var node in nodes) {
      List<TreeNodeModel> filteredChildren =
          _filterTreeNodesByEnergySensor(node.children);
      if (filteredChildren.isNotEmpty || node.sensorType == "energy") {
        node.children = filteredChildren;
        filteredNodes.add(node);
      }
    }

    return filteredNodes;
  }

  List<TreeNodeModel> _filterTreeNodesByCriticStatus(
      List<TreeNodeModel> nodes) {
    List<TreeNodeModel> filteredNodes = [];

    for (var node in nodes) {
      List<TreeNodeModel> filteredChildren =
          _filterTreeNodesByCriticStatus(node.children);
      if (filteredChildren.isNotEmpty || node.status == "alert") {
        node.children = filteredChildren;
        filteredNodes.add(node);
      }
    }

    return filteredNodes;
  }

  _ordenateTreeNode() {
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

  initView(companyId) {
    isEnergySensorFilterOn.value = false;
    isCriticStatusFilterOn.value = false;
    isLoading.value = true;
    treeNodes.clear();
    getLocations(companyId);
  }

  getLocations(companyId) async {
    List<TreeNodeModel> locationsList = [];
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
    _ordenateTreeNode();
  }
}
