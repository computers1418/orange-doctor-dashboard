

import 'package:dio/dio.dart';

abstract class APIInterface{

Future<Response> get() ;

Future<Response> post();

Future<Response> delete() ;

Future<Response> patch();

}