import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mierp_apps/core/models/order.dart';
import 'package:mierp_apps/core/models/product.dart';
import 'package:mierp_apps/core/models/sales_order.dart';

class InventoryRepository {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;


  Future<List<Product?>> getBulkDataStock(collection) async {
    try {
      final snapshot = await firestore.collection(collection).get();

      return snapshot.docs.map(
              (doc)=>Product.fromJson(doc.data(), docId: doc.id)
      ).toList();
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<List<OrderProduct>> getBulkDataOrder(collection) async {
    try {
      final snapshot = await firestore.collection(collection).get();

      return snapshot.docs.map(
              (doc){
            return OrderProduct.fromJson(doc.data(), docId: doc.id);
          }
      ).toList();
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<List<SalesOrder>> getBulkDataSalesOrder(collection) async {
    try {
      final snapshot = await firestore.collection(collection).get();

      return snapshot.docs.map(
              (doc){
            print("ini ${doc.data()}");
            return SalesOrder.fromJson(doc.data(), docId: doc.id);
          }
      ).toList();
    } catch (e) {
      print(e);
    }
    return [];
  }
}