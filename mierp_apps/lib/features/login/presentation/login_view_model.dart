import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:mierp_apps/core/utils/loading_controller.dart';
import 'package:mierp_apps/domain/credential/repository/credential_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/models/user_model.dart';
import '../../../data/login/login_repository.dart';

class LoginViewModel extends GetxController {

  final LoginRepository repo;
  final CredentialRepository credentialRepository;

  LoginViewModel({required this.repo, required this.credentialRepository});

  Rx<UserModel?> user = Rx<UserModel?>(null);
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  RxBool isValid = true.obs;
  RxBool saveCredential = false.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadCredentialUser();
  }

  Future<void> login (String email, String password) async {
    try {
      isLoading.value = true;
      UserModel? result = await repo.login(email, password);
      isLoading.value = false;
      if(result!=null){
        user.value = result;
        final dataUserRaw = jsonEncode(result);

        await credentialRepository.setDataUser(dataUserRaw);

        if(saveCredential.value) {
          await credentialRepository.setCredentialUser(email, true);
        } else {
          await credentialRepository.deletePreference();
        }

        emailC.clear();
        passwordC.clear();

        if(user.value!.role == "warehouse"){
          Get.offAllNamed("/dashboard_warehouse");
        }else if(user.value!.role == "finance"){
          Get.offAllNamed("/dashboard_finance");
        }

      } else {
        isLoading.value = false;
        handleError(repo.eCode.value);
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Login Gagal", e.toString());
    }
  }

  Future<void> loginWithGoogle() async {
    try {
      UserModel? result = await repo.loginWithGoogle();
      if(result==null) return null;
      final dataUserRaw = jsonEncode(result);
      await credentialRepository.setDataUser(dataUserRaw);
      isLoading.value = true;
      user.value = result;
      Future.delayed(Duration(seconds: 3), () {
        isLoading.value = false;
        if(user.value!.role == "warehouse"){
          Get.offAllNamed("/dashboard_warehouse");
        }else if(user.value!.role == "finance"){
          Get.offAllNamed("/dashboard_finance");
        }
      });
    }catch(e) {
      print("Error Google login VM");
    }
  }



  Future<void> loadCredentialUser() async {

    final data = await credentialRepository.loadCredentialUser();
    final email = data.email;
    final save = data.isSave;

    if(save != null) {
      saveCredential.value = save;
    }

    if(save) {
      emailC.text = email??'';
    }
  }

  void handleError(String eCode) {
    switch (eCode) {
      case 'user-not-found':
        Get.snackbar("Login Gagal!", "Email tidak terdaftar");
        break;
      case 'wrong-password':
        Get.snackbar("Login Gagal", "Password salah");
        break;
      case 'invalid-email':
        Get.snackbar("Login Gagal", "Format email salah");
        break;
      case 'auth-error':
      default:
        Get.snackbar("Login Gagal", "Email tidak terdaftar");
        break;
    }
  }
}