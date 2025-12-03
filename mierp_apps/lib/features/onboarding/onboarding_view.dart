import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mierp_apps/features/login/presentation/login_view_model.dart';
import 'package:mierp_apps/features/onboarding/onboarding_view_model.dart';
import 'package:mierp_apps/features/splash/presentation/splash_view_model.dart';

class OnboardingView extends StatelessWidget {
  OnboardingView({super.key});

  final splashC = Get.find<SplashViewModel>();

  @override
  Widget build(BuildContext context) {
    splashC.checkLogin();
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
