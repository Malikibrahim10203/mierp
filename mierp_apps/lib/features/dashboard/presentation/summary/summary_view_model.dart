import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mierp_apps/core/utils/loading_controller.dart';
import 'package:mierp_apps/data/transaction/services/transaction_services.dart';
import 'package:mierp_apps/data/user_data_controller.dart';
import 'package:mierp_apps/core/models/user_model.dart';
import 'package:mierp_apps/domain/item/repositories/item_repository.dart';
import 'package:mierp_apps/data/summary/summary_repository.dart';
import 'package:mierp_apps/core/models/order.dart';
import 'package:mierp_apps/core/models/product.dart';
import 'package:mierp_apps/core/models/sales_order.dart';
import 'package:mierp_apps/core/models/tab_item.dart';
import 'package:mierp_apps/state/item_store.dart';

class SummaryViewModel extends GetxController {

  final ItemRepository itemRepository;
  final ItemStore itemStore;
  final TransactionServices transactionServices;

  SummaryViewModel(this.itemRepository, this.itemStore, this.transactionServices);

  final searchKeyC = TextEditingController();
  final keyword = "".obs;
  final userDataC = UserDataController();
  final summaryR  = SummaryRepository();
  final loadingC = Get.find<LoadingController>();
  // final payInvoiceServiceOrderProduct = Get.find<PayProductOrderServices>();
  // final payInvoiceServiceSalesOrder = Get.find<PaySalesOrderServices>();

  RxInt tag = 1.obs;
  RxBool success = false.obs;
  RxBool isLoading = false.obs;
  final collection = "products".obs;
  final role = "warehouse".obs;
  RxString errorMessage = "".obs;


  List<Product?> get listProduct {
    if(keyword.value.isEmpty){
      return itemStore.listProduct;
    }
    return itemStore.listProduct.where((p) => p!.productName.contains(searchKeyC.text)).toList();
  }

  List<OrderProduct?> get listOrder {

    Iterable<OrderProduct?> orderProducts = itemStore.listOrder;

    if(keyword.value.isNotEmpty){
      orderProducts = itemStore.listOrder.where((p) => p!.productName.contains(searchKeyC.text));
    }

    if(tag.value == 1){
      orderProducts = itemStore.listOrder.where(
            (p) => p!.productName.contains(keyword.value),
      );
    }

    if(tag.value == 2){
      orderProducts = itemStore.listOrder.where(
            (p) => !p!.financeApproved!,
      );
    }

    return orderProducts.toList();
  }

  List<SalesOrder?> get listSalesOrder {

    Iterable<SalesOrder?> salesOrder = itemStore.listSalesOrder;

    if(keyword.value.isNotEmpty){
      salesOrder = itemStore.listSalesOrder.where((p) => p!.productName.contains(searchKeyC.text));
    }

    if(tag.value == 1){
      salesOrder = itemStore.listSalesOrder.where(
            (p) => p!.productName.contains(keyword.value),
      );
    }

    if(tag.value == 2){
      salesOrder = itemStore.listSalesOrder.where(
            (p) => !p!.financeApproved!,
      );
    }

    return salesOrder.toList();
  }

  final tabs = [
    TabItem("All Summary", true.obs, "products"),
    TabItem("Order", false.obs, "warehouse_orders"),
    TabItem("Sales Order", false.obs, "sales_orders"),
    TabItem("Stock", false.obs, "products"),
  ];

  RxList<String> options = [
    'All', 'Paid', 'Unpaid',
  ].obs;

  late final summaryVM;

  @override
  void onInit() {
    // TODO: implement onInit
    itemRepository.getBulkDataStock();
    getUserData();
    super.onInit();
  }

  void filterData(select) async {
    tag.value = select;
  }

  Future<void> getUserData() async {
    try {
      UserModel? userModel = await userDataC.getDataUser();
      role.value = userModel!.role!;
    } catch(e) {
      Get.snackbar("Failed", "$e");
    }
  }

  void changeTab(TabItem selected) {
    for(var tab in tabs) {
      tab.isActive.value = false;
    }
    if (selected.collection == "warehouse_orders") {
      itemRepository.getBulkDataOrder();
    } else if (selected.collection == "products") {
      itemRepository.getBulkDataStock();
    } else {
      itemRepository.getBulkDataSalesOrder();
    }
    tag.value = 0;
    collection.value = selected.collection;
    selected.isActive.value = true;
  }

  Future<void> detailProductOrder(id) async {
    try {
      isLoading.value = true;
      Future.delayed(Duration(seconds: 1), () {
        isLoading.value = false;
        Get.toNamed("/detail_product_order/${id}");
      },);
    } catch(e) {
      loadingC.hideLoading();
      Get.snackbar("Failed", "$e");
    }
  }

  Future<void> detailSalesOrder(id) async {
    try {
      isLoading.value = true;

      Future.delayed(Duration(seconds: 1), () {
        isLoading.value = false;
        Get.toNamed("/detail_sales_order/${id}");
      },);
    } catch(e) {
      isLoading.value = false;
      Get.snackbar("Failed", "$e");
    }
  }

  Future<void> requestPayInvoiceOrderProduct(docId, prodId, totalQty) async {
    try {
      isLoading.value = true;

      await transactionServices.payProductOrderServices(docId, prodId, totalQty);
      itemRepository.getBulkDataOrder();
      isLoading.value = false;
      success.value = true;
    } catch(e) {
      isLoading.value = false;
      errorMessage.value = "Error, $e";
    }
  }
}