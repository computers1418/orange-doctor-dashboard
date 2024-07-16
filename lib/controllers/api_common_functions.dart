import 'package:dio/dio.dart';
import 'package:orange_doctor_dashboard/common_methods/custom_print.dart';
import 'package:orange_doctor_dashboard/models/brands_model.dart';
import 'package:orange_doctor_dashboard/models/specilization.dart';
import 'package:orange_doctor_dashboard/respositories/specialization_api.dart';

Future<List<Specialization>> getAllSepcilizations() async {
  List<Specialization> specializations = [];
  final response = await ApiMiddleWear(
    url: 'specialization/list',
    data: FormData(),
  ).get();
  printC('response:${response.data}');
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
  printC('response:${response.data}');
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
