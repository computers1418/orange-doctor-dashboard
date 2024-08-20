// import 'package:get/get.dart';

import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common_methods/custom_print.dart';
import '../constants/url_const.dart';
import '../services/api/api.dart';

class AdminController extends GetxController {
  Api api = Api();

  void adminLogin(userName, password, FToast fToast) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    try {
      await api.sendRequest.post("${UrlConst.baseUrl}admin/login",
          data: {"userName": userName, "password": password}).then(
        (value) {
          if (value.statusCode == 200) {
            showToast(fToast, value.data['message'].toString(), false);
            print("Sdsdsdsd======${value.data["data"]["accessToken"]}");
            shared.setString("access_token", value.data["data"]["accessToken"]);
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
}
