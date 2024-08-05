import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart' hide FormData;
import 'package:orange_doctor_dashboard/common_methods/common_methods.dart';
import 'package:orange_doctor_dashboard/common_methods/custom_print.dart';
import 'package:orange_doctor_dashboard/controllers/api_common_functions.dart';
import 'package:orange_doctor_dashboard/models/brands_model.dart';
import 'package:orange_doctor_dashboard/models/city_model.dart';
import 'package:orange_doctor_dashboard/models/doctor_model.dart';
import 'package:orange_doctor_dashboard/models/specilization.dart';
import 'package:orange_doctor_dashboard/respositories/specialization_api.dart';
import '../constants/constants.dart';
import '../respositories/api_middle_wear_api.dart';
import 'package:http/http.dart' as http;

class CityController extends GetxController {
  var rxGetList = RxStatus.empty().obs;
  var isFetching = false.obs;
  var brands = <BrandsModel>[].obs;
  var specializations = <Specialization>[].obs;
  var cities = <CityModel>[].obs;
  var creatingCity = false.obs;
  var updatingCity = -1.obs;
  RxList<DoctorModel> doctorList = <DoctorModel>[].obs;

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

  Future getDoctorListByCity(formData) async {
    // isFetching.value = true;
    doctorList.value = await getDoctorByCity(formData);
    // isFetching.value = false;
  }

  Future getAllDoctorList() async {
    // isFetching.value = true;
    doctorList.value = await getAllDoctorData();
    // isFetching.value = false;
  }

  Future getDoctorListBySearch(body) async {
    // isFetching.value = true;
    doctorList.value = await getDoctorBySearch(body);
    // isFetching.value = false;
  }

  Future getCitiesList(String brandId, String specializationId) async {
    Dio dio = Dio();

    try {
      rxGetList.value = RxStatus.loading();
      update();
      cities.clear();
      Map<String, dynamic> data = {
        "brandId": brandId,
        "specializationId": specializationId,
      };

      var response = await dio.request(
        "http://13.127.57.197/api/city/by-brand-specialization",
        data: data,
        options: Options(
          method: 'GET',
        ),
      );
      if (response.statusCode == 200) {
        if (response.data["data"] != null) {
          for (var city in response.data["data"]) {
            cities.add(CityModel.fromJson(city));
          }
          rxGetList.value = RxStatus.success();
        } else {
          // rxGetList.value = RxStatus.loading();
          rxGetList.value = RxStatus.success();
        }
      } else {
        rxGetList.value = RxStatus.success();
      }
    } on DioException catch (e) {
    } catch (e) {}
  }

  Future<bool> createCity(
      {required String name,
      required String brandId,
      required String specializationId,
      required FToast fToast}) async {
    creatingCity.value = true;
    try {
      Map<String, dynamic> data = {
        "name": name,
        "brandId": brandId,
        "specializationId": specializationId,
        "isActive": true
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
          showToast(fToast, "City has been created successfully.", false);
          cities.add(CityModel.fromJson(response.data["data"]));
          rxGetList.value =
              cities.isEmpty ? RxStatus.empty() : RxStatus.success();
          return true;
        }
      } else {
        showToast(fToast, response.data["message"], true);
      }
    } catch (e) {
      printC('error:$e');
    } finally {
      creatingCity.value = false;
    }
    return false;
  }

  Future<bool> updateCityName(
      {required String name,
      required String cityId,
      required FToast fToast}) async {
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
      print("sdsdsd=======${response.data}");
      if (response.statusCode == 200) {
        if (response.data["data"] != null) {
          final index = cities.indexWhere((element) => element.id == cityId);
          if (index != -1) {
            cities[index] = CityModel.fromJson(response.data["data"]);
          }
          showToast(fToast, response.data["message"], false);
          update();
          return true;
        }
      } else {
        showToast(fToast, response.data["message"], true);
      }
    } catch (e) {
      printC('error:$e');
    } finally {}
    update();
    return false;
  }

  Future<bool> deleteCityName(
      {required String cityId, required FToast fToast}) async {
    try {
      final response = await ApiMiddleWear(
        url: 'city/delete/$cityId',
      ).delete();

      if (response.statusCode == 200) {
        showToast(fToast, response.data["data"], false);
        // getCitiesList();
        // if (response.data["data"] != null) {
        final index = cities.indexWhere((element) => element.id == cityId);
        // if (index != -1) {
        //   cities[index] = CityModel.fromJson(response.data["data"]);
        // }
        cities.removeAt(index);
        update();
        return true;
        // }
      } else {
        // CommonMethods.customSnackBar(
        //   "Error",
        //   response.data["message"],
        // );
        showToast(fToast, response.data["message"], true);
      }
    } catch (e) {
      printC('error:$e');
    } finally {}
    update();
    return false;
  }
}
