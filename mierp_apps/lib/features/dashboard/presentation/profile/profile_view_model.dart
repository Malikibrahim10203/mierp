import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mierp_apps/core/controller/user_data_controller.dart';
import 'package:mierp_apps/core/models/user_model.dart';
import 'package:mierp_apps/data/summary/summary_repository.dart';
import 'package:mierp_apps/data/warehouse/warehouse_repository.dart';
import 'package:mierp_apps/core/models/order.dart';
import 'package:mierp_apps/core/models/product.dart';
import 'package:mierp_apps/core/models/sales_order.dart';
import 'package:mierp_apps/core/models/tab_item.dart';
import 'package:mierp_apps/features/dashboard/presentation/finance/dashboard_finance_view_model.dart';
import 'package:mierp_apps/features/dashboard/presentation/warehouse/warehouse_view_model.dart';

class ProfileViewModel extends GetxController {

  final role = "warehouse".obs;
  final userDataC = UserDataController();

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
}