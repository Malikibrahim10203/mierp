import 'package:get/get.dart';
import 'package:mierp_apps/data/login/login_repository.dart';
import 'package:mierp_apps/core/controller/user_data_controller.dart';
import 'package:mierp_apps/core/models/user_model.dart';

class ProfileViewModel extends GetxController {

  final role = "warehouse".obs;
  final userDataC = UserDataController();
  final isLoading = false.obs;

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
      role.value = userModel!.role!;
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


  Future<void> logout() async {
    try {
      isLoading.value = true;
      Future.delayed(Duration(seconds: 2), () async {
        await loginRepository.authFirebase.signOut();
        await loginRepository.googleSignIn.signOut();
      });
      isLoading.value = false;
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