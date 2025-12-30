import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mierp_apps/features/dashboard/model/order.dart';

class DetailProductOrderRepository {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<OrderProduct> getSingleProductOrder(docId) async {
    try {
      final snapshot = await firestore.collection("warehouse_orders").doc(docId).get();
      OrderProduct orderProduct = OrderProduct.fromJson(snapshot.data()!, docId: docId);
      return orderProduct;
    } catch(e) {
      rethrow;
    }
  }

  Future<void> deleteSingleProduct(docId) async {
    try {
      await firestore.collection("warehouse_orders").doc(docId).delete();
    } catch(e) {
      rethrow;
    }
  }
}