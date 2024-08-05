import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:orange_doctor_dashboard/common_methods/custom_print.dart';
import 'package:orange_doctor_dashboard/models/brands_model.dart';
import 'package:orange_doctor_dashboard/models/doctor_model.dart';
import 'package:orange_doctor_dashboard/models/specilization.dart';
import 'package:orange_doctor_dashboard/respositories/api_middle_wear_api.dart';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';

Future<List<Specialization>> getAllSepcilizations() async {
  List<Specialization> specializations = [];
  final response = await ApiMiddleWear(
    url: 'specialization/list',
    data: FormData(),
  ).get();
  if (response.statusCode == 200) {
    if (response.data["data"] != null) {
      for (var specialization in response.data["data"]) {
        specializations.add(Specialization.fromJson(specialization));
      }
      return specializations;
    } else {
      return [];
    }
  } else {
    return [];
  }
}

Future<List<BrandsModel>> getAllBrands() async {
  List<BrandsModel> brands = [];
  final response = await ApiMiddleWear(
    url: 'brand/list',
    data: FormData(),
  ).get();
  if (response.statusCode == 200) {
    if (response.data["data"] != null) {
      for (var brand in response.data["data"]) {
        brands.add(BrandsModel.fromJson(brand));
      }
      return brands;
    } else {
      return [];
    }
  } else {
    return [];
  }
}

Future<List<DoctorModel>> getDoctorByCity(data) async {
  List<DoctorModel> doctors = [];

  var url = Uri.parse('$baseUrl/api/city/doctors');

  var headers = {
    'Content-Type': 'application/json',
  };

  var body = jsonEncode(data);

  var request = http.Request('GET', url)
    ..headers.addAll(headers)
    ..body = body;
  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    var responseData = await response.stream.bytesToString();
    var jsonResponse = jsonDecode(responseData);
    if (jsonResponse["data"] != null) {
      for (var brand in jsonResponse["data"]) {
        doctors.add(DoctorModel.fromJson(brand));
      }
      return doctors;
    } else {
      return [];
    }
  } else {
    return [];
  }
}

Future<List<DoctorModel>> getAllDoctorData() async {
  List<DoctorModel> doctors = [];

  var url = Uri.parse('$baseUrl/api/doctor/get');

  var headers = {
    'Content-Type': 'application/json',
  };

  var request = http.Request('GET', url)..headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    var responseData = await response.stream.bytesToString();
    var jsonResponse = jsonDecode(responseData);
    if (jsonResponse["data"] != null) {
      for (var brand in jsonResponse["data"]) {
        doctors.add(DoctorModel.fromJson(brand));
      }
      return doctors;
    } else {
      return [];
    }
  } else {
    return [];
  }
}

Future<List<DoctorModel>> getDoctorBySearch(body) async {
  List<DoctorModel> doctors = [];

  final response = await ApiMiddleWear(
    url: 'doctor/search',
    data: body,
  ).post(
    options: Options(
      contentType: Headers.jsonContentType,
    ),
  );
  if (response.statusCode == 200) {
    if (response.data["data"] != null) {
      for (var brand in response.data["data"]) {
        doctors.add(DoctorModel.fromJson(brand));
      }
      return doctors;
    } else {
      return [];
    }
  } else {
    return [];
  }
}
