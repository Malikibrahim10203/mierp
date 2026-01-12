import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mierp_apps/core/models/order.dart';
import 'package:mierp_apps/core/models/product.dart';
import 'package:mierp_apps/core/models/sales_order.dart';

abstract class ItemRepository {

  Future<void> getBulkDataStock();

  Future<void> getBulkDataOrder();

  Future<void> getBulkDataSalesOrder();
}