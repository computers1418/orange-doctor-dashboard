import 'package:get/get.dart';
import '../pages/specialization/create/create_specialization_vc.dart';

class AppInitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateSpecializationVC>(
      () => CreateSpecializationVC(),
      fenix: true,
    );
  }
}
