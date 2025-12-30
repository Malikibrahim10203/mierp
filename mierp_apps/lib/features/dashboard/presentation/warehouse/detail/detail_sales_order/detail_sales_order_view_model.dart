import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mierp_apps/core/controller/convertDollar.dart';
import 'package:mierp_apps/core/controller/loading_controller.dart';
import 'package:mierp_apps/core/controller/move_page_controller.dart';
import 'package:mierp_apps/features/dashboard/data/warehouse/detail/detail_product_order_repository.dart';
import 'package:mierp_apps/features/dashboard/data/warehouse/detail/detail_sales_order_repository.dart';
import 'package:mierp_apps/features/dashboard/model/order.dart';
import 'package:mierp_apps/features/dashboard/model/sales_order.dart';

class DetailSalesOrderViewModel extends GetxController {

  final orderSales = Rxn<SalesOrder>();
  final totalCost = "".obs;
  final unitPrice = "".obs;

  final detailSalesOrderR = DetailSalesOrderRepository();
  final loadingC = Get.find<LoadingController>();
  final movePageC = Get.find<MovePageController>();
  final convertDollar = ConvertDollar();

  Future<void> requestSingleSalesOrder(docId) async {
    try {
      loadingC.showLoading();
      orderSales.value = await detailSalesOrderR.getSingleSalesOrder(docId);
      unitPrice.value = convertDollar.intToDollar(orderSales.value!.unitPrice);
      totalCost.value = convertDollar.intToDollar(orderSales.value!.totalPrice!);
      Future.delayed(Duration(seconds: 2), () {
        loadingC.hideLoading();
        Get.toNamed("/detail_sales_order");
      },);
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