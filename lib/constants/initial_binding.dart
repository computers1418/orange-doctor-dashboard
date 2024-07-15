import 'package:get/get.dart';
import 'package:orange_doctor_dashboard/pages/city/create/city_controller.dart';
import '../pages/specialization/create/create_specialization_vc.dart';

class AppInitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateSpecializationVC>(
      () => CreateSpecializationVC(),
      fenix: true,
    );
    Get.lazyPut<CityController>(
      () => CityController(),
      fenix: true,
    );
  }
}
