import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mierp_apps/core/controller/convertDollar.dart';
import 'package:mierp_apps/core/controller/loading_controller.dart';
import 'package:mierp_apps/core/controller/move_page_controller.dart';
import 'package:mierp_apps/features/dashboard/data/warehouse/detail/detail_product_order_repository.dart';
import 'package:mierp_apps/features/dashboard/model/order.dart';

class DetailProductOrderViewModel extends GetxController {

  final orderProducts = Rxn<OrderProduct>();
  final totalCost = "".obs;
  final unitPrice = "".obs;

  final detailProductOrderR = DetailProductOrderRepository();
  final loadingC = Get.find<LoadingController>();
  final movePageC = Get.find<MovePageController>();
  final convertDollar = ConvertDollar();

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