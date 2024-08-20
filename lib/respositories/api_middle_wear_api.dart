import 'package:dio/dio.dart';

import 'package:orange_doctor_dashboard/respositories/api.dart';
import 'package:orange_doctor_dashboard/utility/networking.dart';

class ApiMiddleWear extends APIInterface {
  String url;
  dynamic data;
  final Map<String, dynamic>? headers;
  late DioService dio;

  ApiMiddleWear({required this.url, this.data, this.headers}) {
    dio = DioService(
      dioClient: Dio(
        BaseOptions(
          baseUrl: "http://13.127.57.197/api/",
          connectTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 5),
          validateStatus: (status) {
            return true;
          },
        ),
      ),
    );
  }

  @override
  Future<Response> delete() async {
    final response = await dio.delete(
        endpoint: url,
        options:
            Options(headers: headers ?? {'Content-Type': 'application/json'}));
    return response;
  }

  @override
  Future<Response> get() async {
    final response = await dio.get(
        endpoint: url,
        options: Options(
            headers:
                headers ?? headers ?? {'Content-Type': 'application/json'}));
    return response;
  }

  @override
  Future<Response> patch() {
    throw UnimplementedError();
  }

  @override
  Future<Response> post() async {
    final response = await dio.post(
      endpoint: url,
      data: data,
      options: Options(
          headers: headers ?? headers ?? {'Content-Type': 'application/json'}),
    );
    return response;
  }
}
