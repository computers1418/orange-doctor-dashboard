import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:orange_doctor_dashboard/models/set_problem_model.dart';
import 'package:orange_doctor_dashboard/pages/set_problem/set_problem.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../common_methods/common_methods.dart';
import '../common_methods/custom_print.dart';
import '../constants/url_const.dart';
import '../models/send_apk_model.dart';
import 'api_common_functions.dart';

class ProblemController extends GetxController {
  RxList<SetProblemModel> problemList = <SetProblemModel>[].obs;
  var isFetching = false.obs;


  setData() {
    isFetching.value = true;
    getSetProblemList();
    isFetching.value = false;
  }

  Future getSetProblemList() async {
    problemList.value = await getAllSetProblemList();
  }

  Future<Map<String, dynamic>> setProblem(body, context, fToast) async {
    Map<String, dynamic> resp = {};
    try {
      SharedPreferences shared = await SharedPreferences.getInstance();
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${shared.getString("access_token")}'
      };

      var request =
          http.Request('POST', Uri.parse('${UrlConst.baseUrl}doctor/problem/add'));

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
          // getListInvitation();
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
