import 'package:get/get.dart';
import '../../../view/onboarding/signup/a04/a04_signup_screen.dart';

class A03SignupController extends GetxController {
  void submit() {
    // Perform any required validation or logic here
    Get.to(A04SignupScreen());
  }
}
