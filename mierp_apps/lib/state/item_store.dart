import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mierp_apps/core/models/order.dart';
import 'package:mierp_apps/core/models/product.dart';
import 'package:mierp_apps/core/models/sales_order.dart';
import 'package:mierp_apps/domain/item/repositories/item_repository.dart';
import 'package:mierp_apps/data/item/repositories/item_repository_impl.dart';

class ItemStore extends GetxController {

  RxList<Product?> listProduct = <Product>[].obs;
  RxList<OrderProduct?> listOrder = <OrderProduct>[].obs;
  RxList<SalesOrder?> listSalesOrder = <SalesOrder>[].obs;

  void setProducts(List<Product> product) {
    listProduct.assignAll(product);
  }

  void setSalesOrder(List<SalesOrder> salesOrder) {
    listSalesOrder.assignAll(salesOrder);
  }

  void setOrderProduct(List<OrderProduct> orderProduct) {
    listOrder.assignAll(orderProduct);
  }
}