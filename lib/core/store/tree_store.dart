import 'package:get/get.dart';
import 'package:tractian_mobile_challange/core/controller/company_controller.dart';
import 'package:tractian_mobile_challange/core/models/asset_model.dart';
import 'package:tractian_mobile_challange/core/models/location_model.dart';
import 'package:tractian_mobile_challange/core/models/tree_node_model.dart';

import 'dart:developer';

class TreeStore extends GetxController {
  CompanyController companyController = CompanyController();
  List<LocationModel> locationsList = [];
  List<AssetModel> assetsList = [];

  var treeNodes = [].obs;
  RxBool isLoading = false.obs;

  addLocationToTreeNode() {
    var tempList = [];
    for (var i = 0; i < locationsList.length; i++) {
      if (locationsList[i].parentId == null) {
        treeNodes.add(
          TreeNodeModel(
            id: locationsList[i].id,
            title: locationsList[i].name,
            nodeType: TreeNodeType.location,
            children: [],
          ),
        );
      } else {
        tempList.add(
          TreeNodeModel(
            id: locationsList[i].id,
            title: locationsList[i].name,
            nodeType: TreeNodeType.location,
            parentId: locationsList[i].parentId,
            children: [],
          ),
        );
      }
    }

    for (var i = 0; i < tempList.length; i++) {
      for (var j = 0; j < treeNodes.length; j++) {
        if (tempList[i].parentId == treeNodes[j].id) {
          treeNodes[j].children.add(tempList[i]);
        }
      }
    }
  }

  addAssetsToTreeNode() {
    for (var i = 0; i < assetsList.length; i++) {
      var tempNode = TreeNodeModel(
        id: assetsList[i].id,
        title: assetsList[i].name,
        nodeType: TreeNodeType.asset,
        children: [],
      );

      if (assetsList[i].locationId != null) {
        for (var node in treeNodes) {
          if (node.id == assetsList[i].locationId) {
            node.children.add(tempNode);
          }
        }
      } else if (assetsList[i].parentId == null &&
          assetsList[i].locationId == null) {
        tempNode.nodeType = TreeNodeType.component;
        treeNodes.add(tempNode);
      } else {
        tempNode.nodeType = TreeNodeType.component;
        for (var node in treeNodes) {
          if (node.id == assetsList[i].parentId) {
            node.children.add(tempNode);
            break;
          } else if (node.id == assetsList[i].id) {
            print(node.title);
            node.title = assetsList[i].name;
            break;
          } else {
            // TreeNodeModel newParent = TreeNodeModel(
            //   id: assetsList[i].parentId!,
            //   title: 'Vazio',
            //   nodeType: TreeNodeType.asset,
            //   children: [tempNode],
            // );
            // treeNodes.add(newParent);
            break;
          }
        }
      }
    }

    isLoading.value = false;
  }

  getLocations(companyId) async {
    isLoading.value = true;
    locationsList.clear();
    treeNodes.clear();
    var data = await companyController.getCompanyLocations(companyId);
    locationsList = data.map((json) => LocationModel.fromJson(json)).toList();

    await addLocationToTreeNode();

    getAssets(companyId);
  }

  getAssets(companyId) async {
    assetsList.clear();
    var data = await companyController.getCompanyAssets(companyId);
    assetsList = data.map((json) => AssetModel.fromJson(json)).toList();

    addAssetsToTreeNode();
  }
}
