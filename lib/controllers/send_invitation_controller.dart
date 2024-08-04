import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:orange_doctor_dashboard/controllers/api_common_functions.dart';
import 'package:orange_doctor_dashboard/models/brands_model.dart';
import 'package:orange_doctor_dashboard/models/list_invitation_model.dart';
import 'package:orange_doctor_dashboard/models/resend_invitation_model.dart';
import 'package:orange_doctor_dashboard/models/specilization.dart';
import 'package:http/http.dart' as http;

import '../common_methods/common_methods.dart';
import '../common_methods/custom_print.dart';
import '../constants/constants.dart';

class SendInvitationController extends GetxController {
  var isFetching = false.obs;
  var isSending = false.obs;
  var isResending = false.obs;
  RxList<BrandsModel> brands = <BrandsModel>[].obs;
  RxList<Specialization> specializations = <Specialization>[].obs;
  RxList<ListInvitationModel> sendInvitationList = <ListInvitationModel>[].obs;
  var invitationData = ResendInvitationModel(
    type: '',
    fromApk: false,
    isDeleted: false,
    sendCount: 0,
    sendApkCount: 0,
    isValid: false,
    id: '',
    onboardingCode: '',
    invitationUrl: '',
    expressCode: '',
    specialization: '',
    brand: '',
    name: '',
    brandId: '',
    specializationId: '',
    // onboardingCodeExpiration: DateTime.now(),
    // expressCodeExpiration: DateTime.now(),
    city: '',
    email: '',
    phone: '',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ).obs;

  @override
  void onInit() {
    super.onInit();
    setData();
  }

  setData() {
    isFetching.value = true;
    getListInvitation();
    getBrandsList();
    getSpecializatonList();
    isFetching.value = false;
  }

  Future getBrandsList() async {
    brands.value = await getAllBrands();
  }

  Future getSpecializatonList() async {
    // isFetching.value = true;
    specializations.value = await getAllSepcilizations();

    // isFetching.value = false;
  }

  Future<void> fetchInvitationById(String id) async {
    final response =
        await http.get(Uri.parse('$baseUrl/api/subadmin//getIinvitation/$id'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      invitationData.value = ResendInvitationModel.fromJson(data["data"]);
    } else {
      // Handle error
      Get.snackbar('Error', 'Failed to load doctor');
    }
  }

  Future<Map<String, dynamic>> sendInvitationLink(body, context, fToast) async {
    Map<String, dynamic> resp = {};
    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      var request = http.Request(
          'POST', Uri.parse('$baseUrl/api/subadmin/sendInvitation'));

      request.headers.addAll(headers);

      request.body = jsonEncode(body);

      http.StreamedResponse response = await request.send();
      resp = await CommonMethods.decodeStreamedResponse(response);
      // if (resp["status"] == 401) {
      // } else if (resp["status"] == 403) {
      //   showToast(fToast, resp["message"], true);
      // } else {
      //   if (resp["status"] == true) {
      //     showToast(fToast, resp["messsage"], false);
      //     getListInvitation();
      //   } else {
      //     showToast(fToast, resp["message"], true);
      //     if (kDebugMode) {
      //       print(response.reasonPhrase);
      //     }
      //   }
      // }
      if (response.statusCode == 401) {
      } else if (response.statusCode == 403) {
        showToast(fToast, resp["message"], true);
      } else {
        if (response.statusCode == 200) {
          showToast(fToast, resp["message"], false);
          getListInvitation();
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

  Future<Map<String, dynamic>> resendInvitationLink(
      body, context, fToast) async {
    Map<String, dynamic> resp = {};
    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      var request = http.Request(
          'PUT', Uri.parse('$baseUrl/api/subadmin/resendInvitation'));

      request.headers.addAll(headers);

      request.body = jsonEncode(body);

      http.StreamedResponse response = await request.send();
      print("sdsd=====${body}");
      resp = await CommonMethods.decodeStreamedResponse(response);

      if (response.statusCode == 401) {
      } else if (response.statusCode == 403) {
        showToast(fToast, resp["message"], true);
      } else {
        if (response.statusCode == 200) {
          showToast(fToast, resp["message"], false);
          getListInvitation();
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

  Future<Map<String, dynamic>> getListInvitation() async {
    sendInvitationList.value = [];
    Map<String, dynamic> resp = {};
    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      var request = http.Request(
          'GET', Uri.parse('$baseUrl/api/subadmin/listInvitation'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 401) {
      } else {
        if (response.statusCode == 200) {
          resp = await CommonMethods.decodeStreamedResponse(response);

          if (resp['data'] != null) {
            sendInvitationList.value = (resp["data"] as List)
                .map((item) =>
                    ListInvitationModel.fromJson(item as Map<String, dynamic>))
                .toList();
          } else {
            sendInvitationList.value = [];
            print('Error: resp or resp["data"] is null');
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

  Future<Map<String, dynamic>> deleteInvitationLink(
      body, context, fToast) async {
    Map<String, dynamic> resp = {};
    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      var request = http.Request(
          'DELETE', Uri.parse('$baseUrl/api/subadmin/deleteInvitation'));

      request.headers.addAll(headers);

      request.body = jsonEncode(body);

      http.StreamedResponse response = await request.send();
      resp = await CommonMethods.decodeStreamedResponse(response);
      if (response.statusCode == 401) {
        showToast(fToast, resp["message"], true);
      } else {
        if (response.statusCode == 200) {
          showToast(fToast, resp["data"], false);
          getListInvitation();
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
