import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:orange_doctor_dashboard/common_methods/custom_print.dart';
import 'package:orange_doctor_dashboard/models/brands_model.dart';
import 'package:orange_doctor_dashboard/models/invitation_model.dart';
import 'package:orange_doctor_dashboard/models/specilization.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common_methods/common_methods.dart';
import '../constants/url_const.dart';
import 'api_common_functions.dart';

class InvitationController extends GetxController {
  RxBool isDataLoading = false.obs;
  RxList<BrandsModel> brands = <BrandsModel>[].obs;
  RxList<Specialization> specializations = <Specialization>[].obs;
  RxList<InvitationModel> invitationsList = <InvitationModel>[].obs;

  setData() async {
    isDataLoading.value = true;

    getInvitationLinkList();
    getBrandsList();
    getSpecializatonList();
    isDataLoading.value = false;
  }

  Future getBrandsList() async {
    brands.value = await getAllBrands();
  }

  Future getSpecializatonList() async {
    // isFetching.value = true;
    specializations.value = await getAllSepcilizations();

    // isFetching.value = false;
  }

  Future<Map<String, dynamic>> getInvitationLinkList() async {
    Map<String, dynamic> resp = {};
    SharedPreferences shared = await SharedPreferences.getInstance();
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${shared.getString("access_token")}'
      };
      var request =
          http.Request('GET', Uri.parse('${UrlConst.baseUrl}registrationlink/list'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      resp = await CommonMethods.decodeStreamedResponse(response);
      if (response.statusCode == 401) {
      } else {
        if (response.statusCode == 200) {
          if (resp['data'] != null) {
            invitationsList.value = resp['data']
                .map<InvitationModel>((e) => InvitationModel.fromJson(e))
                .toList();
          } else {
            invitationsList.value = []; // or handle it as needed
          }
        } else {
          if (kDebugMode) {
            print(response.reasonPhrase);
          }
        }
      }
    } catch (e) {
      printC("getInvitationLinkList error $e");
    }
    return resp;
  }

  Future<Map<String, dynamic>> addInvitationLink(body, fToast) async {
    Map<String, dynamic> resp = {};
    SharedPreferences shared = await SharedPreferences.getInstance();
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${shared.getString("access_token")}'
      };
      var request =
          http.Request('POST', Uri.parse('${UrlConst.baseUrl}registrationlink/add'));

      request.headers.addAll(headers);

      request.body = jsonEncode(body);

      http.StreamedResponse response = await request.send();
      resp = await CommonMethods.decodeStreamedResponse(response);
      if (response.statusCode == 401) {
        showToast(fToast, resp["message"], true);
      } else {
        if (response.statusCode == 200) {
          showToast(fToast, "Registration link successfully added.", false);
          getInvitationLinkList();
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

  Future<Map<String, dynamic>> deleteInvitationLink(body, fToast) async {
    Map<String, dynamic> resp = {};
    SharedPreferences shared = await SharedPreferences.getInstance();
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${shared.getString("access_token")}'
      };
      var request = http.Request(
          'POST', Uri.parse('${UrlConst.baseUrl}registrationlink/delete'));

      request.headers.addAll(headers);

      request.body = jsonEncode(body);

      http.StreamedResponse response = await request.send();
      resp = await CommonMethods.decodeStreamedResponse(response);
      // print(resp);
      if (response.statusCode == 401) {
        showToast(fToast, resp["message"], true);
      } else {
        if (response.statusCode == 200) {
          showToast(fToast, "Registration link successfully deleted.", false);
          getInvitationLinkList();
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
}
