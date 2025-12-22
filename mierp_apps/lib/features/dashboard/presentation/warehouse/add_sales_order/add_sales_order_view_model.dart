import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mierp_apps/core/controller/loading_controller.dart';
import 'package:mierp_apps/core/controller/move_page_controller.dart';
import 'package:mierp_apps/features/dashboard/data/warehouse/add_sales_order_repository.dart';
import 'package:mierp_apps/features/dashboard/data/warehouse/warehouse_repository.dart';
import 'package:mierp_apps/features/dashboard/model/product.dart';
import 'package:mierp_apps/features/dashboard/model/sales_order.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddSalesOrderViewModel extends GetxController {
  final warehouseR = WarehouseRepository();
  final loadingC = Get.find<LoadingController>();
  final addSalesOrderR = AddSalesOrderRepository();
  final movPage = Get.find<MovePageController>();

  RxList<Product?> listProduct = <Product?>[].obs;
  Rxn<Product> selectedProduct = Rxn<Product>();

  final financeApproved = TextEditingController();
  final financeApprovedDate = TextEditingController();
  final orderDateC = TextEditingController();
  String? productCodeC = "";
  String? productIdC = "";
  String? nameProductC = "";
  final quantityC = TextEditingController();
  String? totalCostC = "";
  final companyNameC = TextEditingController();
  final purchasedDateC = TextEditingController();
  String? unitPrice = "";

  @override
  void onInit() {
    // TODO: implement onInit
    loadAllProduct();
    super.onInit();
  }

  void loadAllProduct() async {
    listProduct.value = await warehouseR.getBulkDataStock("products");
  }

  Future<void> showDate(context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        final dateTime = DateTime(pickedDate.year,pickedDate.month,pickedDate.day,pickedTime.hour,pickedTime.minute);
        final formatDateTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
        purchasedDateC.text = formatDateTime;
      }
    }
  }

  Future<void> addSalesOrder() async {
    try {
      final SharedPreferences preferences = await SharedPreferences.getInstance();

      final dataRawUser = await preferences.getString('user');
      Map<String, dynamic> dataUser = jsonDecode(dataRawUser!);
      
      loadingC.showLoading();
      if(selectedProduct.value != null) {
        getDataRaw();
      }

      SalesOrder salesOrder = SalesOrder(
        companyName: companyNameC.text,
        financeApproved: false,
        financeApprovedDate: financeApprovedDate.text,
        firstName: dataUser['first_name'],
        paymentStatus: false,
        productCode: productCodeC!,
        productId: productIdC!,
        productName: nameProductC!,
        purchasedDate: purchasedDateC.text,
        quantity: quantityC.text,
        totalPrice: totalCostC!,
        unitPrice: unitPrice!,
        userId: dataUser['uid'],
      );

      await addSalesOrderR.addSalesOrderToFireStore(salesOrder);
      Get.snackbar("Success", "Success add sales order!");
      Future.delayed(Duration(seconds: 2), () {
        loadingC.hideLoading();
        movPage.movePage("/dashboard_warehouse");
      });
    } catch(e) {
      loadingC.hideLoading();
      Get.snackbar("Failed", "$e");
    }
  }

  void getDataRaw() {

    final totalCost = selectedProduct.value!.unitPrice * int.parse(quantityC.text);

    productIdC = selectedProduct.value!.id;
    productCodeC = selectedProduct.value!.productCode;
    nameProductC = selectedProduct.value!.productName;
    totalCostC = totalCost.toString();
    unitPrice = selectedProduct.value!.unitPrice.toString();
  }

  void resetControllerInput() {
    financeApproved.clear();
    financeApprovedDate.clear();
    orderDateC.clear();
    quantityC.clear();
    selectedProduct.value = null;
  }
}