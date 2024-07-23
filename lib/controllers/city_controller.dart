import 'package:dio/dio.dart';
import 'package:get/get.dart' hide FormData;
import 'package:orange_doctor_dashboard/common_methods/common_methods.dart';
import 'package:orange_doctor_dashboard/common_methods/custom_print.dart';
import 'package:orange_doctor_dashboard/controllers/api_common_functions.dart';
import 'package:orange_doctor_dashboard/models/brands_model.dart';
import 'package:orange_doctor_dashboard/models/city_model.dart';
import 'package:orange_doctor_dashboard/models/specilization.dart';
import 'package:orange_doctor_dashboard/respositories/specialization_api.dart';

class CityController extends GetxController {
  var rxGetList = RxStatus.empty().obs;
  var brands = <BrandsModel>[].obs;
  var specializations = <Specialization>[].obs;
  var cities = <CityModel>[].obs;
  var creatingCity = false.obs;
  var updatingCity = -1.obs;

  Future getBrandsList() async {
    rxGetList.value = RxStatus.loading();
    brands.value = await getAllBrands();
    rxGetList.value = brands.isEmpty ? RxStatus.empty() : RxStatus.success();
  }

  Future getSpecializatonList() async {
    rxGetList.value = RxStatus.loading();
    specializations.value = await getAllSepcilizations();
    rxGetList.value =
        specializations.isEmpty ? RxStatus.empty() : RxStatus.success();
  }

  Future getCitiesList() async {
    rxGetList.value = RxStatus.loading();
    update();
    cities.clear();
    final response = await ApiMiddleWear(
      url: 'city/list',
      data: FormData(),
    ).get();
    if (response.statusCode == 200) {
      if (response.data["data"] != null) {
        for (var city in response.data["data"]) {
          cities.add(CityModel.fromJson(city));
        }
        rxGetList.value =
            cities.isEmpty ? RxStatus.empty() : RxStatus.success();
      } else {
        rxGetList.value = RxStatus.empty();
      }
    } else {
      rxGetList.value = RxStatus.error();
    }
  }

  Future<bool> createCity({
    required String name,
    required String brandId,
    required String specializationId,
  }) async {
    creatingCity.value = true;
    try {
      Map<String, dynamic> data = {
        "name": name,
        "brandId": brandId,
        "specializationId": specializationId,
      };
      final response = await ApiMiddleWear(
        url: 'city/create',
        data: data,
      ).post(
        options: Options(
          contentType: Headers.jsonContentType,
        ),
      );
      if (response.statusCode == 200) {
        if (response.data["data"] != null) {
          cities.add(CityModel.fromJson(response.data["data"]));
          rxGetList.value =
              cities.isEmpty ? RxStatus.empty() : RxStatus.success();
          return true;
        }
      } else {
        CommonMethods.customSnackBar(
          "Error",
          response.data["message"],
        );
      }
    } catch (e) {
      printC('error:$e');
    } finally {
      creatingCity.value = false;
    }
    return false;
  }

  Future<bool> updateCityName({
    required String name,
    required String cityId,
  }) async {
    try {
      final response = await ApiMiddleWear(
        url: 'city/update/$cityId',
        data: {
          "name": name,
        },
      ).post(
        options: Options(
          contentType: Headers.jsonContentType,
        ),
      );
      if (response.statusCode == 200) {
        if (response.data["data"] != null) {
          final index = cities.indexWhere((element) => element.id == cityId);
          if (index != -1) {
            cities[index] = CityModel.fromJson(response.data["data"]);
          }
          update();
          return true;
        }
      } else {
        CommonMethods.customSnackBar(
          "Error",
          response.data["message"],
        );
      }
    } catch (e) {
      printC('error:$e');
    } finally {}
    update();
    return false;
  }
}
