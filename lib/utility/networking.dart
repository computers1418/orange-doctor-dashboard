import 'dart:async';
import 'package:dio/dio.dart';

class DioService {
  final Dio _dio;

  DioService({
    required Dio dioClient,
    Iterable<Interceptor>? interceptors,
    HttpClientAdapter? httpClientAdapter,
  }) : _dio = dioClient {
    if (interceptors != null) _dio.interceptors.addAll(interceptors);
    if (httpClientAdapter != null) _dio.httpClientAdapter = httpClientAdapter;
  }

  Future<Response> get<R>({
    required String endpoint,
    Options? options,
  }) async {
    final response = await _dio.get(
      endpoint,
      options: options,
    );
    return response;
  }

  Future<Response> post<R>({
    required String endpoint,
    dynamic data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    final response = await _dio.post(
      endpoint,
      data: data,
      options: options,
    );
    return response;
  }

  Future<Response> patch({
    required String endpoint,
    dynamic data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    final response = await _dio.patch(
      endpoint,
      data: data,
      options: options,
    );
    return response;
  }

  Future<Response> delete<R>({
    required String endpoint,
    dynamic data,
    Options? options,
  }) async {
    final response = await _dio.delete(
      endpoint,
      data: data,
      options: options,
    );
    return response;
  }
}
