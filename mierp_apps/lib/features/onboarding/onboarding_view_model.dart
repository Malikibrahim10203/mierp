import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mierp_apps/features/login/presentation/login_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingViewModel extends GetxController {

  final isFirst = true.obs;

  final loginC = Get.find<LoginViewModel>();

  Future<bool> isFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstRun = prefs.getBool('is_first_run') ?? true;

    isFirst.value = isFirstRun;

    if(isFirstRun){
      await prefs.setBool('is_first_run', false);
    }
    return isFirstRun;
  }
}