import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../common_methods/common_methods.dart';
import '../constants/constants.dart';


class InvitationController extends GetxController{
  RxBool isDataLoading = false.obs;
  RxList brands = [].obs;
  RxList specializations = [].obs;
  RxList invitationsList = [].obs;

  @override
  void onInit() async {
    super.onInit();
    setData();
  }

  setData() async {
    isDataLoading.value = true;
    getInvitationLinkList();
    await getBrands();
    await getSpecialization();
    isDataLoading.value = false;
  }

  Future<Map<String, dynamic>> getBrands() async {
    Map<String, dynamic> resp = {};
    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      var request = http.Request(
          'GET', Uri.parse('$baseUrl/api/brand/list'));
   
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      
      if(response.statusCode == 401){
      }else{
        if (response.statusCode == 200) {
          resp = await CommonMethods.decodeStreamedResponse(response);
          brands.value = resp['data'];
        } else {
          if (kDebugMode) {
            print(response.reasonPhrase);
          }
        }
      }
    } catch (e) {
    }
    return resp;
  }

  Future<Map<String, dynamic>> getSpecialization() async {
    Map<String, dynamic> resp = {};
    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      var request = http.Request(
          'GET', Uri.parse('$baseUrl/api/specialization/list'));
   
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      
      if(response.statusCode == 401){
        // Get.offAndToNamed('login');
      }else{
        if (response.statusCode == 200) {
          resp = await CommonMethods.decodeStreamedResponse(response);
          specializations.value = resp['data'];
        } else {
          if (kDebugMode) {
            print(response.reasonPhrase);
          }
        }
      }
    } catch (e) {
    }
    return resp;
  }

  Future<Map<String, dynamic>> getInvitationLinkList() async {
    Map<String, dynamic> resp = {};
    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      var request = http.Request(
          'GET', Uri.parse('$baseUrl/api/registrationlink/list'));
   
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      
      if(response.statusCode == 401){
      }else{
        if (response.statusCode == 200) {
          resp = await CommonMethods.decodeStreamedResponse(response);
          invitationsList.value = resp['data'];
          print(resp['data']);
        } else {
          if (kDebugMode) {
            print(response.reasonPhrase);
          }
        }
      }
    } catch (e) {
    }
    return resp;
  }

  Future<Map<String, dynamic>> addInvitationLink(body) async {
    Map<String, dynamic> resp = {};
    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      var request = http.Request(
          'POST', Uri.parse('$baseUrl/api/registrationlink/add'));
   
      request.headers.addAll(headers);

      request.body = jsonEncode(body);

      http.StreamedResponse response = await request.send();
      
      if(response.statusCode == 401){
      }else{
        if (response.statusCode == 200) {
          getInvitationLinkList();
        } else {
          if (kDebugMode) {
            print(response.reasonPhrase);
          }
        }
      }
    } catch (e) {
    }
    return resp;
  }

  Future<Map<String, dynamic>> deleteInvitationLink(body) async {
    Map<String, dynamic> resp = {};
    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      var request = http.Request(
          'POST', Uri.parse('$baseUrl/api/registrationlink/delete'));
   
      request.headers.addAll(headers);

      request.body = jsonEncode(body);

      http.StreamedResponse response = await request.send();
      // resp = await CommonMethods.decodeStreamedResponse(response);
      // print(resp);
      if(response.statusCode == 401){
      }else{
        if (response.statusCode == 200) {
          getInvitationLinkList();
        } else {
          if (kDebugMode) {
            print(response.reasonPhrase);
          }
        }
      }
    } catch (e) {
    }
    return resp;
  }
}