import 'package:dio/dio.dart';
import 'package:get/get.dart' hide FormData;
import 'package:orange_doctor_dashboard/common_methods/custom_print.dart';
import 'package:orange_doctor_dashboard/models/brands_model.dart';
import 'package:orange_doctor_dashboard/models/specilization.dart';
import 'package:orange_doctor_dashboard/respositories/specialization_api.dart';

class CityController extends GetxController {
  Dio dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 10), // 10 seconds
      receiveTimeout: const Duration(seconds: 10), // 10 seconds
    ),
  );

  var rxGetList = RxStatus.empty().obs;
  var brands = <BrandsModel>[].obs;
  var specializations = <Specialization>[].obs;

  Future getBrandsList() async {
    rxGetList.value = RxStatus.loading();
    brands.clear();
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
        rxGetList.value =
            brands.isEmpty ? RxStatus.empty() : RxStatus.success();
      } else {
        rxGetList.value = RxStatus.empty();
      }
    } else {
      rxGetList.value = RxStatus.error();
    }
    update();
  }

  Future getSpecializatonList() async {
    rxGetList.value = RxStatus.loading();
    update();
    specializations.clear();
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
        rxGetList.value =
            specializations.isEmpty ? RxStatus.empty() : RxStatus.success();
      } else {
        rxGetList.value = RxStatus.empty();
      }
    } else {
      rxGetList.value = RxStatus.error();
    }
    update();
  }
}
