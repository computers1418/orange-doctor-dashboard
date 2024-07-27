import 'package:dio/dio.dart';
import 'package:orange_doctor_dashboard/constants/url_const.dart';
import 'package:orange_doctor_dashboard/models/brand_list_model.dart';
import 'package:orange_doctor_dashboard/services/api/api.dart';

class BrandListServices {
  Api api = Api();
  Future<BrandListModel> fetchBrandList() async {
    try {
      Response response = await api.sendRequest.get(UrlConst.brandList);
      Map<String, dynamic> brandListMap = response.data;
      return BrandListModel.fromJson(brandListMap);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> createBrandList(brandName) async {
    try {
      Response response = await api.sendRequest
          .post(UrlConst.createBrand, data: {"name": brandName});
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> deleteList(brandId) async {
    try {
      Response response =
          await api.sendRequest.get("${UrlConst.deleteBrand}/$brandId");
      print("${UrlConst.deleteBrand}/$brandId");
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
