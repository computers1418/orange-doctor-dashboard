import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../models/brands_model.dart';
import '../models/city_model.dart';
import '../models/specilization.dart';
import 'api_common_functions.dart';

class DoctorController extends GetxController {
  var isFetching = false.obs;
  RxList<BrandsModel> brands = <BrandsModel>[].obs;
  RxList<Specialization> specializations = <Specialization>[].obs;
  var cities = <CityModel>[].obs;

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

  Future getBrandsList() async {
    brands.value = await getAllBrands();
  }

  Future getSpecializatonList() async {
    // isFetching.value = true;
    specializations.value = await getAllSepcilizations();

    // isFetching.value = false;
  }

  Future getCitiesList(String brandId, String specializationId) async {
    Dio dio = Dio();

    cities.clear();
    Map<String, dynamic> data = {
      "brandId": brandId,
      "specializationId": specializationId,
    };

    var response = await dio.request(
      "http://13.127.57.197/api/city/by-brand-specialization",
      data: data,
      options: Options(
        method: 'GET',
      ),
    );
    if (response.statusCode == 200) {
      if (response.data["data"] != null) {
        for (var city in response.data["data"]) {
          cities.add(CityModel.fromJson(city));
        }
      } else {}
    } else {}
  }
}
