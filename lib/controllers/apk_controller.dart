import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:orange_doctor_dashboard/models/send_apk_model.dart';
import 'package:http/http.dart' as http;
import '../common_methods/custom_print.dart';
import '../constants/constants.dart';
import '../models/brands_model.dart';
import '../models/specilization.dart';
import '../respositories/api_middle_wear_api.dart';
import 'api_common_functions.dart';

class ApkController extends GetxController {
  var rxGetList = RxStatus.empty().obs;
  var isFetching = false.obs;
  var brands = <BrandsModel>[].obs;
  var specializations = <Specialization>[].obs;
  RxList<SendApkModel> sendApkList = <SendApkModel>[].obs;
  var sendApkData = SendApkModel(
    type: '',
    fromApk: false,
    isDeleted: false,
    sendCount: 0,
    sendApkCount: 0,
    isValid: false,
    id: '',
    invitationUrl: '',
    name: '',
    email: null,
    specialization: '',
    specializationId: '',
    brandId: '',
    brand: '',
    city: '',
    phone: null,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    v: 0,
    sendApkModelId: '',
  ).obs;

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

  Future getAllSendApkList() async {
    isFetching.value = true;
    sendApkList.value = await sendApkListData();
    isFetching.value = false;
  }

  Future<bool> sendApk({required data, required FToast fToast}) async {
    // creatingCity.value = true;
    try {
      final response = await ApiMiddleWear(
        url: 'doctor/send-apk',
        data: data,
      ).post(
        options: Options(
          contentType: Headers.jsonContentType,
        ),
      );

      if (response.statusCode == 200) {
        if (response.data["data"] != null) {
          showToast(fToast, response.data["message"], false);
          getAllSendApkList();
          // rxGetList.value =
          //     cities.isEmpty ? RxStatus.empty() : RxStatus.success();
          return true;
        }
      } else {
        showToast(fToast, response.data["message"], true);
      }
    } catch (e) {
      printC('error:$e');
    } finally {
      // creatingCity.value = false;
    }
    return false;
  }

  Future<void> fetchSendApkById(String id) async {
    final response =
        await http.get(Uri.parse('$baseUrl/api/doctor/send-apk/get/$id'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      sendApkData.value = SendApkModel.fromJson(data["data"]);
    } else {
      // Handle error
      Get.snackbar('Error', 'Failed to load doctor');
    }
  }
}
