import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mierp_apps/features/dashboard/model/order.dart';
import 'package:mierp_apps/features/dashboard/model/sales_order.dart';

class DetailSalesOrderRepository {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<SalesOrder> getSingleSalesOrder(docId) async {
    try {
      final snapshot = await firestore.collection("sales_orders").doc(docId).get();
      SalesOrder orderSales = SalesOrder.fromJson(snapshot.data()!, docId: docId);
      return orderSales;
    } catch(e) {
      rethrow;
    }
  }

  Future<void> deleteSingleSalesOrder(docId) async {
    try {
      await firestore.collection("sales_orders").doc(docId).delete();
    } catch(e) {
      rethrow;
    }
  }
}