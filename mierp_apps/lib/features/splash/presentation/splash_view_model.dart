import 'dart:convert';

import 'package:get/get.dart';
import 'package:mierp_apps/core/models/user_model.dart';
import 'package:mierp_apps/domain/item/repositories/item_repository.dart';
import 'package:mierp_apps/features/dashboard/presentation/summary/summary_view_model.dart';
import 'package:mierp_apps/features/dashboard/presentation/warehouse/warehouse_view_model.dart';
import 'package:mierp_apps/features/login/presentation/login_view_model.dart';
import 'package:mierp_apps/features/onboarding/onboarding_view_model.dart';
import 'package:mierp_apps/state/item_store.dart';
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
    final prefs = await SharedPreferences.getInstance();
    await Future.delayed(Duration(seconds: 2), () {

      if (!loginC.isLoggedIn) {
        Get.offAllNamed("/login");
        return;
      }
      print("Check Prefs: ${prefs.getString("user")}");

      final dataUserRaw = prefs.getString("user");
      Map<String,dynamic> dataUserJson = jsonDecode(dataUserRaw!);

      final dataUser = UserModel.fromJson(dataUserJson);

      if(dataUser!.role == "warehouse"){
        Get.offAllNamed("/dashboard_warehouse");
      }else{
        Get.offAllNamed("/dashboard_finance");
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