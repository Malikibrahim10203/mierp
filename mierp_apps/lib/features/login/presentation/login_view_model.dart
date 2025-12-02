import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../../core/models/user_model.dart';
import '../data/login_repository.dart';

class LoginViewModel extends GetxController {
  final LoginRepository repo = LoginRepository();
  Rx<UserModel?> user = Rx<UserModel?>(null);

  Future<void> login (String email, String password) async {
    try {
      final result = await repo.login(email, password);
      user.value = UserModel(uid: result!.uid, email: result.email!);
      Get.offAllNamed("/dashboard");
    } catch (e) {
      Get.snackbar("Login Gagal", e.toString());
    }
  }

  bool get isLoggedIn => repo.currentUser != null;
  
  Future<void> checkLogin() async {
    await Future.delayed(Duration(seconds: 2));
    if (!isLoggedIn) {
      Get.offAllNamed("/login");
    } else {
      Get.offAllNamed("/dashboard");
    }
  }
}