import 'package:dio/dio.dart';
import 'package:orange_doctor_dashboard/constants/url_const.dart';
import 'package:orange_doctor_dashboard/models/brand_list_model.dart';
import 'package:orange_doctor_dashboard/services/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BrandListServices {
  Api api = Api();

  Future<BrandListModel> fetchBrandList() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    api.dio.options.headers['Authorization'] =
        'Bearer ${shared.getString("access_token")}';
    try {
      Response response = await api.sendRequest.get(UrlConst.brandList);
      Map<String, dynamic> brandListMap = response.data;
      return BrandListModel.fromJson(brandListMap);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> createBrandList(brandName) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    api.dio.options.headers['Authorization'] =
        'Bearer ${shared.getString("access_token")}';
    try {
      var response = await api.sendRequest.post(UrlConst.createBrand, data: {
        "name": brandName,
        "createdBy": "668fe0a5f368b564f171e85e",
        "updatedBy": "668fe0a5f368b564f171e85e"
      });

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> deleteList(brandId) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    api.dio.options.headers['Authorization'] =
        'Bearer ${shared.getString("access_token")}';
    try {
      Response response =
          await api.sendRequest.delete("${UrlConst.deleteBrand}/$brandId");
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
