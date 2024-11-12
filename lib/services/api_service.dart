import 'dart:convert';
import 'package:app_tractian/models/assets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/company.dart';
import '../models/location.dart';

class ApiService extends GetxController {
  static const String baseUrl = 'https://fake-api.tractian.com';

  final RxList<CompanyModel> _companies = <CompanyModel>[].obs;
  RxList<CompanyModel> get companies => _companies;

  final RxList<LocationModel> _location = <LocationModel>[].obs;
  RxList<LocationModel> get location => _location;

  final RxList<AssetModel> _assets = <AssetModel>[].obs;
  RxList<AssetModel> get assets => _assets;

  final RxBool isDataLoaded = false.obs;

  Future<void> getCompanies() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/companies"));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _companies.value =
            data.map((json) => CompanyModel.fromJson(json)).toList();
      } else {
        Get.snackbar("Erro",
            "Não foi possível buscar as empresas. Tente novamente mais tarde.");
      }
    } catch (e) {
      Get.snackbar("Erro",
          "Não foi possível buscar as empresas. Tente novamente mais tarde.");
    }
  }

  Future<void> getLocations(String companyId) async {
    try {
      final response =
          await http.get(Uri.parse("$baseUrl/companies/$companyId/locations"));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _location.value =
            data.map((json) => LocationModel.fromJson(json)).toList();
        checkDataLoaded();
      } else {
        Get.snackbar("Erro",
            "Não foi possível buscar os locais. Tente novamente mais tarde.");
      }
    } catch (e) {
      Get.snackbar("Erro",
          "Não foi possível buscar os locais. Tente novamente mais tarde.");
    }
  }

  Future<void> getAssets(String companyId) async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/companies/$companyId/assets'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _assets.value = data.map((json) => AssetModel.fromJson(json)).toList();
        checkDataLoaded();
      } else {
        Get.snackbar("Erro",
            "Não foi possível buscar os ativos. Tente novamente mais tarde.");
      }
    } catch (e) {
      Get.snackbar("Erro",
          "Não foi possível buscar os ativos. Tente novamente mais tarde.");
    }
  }

  void checkDataLoaded() {
    if (_location.isNotEmpty && _assets.isNotEmpty) {
      isDataLoaded.value = true;
    }
  }
}
