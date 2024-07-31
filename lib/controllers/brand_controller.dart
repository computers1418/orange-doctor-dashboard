import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:orange_doctor_dashboard/common_methods/custom_print.dart';
import 'package:orange_doctor_dashboard/models/brand_list_model.dart';

// import 'package:get/get_rx/get_rx.dart';
import 'package:orange_doctor_dashboard/services/brand_list_services.dart';

class BrandController extends GetxController {
  RxBool isLoading = false.obs;
  var brandModel =
      BrandListModel(data: [], status: 0, type: '', message: '').obs;

  // BrandListServices() BrandListServices() = ;
  void fetchBrandList() async {
    try {
      isLoading(true);
      var brandModelData = await BrandListServices().fetchBrandList();
      brandModel(brandModelData);
      isLoading(false);
    } catch (e) {
      isLoading(false);
    }
  }

  void createBrandList(String brandName, FToast fToast) async {
    try {
      isLoading(true);

      await BrandListServices().createBrandList(brandName).then((val) {
        isLoading(false);

        if (val.statusCode == 200) {
          showToast(fToast, val.data['message'].toString(), false);
          fetchBrandList();
        } else {
          showToast(fToast, val.data['message'].toString(), true);
        }
      });
    } on DioException catch (e) {
      isLoading(false);

      if (e.response != null) {
        // The server responded with an error
        showToast(fToast, e.response!.data['message'].toString(), true);
      } else {
        // The request was not sent due to a network issue, timeout, etc.
        showToast(fToast, "An error occurred: ${e.message}", true);
      }
    } catch (e) {
      isLoading(false);
      showToast(fToast, "An unexpected error occurred", true);
    }
  }

  void deleteList(String brandId,fToast) async {
    try {
      isLoading(true);
       await BrandListServices().deleteList(brandId).then((val) {
        isLoading(false);
        if (val.statusCode == 200) {
          showToast(fToast, val.data['message'].toString(), false);
          fetchBrandList();
        } else {
          showToast(fToast, val.data['message'].toString(), true);
        }
      });
    } on DioException catch (e) {
      isLoading(false);

      if (e.response != null) {
        // The server responded with an error
        showToast(fToast, e.response!.data['message'].toString(), true);
      } else {
        // The request was not sent due to a network issue, timeout, etc.
        showToast(fToast, "An error occurred: ${e.message}", true);
      }
    } catch (e) {
      isLoading(false);
      showToast(fToast, "An unexpected error occurred", true);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    fetchBrandList();
    super.onInit();
  }
}
