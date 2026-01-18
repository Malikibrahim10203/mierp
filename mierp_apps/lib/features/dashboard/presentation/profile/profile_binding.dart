import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mierp_apps/data/login/login_repository.dart';
import 'package:mierp_apps/features/dashboard/presentation/profile/profile_view_model.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(ProfileViewModel(loginRepository: Get.find<LoginRepository>()));
  }
}