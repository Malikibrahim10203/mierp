import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mierp_apps/core/controller/convertDollar.dart';
import 'package:mierp_apps/core/controller/loading_controller.dart';
import 'package:mierp_apps/core/controller/move_page_controller.dart';
import 'package:mierp_apps/core/controller/user_data_controller.dart';
import 'package:mierp_apps/core/models/user_model.dart';
import 'package:mierp_apps/domain/transaction/services/pay_product_order_services.dart';
import 'package:mierp_apps/data/warehouse/detail/detail_product_order_repository.dart';
import 'package:mierp_apps/core/models/order.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum RequestStatus { idle, loading, success, error }

class DetailProductOrderViewModel extends GetxController {
  DetailProductOrderViewModel(this.id);

  final orderProducts = Rxn<OrderProduct>();
  final totalCost = "".obs;
  final unitPrice = "".obs;

  final id;

  final detailProductOrderR = DetailProductOrderRepository();
  final loadingC = Get.find<LoadingController>();
  final movePageC = Get.find<MovePageController>();
  final convertDollar = ConvertDollar();
  final userDataC = UserDataController();
  final payInvoiceService = Get.find<PayProductOrderServices>();

  RxBool success = false.obs;
  RxString errorMessage = "".obs;

  Rxn role = Rxn();
  RxBool isLoading = false.obs;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getRoleUser();
  }


  Future<void> getRoleUser() async {
    UserModel user = await userDataC.getDataUser();
    role.value = user.role;
  }

  Future<void> requestPayInvoid(docId, prodId, totalQty) async {
    try {
      isLoading.value = false;
      loadingC.showLoading();

      await payInvoiceService.payInvoice(docId, prodId, totalQty);

      loadingC.hideLoading();
      success.value = true;
      isLoading.value = false;
    } catch(e) {
      loadingC.hideLoading();
      errorMessage.value = "$e";
      print("Error, $e");
    }
  }

  Future<void> requestSingleProductOrder(docId) async {
    try {
      loadingC.showLoading();
      orderProducts.value = await detailProductOrderR.getSingleProductOrder(docId);
      unitPrice.value = convertDollar.intToDollar(orderProducts.value!.unitPrice);
      totalCost.value = convertDollar.intToDollar(orderProducts.value!.totalCost!);
      Future.delayed(Duration(seconds: 2), () {
        loadingC.hideLoading();
        Get.toNamed("/detail_product_order");
      },);
    } catch(e) {
      loadingC.hideLoading();
      Get.snackbar("Failed", "$e");
    }
  }

  Future<void> requestDeleteProductOrder(docId) async {
    try {
      loadingC.showLoading();
      await detailProductOrderR.deleteSingleProduct(docId);
      Get.snackbar("Success", "Delete success");
      Future.delayed(Duration(seconds: 2), () {
        loadingC.hideLoading();
        movePageC.movePage("/dashboard_warehouse");
      },);
    } catch(e) {
      Get.snackbar("Failed", "$e");
    }
  }
}