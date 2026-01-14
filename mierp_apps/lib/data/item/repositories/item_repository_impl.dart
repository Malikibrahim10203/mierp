import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mierp_apps/core/models/order.dart';
import 'package:mierp_apps/core/models/product.dart';
import 'package:mierp_apps/core/models/sales_order.dart';
import 'package:mierp_apps/data/inventory/inventory_repository.dart';
import 'package:mierp_apps/domain/item/repositories/item_repository.dart';
import 'package:mierp_apps/state/item_store.dart';

class ItemStoreRepositoryImpl implements ItemRepository {

  final FirebaseFirestore firestore;
  final ItemStore itemStore;

  ItemStoreRepositoryImpl(this.firestore,this.itemStore);

  @override
  Future<void> getBulkDataStock() async {
     final snapshot = await firestore.collection("products").get();

     final data = snapshot.docs.map(
              (doc)=>Product.fromJson(doc.data(), docId: doc.id)
      ).toList();

     itemStore.setProductsList(data);
  }

  @override
  Future<void> getBulkDataOrder() async {
    try {
      final snapshot = await firestore.collection("warehouse_orders").get();

      final data = snapshot.docs.map(
              (doc){
            return OrderProduct.fromJson(doc.data(), docId: doc.id);
          }
      ).toList();

      itemStore.setOrderProductList(data);
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  @override
  Future<void> getBulkDataSalesOrder() async {
    final snapshot = await firestore.collection("sales_orders").get();

    final data = snapshot.docs.map(
            (doc){
          print("ini ${doc.data()}");
          return SalesOrder.fromJson(doc.data(), docId: doc.id);
        }
    ).toList();

    itemStore.setSalesOrderList(data);
  }

  @override
  Future<void> getDetailDataStock(prodId) async {
    final snapshot = await firestore.collection("products").doc(prodId).get();
    final data = Product.fromJson(snapshot.data() as Map<String, dynamic>, docId: prodId);
    itemStore.setProducts(data);
  }

  @override
  Future<void> getDetailDataOrder(prodId) async {
    final snapshot = await firestore.collection("warehouse_orders").doc(prodId).get();
    final data = OrderProduct.fromJson(snapshot.data() as Map<String, dynamic>, docId: prodId);
    itemStore.setOrderProduct(data);
  }

  @override
  Future<void> getDetailDataSalesOrder(prodId) async {
    final snapshot = await firestore.collection("sales_orders").doc(prodId).get();
    final data = SalesOrder.fromJson(snapshot.data() as Map<String, dynamic>, docId: prodId);
    itemStore.setSalesOrder(data);
  }
}