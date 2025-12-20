import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mierp_apps/features/dashboard/model/product.dart';
import 'package:mierp_apps/features/dashboard/model/order.dart';
import 'package:get/get.dart';

class WarehouseRepository {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;


  Future<List<Product?>> getBulkDataStock(collection) async {
    try {
      final snapshot = await firestore.collection(collection).get();
      
      return snapshot.docs.map(
          (doc)=>Product.fromJson(doc.data())
      ).toList();
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<List<Product>> searchProducts(collection,searchKey) async {
    try {
      // final snapshot = await firestore.collection(collection).get();

      final snapshot  = await firestore.collection(collection)
          .where('product_name', isGreaterThanOrEqualTo: searchKey)
          .where('product_name', isLessThan: '${searchKey}z')
          .get();

      final result = snapshot
          .docs.map((data)=>Product.fromJson(data.data()))
          .toList();

      return result;
    } catch(e) {
      print(e);
      return [];
    }
  }

  Future<List<OrderProduct>> searchOrder(collection, searchKey) async {
    try {
      final snapshot = await firestore.collection(collection)
          .where('product_name', isGreaterThanOrEqualTo: searchKey)
          .where('product_name', isLessThan: '${searchKey}z')
          .get();

      final result = snapshot.docs.map((data) => OrderProduct.fromJson(data.data())).toList();

      return result;
    } catch(e) {
      print(e);
      return [];
    }
  }

  Future<List<OrderProduct>> getBulkDataOrder(collection) async {
    try {
      final snapshot = await firestore.collection(collection).get();

      return snapshot.docs.map(
              (doc)=>OrderProduct.fromJson(doc.data())
      ).toList();
    } catch (e) {
      print(e);
    }
    return [];
  }

  DateTime? parseDate(value) {
    if (value is String) return DateTime.tryParse(value);
    return null;
  }
}