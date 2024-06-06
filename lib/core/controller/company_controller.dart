import 'dart:convert';

import 'package:http/http.dart' as http;

class CompanyController {
  static const apiUrl = 'https://fake-api.tractian.com'; //TODO colocar em variavel de ambiente

  Future<List<dynamic>> getCompanies() async {
    try {
      return await http
          .get(
        Uri.parse('$apiUrl/companies'),
      )
          .then((http.Response response) {
        if (response.statusCode == 200) {
          return jsonDecode(response.body);
        }
        return [];
      }).timeout(const Duration(seconds: 10), onTimeout: () {
        return [];
      });
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<List<dynamic>> getCompanyLocations(String companyId) async {
    try {
      return await http
          .get(
        Uri.parse('$apiUrl/companies/$companyId/locations'),
      )
          .then((http.Response response) {
        if (response.statusCode == 200) {
          return jsonDecode(response.body);
        }
        return [];
      }).timeout(const Duration(seconds: 10), onTimeout: () {
        return [];
      });
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<List<dynamic>> getCompanyAssets(String companyId) async {
    try {
      return await http
          .get(
        Uri.parse('$apiUrl/companies/$companyId/assets'),
      )
          .then((http.Response response) {
        if (response.statusCode == 200) {
          return jsonDecode(response.body);
        }
        return [];
      }).timeout(const Duration(seconds: 10), onTimeout: () {
        return [];
      });
    } on Exception catch (_) {
      rethrow;
    }
  }
}
