import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mierp_apps/features/login/presentation/login_view_model.dart';

class SplashView extends GetView<LoginViewModel> {
  @override
  Widget build(BuildContext context) {
    controller.checkLogin();

    return Scaffold(
      body: Center(
        child: Image.asset("assets/images/mierp.png", width: 100,),
      ),
    );
  }
}