import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mierp_apps/core/controller/loading_controller.dart';
import '../../../core/models/user_model.dart';
import '../data/login_repository.dart';

class LoginViewModel extends GetxController {
  final repo = Get.put(LoginRepository());
  final loadingC = Get.find<LoadingController>();
  Rx<UserModel?> user = Rx<UserModel?>(null);
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  Future<void> login (String email, String password) async {
    try {
      UserModel? result = await repo.login(email, password);
      if(result!=null){
        user.value = result;
        print(user.value!.role);
        Future.delayed(Duration(seconds: 3), () {
          loadingC.hideLoading();
          Get.offAllNamed("/dashboard");
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
      UserModel? result = await repo.loginWithGoogle();
      if(result==null) return null;
      user.value = result;
      Future.delayed(Duration(seconds: 3), () {
        loadingC.hideLoading();
        Get.offAllNamed("/dashboard");
      });
    }catch(e) {
      print("object");
    }
  }

  bool get isLoggedIn => repo.currentUser != null;

  Future<void> logout() async {
    try {
      await repo.authFirebase.signOut();
      await repo.googleSignIn.signOut();
      Get.offAllNamed("/login");
      print('User signed out successfully.');
    } catch(e) {
      print('Error signing out: $e');
    }
  }
}