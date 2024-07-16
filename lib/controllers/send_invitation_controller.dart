import 'package:get/get.dart';
import 'package:orange_doctor_dashboard/controllers/api_common_functions.dart';
import 'package:orange_doctor_dashboard/models/brands_model.dart';
import 'package:orange_doctor_dashboard/models/specilization.dart';

class SendInvitationController extends GetxController {
  var isFetching = false.obs;
  var isSending = false.obs;
  var isResending = false.obs;
  RxList<BrandsModel> brands = <BrandsModel>[].obs;
  RxList<Specialization> specializations = <Specialization>[].obs;

  @override
  void onInit() {
    super.onInit();
    getBrandsList();
    getSpecializatonList();
  }

  Future getBrandsList() async {
    isFetching.value = true;
    brands.value = await getAllBrands();
    isFetching.value = false;
  }

  Future getSpecializatonList() async {
    isFetching.value = true;
    specializations.value = await getAllSepcilizations();
    isFetching.value = false;
  }
}
