import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mierp_apps/domain/item/repositories/item_repository.dart';
import 'package:mierp_apps/domain/transaction/repository/transaction_repository.dart';
import 'package:mierp_apps/state/item_store.dart';

class TransactionRepositoryImpl implements TransactionRepository {

  FirebaseFirestore firestore;

  TransactionRepositoryImpl({required this.firestore});

  @override
  Future<void> payProductOrderInvoice(prodId,totalQty,date) async {
    await firestore.runTransaction(
      (transaction) async {
        transaction.update(firestore.collection("warehouse_orders").doc(prodId),  {
          'finance_approved': true,
          'finance_approved_date': date,
        });
        transaction.update(firestore.collection("products").doc(prodId), {
          "quantity":FieldValue.increment(totalQty)
        });
      },
    );
  }

  @override
  Future<void> paySalesOrderInvoice(prodId,totalQty,date) async {
    await firestore.runTransaction(
      (transaction) async {
        transaction.update(firestore.collection("sales_orders").doc(prodId), {
          'finance_approved': true,
          'finance_approved_date': date,
        });
        transaction.update(firestore.collection("products").doc(prodId), {
          "quantity":FieldValue.increment(-totalQty)
        });
      },
    );
  }
}