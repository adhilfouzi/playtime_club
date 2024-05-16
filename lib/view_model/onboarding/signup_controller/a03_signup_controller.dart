import 'package:get/get.dart';
import 'package:owners_side_of_turf_booking/view_model/onboarding/signup_controller/image_controller.dart';
import '../../../view/onboarding/signup/screen/a04/a04_signup_screen.dart';

class A03SignupController extends GetxController {
  static A03SignupController get instance => Get.find();
  final image = Get.put(ImageController());
  void submit() {
    // Perform any required validation or logic here
    Get.to(A04SignupScreen());
  }
}
