import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mierp_apps/core/models/product.dart';

class AddUnitRepository {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

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

    } catch(e) {
      Get.snackbar("Error add unit", "$e");
    }
  }
}
