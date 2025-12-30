import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mierp_apps/core/controller/loading_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/models/user_model.dart';
import '../data/login_repository.dart';

class LoginViewModel extends GetxController {
  final repo = Get.put(LoginRepository());
  final loadingC = Get.find<LoadingController>();
  Rx<UserModel?> user = Rx<UserModel?>(null);
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  RxBool isValid = true.obs;

  Future<void> login (String email, String password) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      UserModel? result = await repo.login(email, password);
      if(result!=null){
        user.value = result;
        final dataUserRaw = jsonEncode(user.value);
        await prefs.setString('user', dataUserRaw);
        print(prefs.getString('user'));
        print(user.value!.role);
        Future.delayed(Duration(seconds: 3), () {
          loadingC.hideLoading();
          if(user.value!.role == "warehouse"){
            Get.offAllNamed("/dashboard_warehouse");
          }else if(user.value!.role == "finance"){
            Get.offAllNamed("/dashboard_finance");
          }
        });
      } else {
        loadingC.hideLoading();
        switch (repo.eCode.value) {
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
      print("Chekkk ${repo.eCode.value}");
    } catch (e) {
      loadingC.hideLoading();
      Get.snackbar("Login Gagal", e.toString());
    }
  }

  Future<void> loginWithGoogle() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      UserModel? result = await repo.loginWithGoogle();
      if(result==null) return null;
      final dataUserRaw = jsonEncode(result);
      await prefs.setString('user', dataUserRaw);
      print("Saved User: ${prefs.getString("user")}");
      loadingC.showLoading();
      user.value = result;
      Future.delayed(Duration(seconds: 3), () {
        loadingC.hideLoading();
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

  Future<void> linkAcccountToGoogle() async {
    try {
      final linkVM = Get.find<LoginRepository>();
      loadingC.showLoading();
      await linkVM.linkToAnotherAccount();
      Future.delayed(Duration(seconds: 2), () => loadingC.hideLoading());
    } catch(e) {
      Get.snackbar("Failed", "Link account to Google");
    }
  }

  bool get isLoggedIn => repo.currentUser != null;

  Future<void> logout() async {
    try {
      loadingC.showLoading();
      Future.delayed(Duration(seconds: 2), () async {
        await repo.authFirebase.signOut();
        await repo.googleSignIn.signOut();
      });
      loadingC.hideLoading();
      Get.offAllNamed("/login");
      print('User signed out successfully.');
    } catch(e) {
      print('Error signing out: $e');
    }
  }
}