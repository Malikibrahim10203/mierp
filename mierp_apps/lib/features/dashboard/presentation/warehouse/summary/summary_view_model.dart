import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mierp_apps/features/dashboard/data/warehouse/warehouse_repository.dart';
import 'package:mierp_apps/features/dashboard/model/tab_item.dart';
import 'package:mierp_apps/features/dashboard/presentation/warehouse/warehouse_view_model.dart';

class SummaryViewModel extends GetxController {

  final searchKeyC = TextEditingController();

  final tabs = [
    TabItem("All Summary", true.obs, "products"),
    TabItem("Order", false.obs, "warehouse_orders"),
    TabItem("Sales Order", false.obs, "warehouse_orders"),
    TabItem("Stock", false.obs, "products"),
  ];

  final collection = "products".obs;
  final warehouseVM = Get.find<WarehouseViewModel>();
  final warehouseRepository = WarehouseRepository();

  @override
  void onInit() {
    // TODO: implement onInit
    warehouseVM.loadAllDataStock();
    super.onInit();
  }

  void changeTab(TabItem selected) {
    for(var tab in tabs) {
      tab.isActive.value = false;
    }
    if(selected.collection == "products") {
      warehouseVM.loadAllDataStock();
    }
    if(selected.collection == "warehouse_orders") {
      warehouseVM.loadAllDataOrder();
    }
    collection.value = selected.collection;
    selected.isActive.value = true;
  }

  Future<void> searchItems() async {
    print(collection.value);
    if(collection.value=="products"){
      final result = await warehouseRepository.searchProducts(collection.value, searchKeyC.text);
      if(result.isNotEmpty){
        warehouseVM.listProduct.clear();
        warehouseVM.listProduct.addAll(result);
      }else{
        if(searchKeyC.text.isNotEmpty){
          warehouseVM.listProduct.clear();
        }else{
          warehouseVM.loadAllDataStock();
        }
      }
    } else {
      final result = await warehouseRepository.searchOrder(collection.value, searchKeyC.text);
      if(result.isNotEmpty){
        warehouseVM.listOrder.clear();
        warehouseVM.listOrder.addAll(result);
      }else{
        if(searchKeyC.text.isNotEmpty){
          warehouseVM.listOrder.clear();
        }else{
          warehouseVM.loadAllDataOrder();
        }
      }
    }
  }
}