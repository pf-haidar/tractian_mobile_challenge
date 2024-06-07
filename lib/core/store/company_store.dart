import 'package:get/get.dart';
import 'package:tractian_mobile_challange/core/controller/company_controller.dart';
import 'package:tractian_mobile_challange/core/models/company_model.dart';

class CompanyStore extends GetxController {
  CompanyController companyController = CompanyController();

  var companiesList = [].obs;

  getCompanies() async {
    var data = await companyController.getCompanies();
    companiesList.value =
        data.map((json) => CompanyModel.fromJson(json)).toList();
  }
}
