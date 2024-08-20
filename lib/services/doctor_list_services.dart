import 'package:dio/dio.dart';
import 'package:orange_doctor_dashboard/constants/url_const.dart';
import 'package:orange_doctor_dashboard/models/brand_list_model.dart';
import 'package:orange_doctor_dashboard/services/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorListServices {
  Api api = Api();

  Future<Response> createDoctor(Map<String, dynamic> data) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    api.dio.options.headers['Authorization'] =
        'Bearer ${shared.getString("access_token")}';
    try {
      var response =
          await api.sendRequest.post(UrlConst.createDoctor, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
