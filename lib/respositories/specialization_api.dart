import 'package:dio/dio.dart';

import 'package:orange_doctor_dashboard/respositories/api.dart';
import 'package:orange_doctor_dashboard/utility/networking.dart';

class SpecializationAPI extends APIInterface {
  DioService dio;

  SpecializationAPI({required this.dio});

  @override
  Future<Response> delete() {
    throw UnimplementedError();
  }

  @override
  Future<Response> get() async {
    final response = await dio.get(endpoint: "specialization/list");
    return response;
  }

  @override
  Future<Response> patch() {
    // TODO: implement patch
    throw UnimplementedError();
  }

  @override
  Future<Response> post() {
    // TODO: implement post
    throw UnimplementedError();
  }
}
