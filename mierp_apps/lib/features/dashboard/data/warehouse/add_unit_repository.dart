import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mierp_apps/features/dashboard/model/product.dart';

class AddUnitRepository extends GetxController {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxBool isSuccess = false.obs;

  Future<void> addUnitToFirebase(collection, Product data) async {
    try {
      await firestore.collection(collection).add({
        "category": data.category,
        "created_on": data.createdOn,
        "image_product": null,
        "product_name": data.productName,
        "product_code": data.productCode,
        "quantity": data.quantity,
        "unit_price": data.unitPrice,
      });
      isSuccess.value = true;
      Get.snackbar("Success", "Success add unit!");
    } catch(e) {
      Get.snackbar("Error add unit", "$e");
    }
  }
}
