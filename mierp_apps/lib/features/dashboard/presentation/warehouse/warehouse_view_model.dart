import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mierp_apps/features/dashboard/data/warehouse/warehouse_repository.dart';
import 'package:mierp_apps/features/dashboard/model/order.dart';
import 'package:mierp_apps/features/dashboard/model/product.dart';
import 'package:intl/intl.dart';
import 'package:mierp_apps/features/dashboard/model/tab_item.dart';
import 'package:mierp_apps/features/dashboard/presentation/warehouse/dashboard_warehouse_view.dart';
import 'package:mierp_apps/features/dashboard/presentation/warehouse/summary/summary_view.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:flutter/cupertino.dart';

class WarehouseViewModel extends GetxController {

  final warehouseRepository = WarehouseRepository();
  RxList<Product?> listProduct = <Product>[].obs;
  RxList<OrderProduct?> listOrder = <OrderProduct>[].obs;
  final tabs = [
    TabItem("All Summary", true.obs, "all_summary"),
    TabItem("Order", false.obs, "warehouse_order"),
    TabItem("Sales Order", false.obs, "sales_order"),
    TabItem("Stock", false.obs, "products")
  ];
  RxString collection = "products".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    loadAllDataStock();
    super.onInit();
  }

  void loadAllDataStock() async {
    listProduct.value = await warehouseRepository.getBulkDataStock("products");
  }

  void loadAllDataOrder() async {
    listOrder.value = await warehouseRepository.getBulkDataOrder("warehouse_orders");
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
    if(selected.collection == "warehouse_order") {
      loadAllDataOrder();
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