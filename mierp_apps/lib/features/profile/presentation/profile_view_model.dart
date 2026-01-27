import 'package:get/get.dart';
import 'package:mierp_apps/core/session/auth_session.dart';
import 'package:mierp_apps/data/login/login_repository.dart';
import 'package:mierp_apps/core/controller/user_data_controller.dart';
import 'package:mierp_apps/core/models/user_model.dart';

class ProfileViewModel extends GetxController {

  final role = "warehouse".obs;
  final userDataC = UserDataController();
  final isLoading = false.obs;

  RxString name = ''.obs;
  RxBool isVerif = false.obs;

  final LoginRepository loginRepository;
  ProfileViewModel({required this.loginRepository});

  @override
  void onInit() {
    // TODO: implement onInit
    getUserData();
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  Future<void> getUserData() async {
    try {
      UserModel? userModel = await userDataC.getDataUser();
      role.value = userModel.role!;
      name.value = "${userModel.firstName} ${userModel.lastName}";
      isVerif.value = userModel.allowGoogleLogin;
      print(userModel.role);
    } catch(e) {
      Get.snackbar("Failed", "$e");
    }
  }

  Future<void> linkAcccountToGoogle() async {
    try {
      await loginRepository.linkToAnotherAccount();
    } catch(e) {
      Get.snackbar("Failed", "Link account to Google");
    }
  }

  Future<void> deleteAccount() async {
    try {
      isLoading.value = true;
      Future.delayed(Duration(seconds: 1), () async {
        await loginRepository.deleteAccount();
      });
      isLoading.value = false;
      Get.offAllNamed("/login");
      Get.snackbar('Success','User deleted successfully.');
    } catch(e) {
      Get.snackbar('Failed','Error deleted account: $e');
    }
  }

  Future<void> logout() async {
    try {
      isLoading.value = true;

      Future.delayed(Duration(seconds: 2), () {
        isLoading.value = false;
      });

      await loginRepository.authFirebase.signOut();
      await loginRepository.googleSignIn.signOut();

      Get.offAllNamed("/login");
      print('User signed out successfully.');
    } catch(e) {
      print('Error signing out: $e');
    }
  }

  void back() {
    Get.offAllNamed("/dashboard_$role");
  }
}