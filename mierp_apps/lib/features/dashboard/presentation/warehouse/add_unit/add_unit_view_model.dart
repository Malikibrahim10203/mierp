import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mierp_apps/core/controller/loading_controller.dart';
import 'package:mierp_apps/core/controller/move_page_controller.dart';
import 'package:mierp_apps/features/dashboard/data/warehouse/add_unit_repository.dart';
import 'package:mierp_apps/features/dashboard/model/product.dart';

class AddUnitViewModel extends GetxController {
  final productCodeC = TextEditingController();
  final nameProductC = TextEditingController();
  final createdOnC = TextEditingController();
  final quantityC = TextEditingController();
  final unitPriceC = TextEditingController();
  RxString categoryProductC = "electronics".obs;

  final loadingC = Get.find<LoadingController>();
  final addUnitRepository = Get.put(AddUnitRepository());
  final movePage = Get.find<MovePageController>();


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
        createdOnC.text = formatDateTime;
      }
    }
  }

  Future<void> saveUnit() async {
    Product product = Product(category: categoryProductC.value, createdOn: createdOnC.text, imageProduct: "", productName: nameProductC.text, productCode: productCodeC.text, quantity: int.parse(quantityC.text), unitPrice: int.parse(unitPriceC.text));
    loadingC.showLoading();
    await addUnitRepository.addUnitToFirebase("products", product);
    Future.delayed(Duration(seconds: 2), () {
      loadingC.hideLoading();
      if (addUnitRepository.isSuccess.value) {
        movePage.movePage("/dashboard_warehouse");
        addUnitRepository.isSuccess.value = false;
      } else {
        resetControllerInput();
      }

    });
  }

  void resetControllerInput() {
    productCodeC.clear();
    nameProductC.clear();
    createdOnC.clear();
    quantityC.clear();
    unitPriceC.clear();
    categoryProductC.value = "electronics";
  }
}