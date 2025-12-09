import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mierp_apps/features/register/data/register_repository.dart';

class RegisterViewModel extends GetxController {

  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  TextEditingController firstNameC = TextEditingController();
  TextEditingController lastNameC = TextEditingController();
  final registerR = Get.put(RegisterRepository());
  RxString roleC = "warehouse".obs;

  Future<void> RegisterWithEmailPassword() async {
    try {
      await registerR.CreateNewAccount(emailC.text, passwordC.text, firstNameC.text, lastNameC.text, roleC.value);
      Get.snackbar("Register Success", "Your account has benn created!.");
      Future.delayed(Duration(seconds: 3), () {
        Get.offAllNamed("/login");
      },);
    } catch(e) {
      Get.snackbar("Register Info", "$e.");
    }
  }
}