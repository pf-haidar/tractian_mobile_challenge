import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tractian_mobile_challange/core/store/tree_store.dart';
import 'package:tractian_mobile_challange/widgets/custom_elevated_button.dart';
import 'package:tractian_mobile_challange/widgets/tree_widget.dart';

class AssetsView extends StatelessWidget {
  final String companyId;
  const AssetsView({
    super.key,
    required this.companyId,
  });

  @override
  Widget build(BuildContext context) {
    TreeStore store = Get.put(TreeStore());
    store.getLocations(companyId);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Assets',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
        body: Obx(() => store.isLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 16,
                      right: 16,
                      left: 16,
                      bottom: 8,
                    ),
                    child: TextField(
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 16),
                        hintText: 'Buscar Ativo ou Local',
                        hintStyle: const TextStyle(
                          fontSize: 14,
                          height: 20 / 14,
                          color: Color.fromRGBO(142, 152, 163, 1),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: const Color.fromRGBO(234, 239, 243, 1),
                        prefixIcon: Container(
                          margin: const EdgeInsets.only(right: 8, left: 16.75),
                          child: const Icon(
                            Icons.search,
                            size: 20,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Row(
                      children: [
                        CustomElevatedButton(
                          onPressed: () {},
                          icon: Icons.bolt_outlined,
                          text: 'Sensor de Energia',
                        ),
                        const SizedBox(width: 8),
                        CustomElevatedButton(
                          onPressed: () {},
                          icon: Icons.error_outline,
                          text: 'Crítico',
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Expanded(
                    child: TreeWidget(
                      nodes: store.filteredTreeNodes.value,
                    ),
                  ),
                ],
              )),
      ),
    );
  }
}
