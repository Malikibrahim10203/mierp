import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../features/login/presentation/login_view_model.dart';

class LoginMiddleware extends GetMiddleware{
  @override
  RouteSettings? redirect(String? route) {
    final auth = Get.find<LoginViewModel>();
    if (!auth.isLoggedIn) {
      return const RouteSettings(name: "/login");
    }
    return null;
  }
}