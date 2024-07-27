import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
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

  void createBrandList(String brandName) async {
    try {
      isLoading(true);
      var brandResponse =
          await BrandListServices().createBrandList(brandName).then((val) {
        fetchBrandList();
      });
      isLoading(false);
      if (brandResponse.data['status'].toString() == "200") {
        Fluttertoast.showToast(
            msg: "Added Successfully !",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "Something went wrong !",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (e) {
      isLoading(false);
    }
  }

  void deleteList(String brandId) async {
    try {
      isLoading(true);
      var brandResponse =
          await BrandListServices().deleteList(brandId).then((val) {
        fetchBrandList();
      });

      isLoading(false);
      if (brandResponse.data['status'].toString() == "200") {
        Fluttertoast.showToast(
            msg: "Deleted Successfully !",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "Something went wrong !",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (e) {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    fetchBrandList();
    super.onInit();
  }
}
