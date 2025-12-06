import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mierp_apps/features/login/presentation/login_view_model.dart';

class DashboardView extends StatelessWidget {
  DashboardView({super.key});

  final loginViewModel = Get.find<LoginViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
            onPressed: loginViewModel.logout,
            child: Text("Logout"),
          )
        ],
      ),
    );
  }
}
