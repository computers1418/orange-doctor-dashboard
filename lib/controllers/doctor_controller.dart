import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:orange_doctor_dashboard/services/doctor_list_services.dart';

import '../common_methods/custom_print.dart';
import '../models/brands_model.dart';
import '../models/city_model.dart';
import '../models/doctor_model.dart';
import '../models/specilization.dart';
import '../services/brand_list_services.dart';
import 'api_common_functions.dart';

class DoctorController extends GetxController {
  var isFetching = false.obs;
  RxList<BrandsModel> brands = <BrandsModel>[].obs;
  RxList<Specialization> specializations = <Specialization>[].obs;

  // var cities = <CityModel>[].obs;
  RxList<DoctorModel> doctorList = <DoctorModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    setData();
  }

  setData() {
    isFetching.value = true;

    getBrandsList();
    getSpecializatonList();
    isFetching.value = false;
  }

  Future getDoctorListByCity(formData) async {
    isFetching.value = true;
    doctorList.value = await getDoctorByCity(formData);
    isFetching.value = false;
  }

  Future getAllDoctorList() async {
    isFetching.value = true;
    doctorList.value = await getAllDoctorData();
    isFetching.value = false;
  }

  Future getDoctorListBySearch(body) async {
    // isFetching.value = true;
    doctorList.value = await getDoctorBySearch(body);
    // isFetching.value = false;
  }

  Future getBrandsList() async {
    brands.value = await getAllBrands();
  }

  Future getSpecializatonList() async {
    // isFetching.value = true;
    specializations.value = await getAllSepcilizations();

    // isFetching.value = false;
  }

  Future<void> creatDoctorList(data, FToast fToast) async {
    try {
      // isLoading(true);

      await DoctorListServices().createDoctor(data).then((val) {
        // isLoading(false);

        if (val.statusCode == 200) {
          showToast(fToast, "Doctor has been successfully created.", false);
          // fetchBrandList();
          getAllDoctorList();
        } else {
          showToast(fToast, val.data['message'].toString(), true);
        }
      });
    } on DioException catch (e) {
      // isLoading(false);

      if (e.response != null) {
        // The server responded with an error
        showToast(fToast, e.response!.data['message'].toString(), true);
      } else {
        // The request was not sent due to a network issue, timeout, etc.
        showToast(fToast, "An error occurred: ${e.message}", true);
      }
    } catch (e) {
      // isLoading(false);
      showToast(fToast, "An unexpected error occurred", true);
    }
  }
}
