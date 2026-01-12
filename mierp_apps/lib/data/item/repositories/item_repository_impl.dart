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

   itemStore.setProducts(data);
  }

  @override
  Future<void> getBulkDataOrder() async {
    final snapshot = await firestore.collection("warehouse_orders").get();

    final data = snapshot.docs.map(
            (doc){
          return OrderProduct.fromJson(doc.data(), docId: doc.id);
        }
    ).toList();

    itemStore.setOrderProduct(data);
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

    itemStore.setSalesOrder(data);
  }
}