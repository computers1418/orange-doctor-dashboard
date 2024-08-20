import 'package:dio/dio.dart';
import 'package:orange_doctor_dashboard/constants/url_const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  Dio dio = Dio();

  Api() {
    dio.options.baseUrl = UrlConst.baseUrl;
    dio.options.connectTimeout = const Duration(seconds: 5);
    dio.options.receiveTimeout = const Duration(seconds: 5);
    dio.options.headers['content-Type'] = 'application/json';
    // dio.options.headers['Authorization'] = 'Bearer $token';
    dio.options.headers['Accept'] = 'application/json';
  }

  Dio get sendRequest => dio;
}
