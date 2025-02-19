import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:orange_doctor_dashboard/models/send_apk_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../common_methods/common_methods.dart';
import '../common_methods/custom_print.dart';
import '../constants/url_const.dart';
import '../models/brands_model.dart';
import '../models/specilization.dart';
import '../respositories/api_middle_wear_api.dart';
import 'api_common_functions.dart';

class ApkController extends GetxController {
  var rxGetList = RxStatus.empty().obs;
  var isFetching = false.obs;
  RxList<BrandsModel> brands = <BrandsModel>[].obs;
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

  Future getAllApkInvitationSearch(body) async {
    isFetching.value = true;
    sendApkList.value = await apkInvitaionSearch(body);
    isFetching.value = false;
  }

  Future<bool> sendApk({required data, required FToast fToast}) async {
    try {
      Map<String, dynamic> resp = {};
      SharedPreferences shared = await SharedPreferences.getInstance();
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${shared.getString("access_token")}'
      };
      var request =
          http.Request('POST', Uri.parse('${UrlConst.baseUrl}doctor/send-apk'));

      request.headers.addAll(headers);

      request.body = jsonEncode(data);
      http.StreamedResponse response = await request.send();
      resp = await CommonMethods.decodeStreamedResponse(response);

      if (response.statusCode == 200) {
        if (resp["data"] != null) {
          showToast(fToast, resp["message"], false);
          getAllSendApkList();
          return true;
        }
      } else {
        showToast(fToast, resp["message"], true);
      }
    } catch (e) {
      printC('error:$e');
    } finally {}
    return false;
  }

  Future<Map<String, dynamic>> resendApk(body, context, fToast) async {
    Map<String, dynamic> resp = {};
    try {
      SharedPreferences shared = await SharedPreferences.getInstance();
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${shared.getString("access_token")}'
      };
      var request = http.Request(
          'POST', Uri.parse('${UrlConst.baseUrl}doctor/resend-apk'));

      request.headers.addAll(headers);

      request.body = jsonEncode(body);

      http.StreamedResponse response = await request.send();
      resp = await CommonMethods.decodeStreamedResponse(response);
      if (response.statusCode == 401) {
      } else if (response.statusCode == 403) {
        showToast(fToast, resp["message"], true);
      } else {
        if (response.statusCode == 200) {
          showToast(fToast, resp["message"], false);
          getAllSendApkList();
        } else {
          showToast(fToast, resp["message"], true);
          if (kDebugMode) {
            print(response.reasonPhrase);
          }
        }
      }
    } catch (e) {}
    return resp;
  }

  Future<Map<String, dynamic>> deleteApk(id, context, fToast) async {
    Map<String, dynamic> resp = {};
    try {
      SharedPreferences shared = await SharedPreferences.getInstance();
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${shared.getString("access_token")}'
      };
      var request = http.Request(
          'DELETE', Uri.parse('${UrlConst.baseUrl}doctor/send-apk/delete/$id'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      resp = await CommonMethods.decodeStreamedResponse(response);
      if (response.statusCode == 401) {
        showToast(fToast, resp["message"], true);
      } else {
        if (response.statusCode == 200) {
          showToast(fToast, resp["data"], false);
          getAllSendApkList();
        } else {
          showToast(fToast, resp["message"], true);
          if (kDebugMode) {
            print(response.reasonPhrase);
          }
        }
      }
    } catch (e) {}
    return resp;
  }

  Future<void> fetchSendApkById(String id) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${shared.getString("access_token")}'
    };
    final response = await http.get(
        Uri.parse('${UrlConst.baseUrl}doctor/send-apk/get/$id'),
        headers: headers);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      sendApkData.value = SendApkModel.fromJson(data["data"]);
    } else {
      // Handle error
      Get.snackbar('Error', 'Failed to load doctor');
    }
  }
}
