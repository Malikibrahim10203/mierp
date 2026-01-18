import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mierp_apps/data/login/login_repository.dart';
import 'package:mierp_apps/features/login/presentation/login_view_model.dart';

class DashboardView extends StatelessWidget {
  DashboardView({super.key});

  final loginViewModel = Get.find<LoginViewModel>();
  final linkVM = Get.find<LoginRepository>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // ElevatedButton(
          //   onPressed: loginViewModel.logout,
          //   child: Text("Logout"),
          // ),
          ElevatedButton(onPressed: (){
            linkVM.linkToAnotherAccount();
          }, child: Text("Linking")),
        ],
      ),
    );
  }
}
