import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mierp_apps/core/controller/user_data_controller.dart';
import 'package:mierp_apps/core/models/user_model.dart';
import 'package:mierp_apps/features/dashboard/data/warehouse/warehouse_repository.dart';
import 'package:mierp_apps/features/dashboard/model/order.dart';
import 'package:mierp_apps/features/dashboard/model/product.dart';
import 'package:intl/intl.dart';
import 'package:mierp_apps/features/dashboard/model/sales_order.dart';
import 'package:mierp_apps/features/dashboard/model/tab_item.dart';
import 'package:mierp_apps/features/dashboard/presentation/warehouse/dashboard_warehouse_view.dart';
import 'package:mierp_apps/features/dashboard/presentation/warehouse/summary/summary_view.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WarehouseViewModel extends GetxController {

  final warehouseRepository = WarehouseRepository();
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
    loadAllDataStock();
    getUserData();
    super.onInit();
  }

  void loadAllDataStock() async {
    listProduct.value = await warehouseRepository.getBulkDataStock("products");
    lenghtProduct.value = listProduct.value.length;
  }

  void loadAllDataOrder() async {
    listOrder.value = await warehouseRepository.getBulkDataOrder("warehouse_orders");
  }

  void loadAllDataSalesOrder() async {
    listSalesOrder.value = await warehouseRepository.getBulkDataSalesOrder("sales_orders");
  }

  Future<void> getUserData() async {
    try {
      UserModel? userModel = await userDataC.getDataUser();
      userName.value = userModel!.firstName + " " + userModel!.lastName;

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
      loadAllDataOrder();
    } else if (selected.collection == "products") {
      loadAllDataStock();
    } else {
      loadAllDataSalesOrder();
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

  Future<void> getSingleProducts() async {

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