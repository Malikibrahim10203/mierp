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

  Rxn<Product> products = Rxn();
  Rxn<OrderProduct> orderProducts = Rxn();
  Rxn<SalesOrder> salesOrders = Rxn();

  void setProductsList(List<Product> product) {
    listProduct.assignAll(product);
  }

  void setSalesOrderList(List<SalesOrder> salesOrder) {
    listSalesOrder.assignAll(salesOrder);
  }

  void setOrderProductList(List<OrderProduct> orderProduct) {
    listOrder.assignAll(orderProduct);
  }

  void setProducts(Product product) {
    products.value = product;
  }

  void setSalesOrder(SalesOrder salesOrder) {
    salesOrders.value = salesOrder;
  }

  void setOrderProduct(OrderProduct orderProduct) {
    orderProducts.value = orderProduct;
  }

  void clearDetailProduct() {
    products.value = null;
    orderProducts.value = null;
    salesOrders.value = null;
  }
}