import 'package:get/get.dart';
import 'package:mierp_apps/features/login/presentation/login_view_model.dart';
import 'package:mierp_apps/features/onboarding/onboarding_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashViewModel extends GetxController {

  final loginC = Get.find<LoginViewModel>();
  final onBoardC = Get.find<OnboardingViewModel>();

  @override
  void onReady() {
    super.onReady();
    Future.microtask(() => _init(),);
  }

  Future<void> checkLogin() async {
    await Future.delayed(Duration(seconds: 2), (){
      if (!loginC.isLoggedIn) {
        Get.offAllNamed("/login");
      } else {
        Get.offAllNamed("/dashboard");
      }
    });
  }

  Future<void> _init() async {
    final isFirst = onBoardC.isFirst;
    if (isFirst.value) {
      Future.delayed(Duration(seconds: 5),() {
        Get.offAllNamed('/onboarding');
      });
    } else {
      checkLogin();
    }
  }
}