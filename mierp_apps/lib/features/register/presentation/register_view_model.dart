import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mierp_apps/core/controller/loading_controller.dart';
import 'package:mierp_apps/data/register/register_repository.dart';

class RegisterViewModel extends GetxController {

  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  TextEditingController firstNameC = TextEditingController();
  TextEditingController lastNameC = TextEditingController();
  final registerR = Get.put(RegisterRepository());
  final loadingC = Get.put(LoadingController());
  RxString roleC = "warehouse".obs;

  Future<void> RegisterWithEmailPassword() async {
    try {
      loadingC.showLoading();
      await registerR.CreateNewAccount(emailC.text, passwordC.text, firstNameC.text, lastNameC.text, roleC.value);
      Get.snackbar("Register Success", "Your account has benn created!.");
      Future.delayed(Duration(seconds: 3), () {
        loadingC.hideLoading();
        resetController();
        Get.offAllNamed("/login");
      },);
    } catch(e) {
      loadingC.hideLoading();
      Get.snackbar("Register Info", "$e.");
    }
  }

  void resetController() {
    emailC.clear();
    passwordC.clear();
  }
}

