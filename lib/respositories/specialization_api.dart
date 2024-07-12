import 'package:dio/dio.dart';

import 'package:orange_doctor_dashboard/respositories/api.dart';
import 'package:orange_doctor_dashboard/utility/networking.dart';

class ApiMiddleWear extends APIInterface {
  String url;
  FormData data;
  ApiMiddleWear({required this.url,required this.data});

  DioService dio=DioService(
      dioClient: Dio(BaseOptions(
        baseUrl: "http://13.127.57.197/api/",
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
      )));
  @override
  Future<Response> delete() {
    throw UnimplementedError();
  }

  @override
  Future<Response> get() async {
    final response = await dio.get(endpoint: url);
    return response;
  }

  @override
  Future<Response> patch() {
    // TODO: implement patch
    throw UnimplementedError();
  }

  @override
  Future<Response> post() async {
    final response = await dio.post(endpoint: url,data:data);
    return response;
  }
}
