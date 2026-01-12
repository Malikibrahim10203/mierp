import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mierp_apps/core/controller/convertDollar.dart';
import 'package:mierp_apps/core/controller/loading_controller.dart';
import 'package:mierp_apps/core/controller/move_page_controller.dart';
import 'package:mierp_apps/core/controller/user_data_controller.dart';
import 'package:mierp_apps/core/models/user_model.dart';
import 'package:mierp_apps/domain/transaction/services/pay_sales_order_services.dart';
import 'package:mierp_apps/data/warehouse/detail/detail_product_order_repository.dart';
import 'package:mierp_apps/data/warehouse/detail/detail_sales_order_repository.dart';
import 'package:mierp_apps/core/models/order.dart';
import 'package:mierp_apps/core/models/sales_order.dart';

class DetailSalesOrderViewModel extends GetxController {

  DetailSalesOrderViewModel({required this.id});

  final orderSales = Rxn<SalesOrder>();
  final totalCost = "".obs;
  final unitPrice = "".obs;
  final id;

  final detailSalesOrderR = DetailSalesOrderRepository();
  final loadingC = Get.find<LoadingController>();
  final movePageC = Get.find<MovePageController>();
  final paySalesOrderService = Get.find<PaySalesOrderServices>();
  final convertDollar = ConvertDollar();
  final userDataC = UserDataController();

  RxBool success = false.obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = "".obs;
  Rxn role = Rxn();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    requestSingleSalesOrder();
    getRoleUser();
  }

  Future<void> getRoleUser() async {
    UserModel user = await userDataC.getDataUser();
    role.value = user.role;
  }

  Future<void> requestPaySalesOrder(docId, prodId, totalQty) async {
    try {
      isLoading.value = true;

      await paySalesOrderService.payInvoice(docId, prodId, totalQty);

      isLoading.value = false;
      success.value = true;
    } catch(e) {
      isLoading.value = false;
      errorMessage.value = "$e";
    }
  }

  Future<void> requestSingleSalesOrder() async {
    try {
      isLoading.value = true;
      orderSales.value = await detailSalesOrderR.getSingleSalesOrder(id);
      unitPrice.value = convertDollar.intToDollar(orderSales.value!.unitPrice);
      totalCost.value = convertDollar.intToDollar(orderSales.value!.totalPrice!);
      isLoading.value = false;
    } catch(e) {
      loadingC.hideLoading();
      Get.snackbar("Failed", "$e");
    }
  }

  Future<void> requestDeleteSalesOrder(docId) async {
    try {
      loadingC.showLoading();
      await detailSalesOrderR.deleteSingleSalesOrder(docId);
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