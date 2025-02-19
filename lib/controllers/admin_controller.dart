// import 'package:get/get.dart';

import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:orange_doctor_dashboard/controllers/home_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common_methods/custom_print.dart';
import '../constants/url_const.dart';
import '../pages/city/create/add_city_view.dart';
import '../services/api/api.dart';

class AdminController extends GetxController {
  Api api = Api();
  HomeController homeController = Get.put(HomeController());

  void adminLogin(context, userName, password, FToast fToast) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    try {
      await api.sendRequest.post("${UrlConst.baseUrl}admin/login",
          data: {"username": userName, "password": password}).then(
        (value) {
          if (value.statusCode == 200) {
            showToast(fToast, value.data['message'].toString(), false);
            shared.setString("access_token", value.data["data"]["accessToken"]);
            shared.setString("userId", value.data["data"]["userId"]);
            String currentTimestamp =
                DateFormat("yyyy-MM-dd").format(DateTime.now());
            shared.setString("login_timestamp", currentTimestamp);
            homeController.addIndex(0);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddCityView())).then(
              (value) {
                fToast = FToast();
                fToast.init(context);
              },
            );
          } else {
            showToast(fToast, value.data['message'].toString(), true);
          }
        },
      );

      // return response;
    } on DioException catch (e) {
      if (e.response != null) {
        // The server responded with an error
        showToast(fToast, e.response!.data['message'].toString(), true);
      } else {
        // The request was not sent due to a network issue, timeout, etc.
        showToast(fToast, "An error occurred: ${e.message}", true);
      }
    } catch (e) {
      showToast(fToast, "An unexpected error occurred", true);
    }
  }

  Future<bool> changePassword(password, newPassword, FToast fToast) async {
    try {
      SharedPreferences shared = await SharedPreferences.getInstance();
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${shared.getString("access_token")}'
      };

      String jsonBody = jsonEncode({
        "userId": shared.getString("userId"),
        "currentPassword": password,
        "newPassword": newPassword
      });
      var request = http.Request(
          'POST', Uri.parse("${UrlConst.baseUrl}admin/change-password"))
        ..headers.addAll(headers)
        ..body = jsonBody;
      var response = await request.send();
      String responseBody = await response.stream.bytesToString();
      var jsonResponse = jsonDecode(responseBody);
      print("dsdsds======${jsonResponse}");
      if (response.statusCode == 200) {
        // if (jsonResponse["data"] != null) {

        showToast(fToast, jsonResponse["message"], false);

        return true;
        // }
      } else {
        showToast(fToast, jsonResponse["message"], true);
      }
    } catch (e) {
      printC('error:$e');
    } finally {}
    return false;
  }
}
