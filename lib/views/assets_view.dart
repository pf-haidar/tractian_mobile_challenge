// ignore_for_file: invalid_use_of_protected_member
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
    store.initView(companyId);
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
        body: Obx(
          () => store.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
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
                        controller: store.textSearchInputController,
                        onChanged: (value) =>
                            store.onChangedSearchString.value = value,
                        onSubmitted: (_) => store.ordenateTreeNodeByTitle(),
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
                          suffixIcon: store.onChangedSearchString.value == ''
                              ? null
                              : IconButton(
                                  icon: const Icon(
                                    Icons.clear,
                                    size: 20,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    store.textSearchInputController.clear();
                                    store.ordenateTreeNodeByTitle();
                                  },
                                ),
                          prefixIcon: Container(
                            margin:
                                const EdgeInsets.only(right: 8, left: 16.75),
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
                        child: Obx(
                          () => Row(
                            children: [
                              CustomElevatedButton(
                                onPressed: () =>
                                    store.ordenateTreeNodeByEnergySensorType(),
                                icon: Icons.bolt_outlined,
                                text: 'Sensor de Energia',
                                isEnabled: store.isEnergySensorFilterOn.value,
                              ),
                              const SizedBox(width: 8),
                              CustomElevatedButton(
                                onPressed: () =>
                                    store.ordenateTreeNodeByCriticStatus(),
                                icon: Icons.error_outline,
                                text: 'Crítico',
                                isEnabled: store.isCriticStatusFilterOn.value,
                              ),
                            ],
                          ),
                        )),
                    const Divider(),
                    store.filteredTreeNodes.isEmpty
                        ? const Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.search_off,
                                  size: 50,
                                ),
                                Text(
                                  'Nenhum resultado encontrado!',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromRGBO(23, 25, 45, 1),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Expanded(
                            child: TreeWidget(
                              nodes: store.filteredTreeNodes.value,
                            ),
                          ),
                  ],
                ),
        ),
      ),
    );
  }
}
