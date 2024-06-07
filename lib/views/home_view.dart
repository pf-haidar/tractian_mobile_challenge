import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tractian_mobile_challange/core/store/company_store.dart';
import 'package:tractian_mobile_challange/views/assets_view.dart';
import 'package:tractian_mobile_challange/widgets/custom_elevated_button.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    CompanyStore companyStore = Get.put(CompanyStore());
    companyStore.getCompanies();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset('assets/images/logo_tractian.png'),
        ),
        body: Obx(
          () => companyStore.companiesList.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.wifi_off_outlined,
                        size: 50,
                      ),
                      Text(
                        'Ocorreu um erro ao buscar dados.\nVerifique sua conexão com a\nInternet.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(23, 25, 45, 1),
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: companyStore.companiesList.length,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 22, vertical: 30),
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: EdgeInsets.only(top: index != 0 ? 40 : 0),
                      child: InkWell(
                        onTap: () => Navigator.of(context)
                            .push(
                              MaterialPageRoute(
                                builder: (context) => AssetsView(
                                  companyId:
                                      companyStore.companiesList[index].id,
                                ),
                              ),
                            )
                            .then((_) => companyStore.getCompanies()),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 24,
                            horizontal: 32,
                          ),
                          // height: 76,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(33, 136, 255, 1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Image.asset('assets/images/company_icon.png'),
                              const SizedBox(width: 16),
                              Text(
                                companyStore.companiesList[index].name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
        ),
      ),
    );
  }
}
