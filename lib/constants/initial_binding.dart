import 'package:get/get.dart';
import 'package:orange_doctor_dashboard/controllers/send_invitation_controller.dart';
import '../controllers/create_specialization_vc.dart';

class AppInitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateSpecializationVC>(
      () => CreateSpecializationVC(),
      fenix: true,
    );

    Get.lazyPut<SendInvitationController>(
      () => SendInvitationController(),
      fenix: true,
    );
  }
}
