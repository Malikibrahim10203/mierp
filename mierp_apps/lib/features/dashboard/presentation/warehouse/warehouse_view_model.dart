import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mierp_apps/core/controller/loading_controller.dart';
import 'package:mierp_apps/core/controller/user_data_controller.dart';
import 'package:mierp_apps/core/models/user_model.dart';
import 'package:mierp_apps/data/inventory/inventory_repository.dart';
import 'package:mierp_apps/data/warehouse/warehouse_repository.dart';
import 'package:mierp_apps/core/models/order.dart';
import 'package:mierp_apps/core/models/product.dart';
import 'package:intl/intl.dart';
import 'package:mierp_apps/core/models/sales_order.dart';
import 'package:mierp_apps/core/models/tab_item.dart';
import 'package:mierp_apps/features/dashboard/presentation/warehouse/dashboard_warehouse_view.dart';
import 'package:mierp_apps/features/dashboard/presentation/summary/summary_view.dart';
import 'package:mierp_apps/data/login/login_repository.dart';
import 'package:mierp_apps/features/login/presentation/login_view_model.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WarehouseViewModel extends GetxController {

  final warehouseRepository = WarehouseRepository();
  final inventoryRepository = InventoryRepository();

  final userDataC = UserDataController();

  RxList<Product?> listProduct = <Product>[].obs;
  RxList<OrderProduct?> listOrder = <OrderProduct>[].obs;
  RxList<SalesOrder?> listSalesOrder = <SalesOrder>[].obs;

  RxInt lenghtProduct = 0.obs;
  RxInt totalQtyProduct = 0.obs;
  RxInt totalLowProduct = 0.obs;
  RxInt totalUpcomingProduct = 0.obs;

  RxString collection = "products".obs;
  RxnString userName = RxnString();

  final tabs = [
    TabItem("All Summary", true.obs, "all_summary"),
    TabItem("Order", false.obs, "warehouse_order"),
    TabItem("Sales Order", false.obs, "sales_order"),
    TabItem("Stock", false.obs, "products")
  ];

  @override
  void onInit() {
    // TODO: implement onInit
    totalQtyProduct.bindStream(warehouseRepository.streamGetQtyProduct());
    totalLowProduct.bindStream(warehouseRepository.streamGetLowStock());
    totalUpcomingProduct.bindStream(warehouseRepository.streamGetUpcomingStock());
    requestAllDataProduct();
    getUserData();
    super.onInit();
  }

  void requestAllDataProduct() async {
    listProduct.value = await inventoryRepository.getBulkDataStock("products");
    lenghtProduct.value = listProduct.value.length;
  }

  void requestAllDataOrder() async {
    listOrder.value = await inventoryRepository.getBulkDataOrder("warehouse_orders");
  }

  void requestAllDataSalesOrder() async {
    listSalesOrder.value = await inventoryRepository.getBulkDataSalesOrder("sales_orders");
  }

  Future<void> getUserData() async {
    try {
      UserModel? userModel = await userDataC.getDataUser();
      userName.value = userModel!.firstName! + " " + userModel!.lastName!;

    } catch(e) {
      Get.snackbar("Failed", "$e");
    }
  }

  String convertDollar(value) {
    final dollar = NumberFormat.currency(
      locale: 'en_US',
      symbol: "\$",
      decimalDigits: 0
    ).format(value);
    return dollar;
  }

  void changeTab(TabItem selected) {
    for(var tab in tabs) {
      tab.isActive.value = false;
    }
    if (selected.collection == "warehouse_order") {
      requestAllDataOrder();
    } else if (selected.collection == "products") {
      requestAllDataProduct();
    } else {
      requestAllDataSalesOrder();
    }
    collection.value = selected.collection;
    selected.isActive.value = true;
  }

  List<Widget> buildScreens() {
    return [
      DashboardWarehouseView(),
      SummaryView()
    ];
  }

  List<PersistentBottomNavBarItem> navbarItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: "Home",
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.inactiveGray,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: "/",
          routes: {
            "/first": (final context) => DashboardWarehouseView(),
            "/second": (final context) => SummaryView(),
          },
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.settings),
        title: "Settings",
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.inactiveGray,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: "/",
          routes: {
            "/first": (final context) => DashboardWarehouseView(),
            "/second": (final context) => SummaryView(),
          },
        ),
      ),
    ];
  }

}