import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mierp_apps/core/utils/loading_controller.dart';
import 'package:mierp_apps/core/controller/move_page_controller.dart';
import 'package:mierp_apps/core/theme/app_colors.dart';
import 'package:mierp_apps/core/theme/app_font_weight.dart';
import 'package:mierp_apps/core/widgets/bottom_navbar_helper.dart';
import 'package:mierp_apps/core/widgets/card_dashboard.dart';
import 'package:mierp_apps/core/widgets/card_finance_box.dart';
import 'package:mierp_apps/core/widgets/card_order.dart';
import 'package:mierp_apps/core/widgets/card_sales.dart';
import 'package:mierp_apps/core/widgets/card_stock.dart';
import 'package:mierp_apps/features/detail/presentation/detail_product/detail_product_view_model.dart';
import 'package:mierp_apps/features/dashboard/presentation/finance/dashboard_finance_view_model.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class DashboardFinanceView extends StatelessWidget {
  const DashboardFinanceView({super.key});

  @override
  Widget build(BuildContext context) {
    PersistentTabController _controller = PersistentTabController(initialIndex: 0);
    final loadingC = LoadingController();
    final financeVM = Get.find<DashboardFinanceViewModel>();
    final movePageC = MovePageController();


    ever(
      financeVM.success,
      (status) {
        if (status == true) {
          Get.snackbar("Success", "Success pay invoice");
          financeVM.success.value = false;
        }
      },
    );

    ever(
      financeVM.errorMessage,
      (msg) {
        Get.snackbar("Failed", msg);
        financeVM.errorMessage.value = "";
      },
    );

    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppColors.bgColor,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 23.w),
              child: Column(
                children: [
                  SizedBox(height: 48.h,),
                  Row(
                    children: [
                      Container(
                        width: 37.w,
                        height: 37.h,
                        decoration: BoxDecoration(
                            color: AppColors.electricBlue,
                            borderRadius: BorderRadius.circular(
                                10.w)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image.asset(
                              "assets/images/person.png",
                              width: 33.w,
                              height: 33.h,),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Hello!",
                                  style: GoogleFonts.lexendDeca(
                                      fontWeight: AppFontWeight.regular,
                                      fontSize: 14.sp,
                                      color: AppColors.grayTitle
                                  ),
                                ),
                                Obx(() {
                                  return Text(
                                    "${financeVM.userName.value}!",
                                    style: GoogleFonts.lexendDeca(
                                        fontWeight: AppFontWeight.semiBold,
                                        fontSize: 19.sp,
                                        color: AppColors.grayTitle
                                    ),
                                  );
                                }),
                              ],
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.notifications_active, size: 24.w,),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 13.62.h,),
                  CardFinanceBox(
                    categoryItems: financeVM.productsItem,
                    settled: financeVM.settled,
                    accountPayables: financeVM.accountPayables,
                    accountReceiables: financeVM.accountReceivables,),
                  SizedBox(height: 12.3.h,),
                  Column(
                    spacing: 9.h,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CardDashboard(nameBox: "Product",
                            description: "All stock items that are low inventory",
                            totalItems: financeVM.productTotal,
                            urgent: false,),
                          CardDashboard(nameBox: "Total Qty",
                            description: "All stock items that are low inventory",
                            totalItems: financeVM.totalQty,
                            urgent: false,)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CardDashboard(nameBox: "Low Stock",
                            description: "All stock items that are low inventory",
                            totalItems: financeVM.lowStock,
                            urgent: true,),
                          CardDashboard(nameBox: "Upcoming Stock",
                            description: "All stock items that are low inventory",
                            totalItems: financeVM.upComingStock,
                            urgent: true,),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 22.h,),
                  Container(
                    width: 345.w,
                    height: 49.h,
                    padding: EdgeInsets.symmetric(
                        vertical: 8.h, horizontal: 22.w),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.shadowBox,
                            spreadRadius: -3.w,
                            offset: Offset(0, 4),
                            blurRadius: 21.w,
                          )
                        ],
                        borderRadius: BorderRadius.circular(10.w)
                    ),
                    child: Center(
                      child: Container(
                        width: 310.w,
                        height: 33.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: financeVM.tabs.map(
                                (e) =>
                                Obx(() {
                                  final isActive = e.isActive.value;
                                  return GestureDetector(
                                    onTap: () async {
                                      financeVM.changeTab(e);
                                      print(financeVM.collection.value);
                                    },
                                    child: Container(
                                      height: 33.h,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w),
                                      decoration: isActive ? BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            55.w),
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xFF00B2FF),
                                            Color(0xFF7A00E6)
                                          ],
                                          transform: GradientRotation(-0.05.sw),
                                        ),
                                      ) : BoxDecoration(),
                                      child: Center(
                                        child: Text(
                                          e.title,
                                          style: GoogleFonts.inter(
                                            fontSize: 11.sp,
                                            fontWeight: AppFontWeight.medium,
                                            color: isActive
                                                ? Colors.white
                                                : AppColors.charcoal,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ).toList(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            "Summary"
                        ),
                        GestureDetector(
                          onTap: () {
                            financeVM.moveToSummaryView();
                          },
                          child: Row(
                            children: [
                              Text(
                                "View all",
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: AppColors.charcoal,
                                size: 10.w,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 22.h,),
                  Obx(() {
                    if (financeVM.collection.value == "products" || financeVM.collection.value == "all_summary") {
                      if (financeVM.collection.value.isNotEmpty) {
                        return Container(
                          height: financeVM.listProduct.length >= 2
                              ? 230.w
                              : 500.w,
                          child: Column(
                            spacing: 10.w,
                            children: financeVM.listProduct.take(2)
                                .map((product) =>
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed("/detail_product/${product.id}");
                                  },
                                  child: CardStock(
                                      idBarang: product!.productCode,
                                      namaBarang: product!.productName,
                                      quantity: product!.quantity,
                                      unitPrice: product!.unitPrice,
                                      lineTotal: product!.unitPrice *
                                          product!.quantity,
                                      type: product!.category),
                                ),
                            ).toList(),
                          ),
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    } else
                    if (financeVM.collection.value == "warehouse_orders") {
                      if (financeVM.listOrder.isNotEmpty) {
                        return Column(
                          spacing: 10.w,
                          children: financeVM.listOrder.take(2).map(
                                  (data) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.toNamed("/detail_product_order/${data.id}");
                                  },
                                  child: CardOrder(
                                    idOrder: data!.id,
                                    idBarang: data!.productCode,
                                    namaBarang: data!.productName,
                                    financeApproved: data!.financeApproved,
                                    createdOn: data!.orderDate,
                                    nameUser: data!.firstName,
                                    quantity: data!.quantity,
                                    unitPrice: data!.unitPrice,
                                    lineTotal: data!.totalCost,
                                    finance: true,
                                    onPayPressed: () => financeVM.requestPayProductOrder(data!.id, data!.productId, data!.quantity),
                                  ),
                                );
                              }
                          ).toList(),
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    } else {
                      return Column(
                        children: financeVM.listSalesOrder.take(2).map(
                              (data) =>
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      Get.toNamed("/detail_sales_order/${data!.id}");
                                    },
                                    child: CardSales(
                                      idBarang: data!.productCode,
                                      namaBarang: data!.productName,
                                      financeApproved: data!.financeApproved,
                                      createdOn: data!.purchasedDate,
                                      nameUser: data!.firstName,
                                      quantity: data!.quantity,
                                      unitPrice: data!.unitPrice,
                                      lineTotal: data!.totalPrice,
                                      nameCustomer: data!.companyName,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.w,
                                  ),
                                ],
                              ),).toList(),
                      );
                    }
                  }),
                  SizedBox(height: 22.h,)
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            padding: EdgeInsetsGeometry.only(
                left: 16.w, right: 16.w, top: 12.w, bottom: 6.w),
            height: 58.w,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MainBottomAppBarHelper(icon: "assets/icons/home-2.svg", label: "Home", voidCallback: (){}),
                BottomAppBarHelper(icon: "assets/icons/search-normal.svg", page: ""),
                BottomAppBarHelper(icon: "assets/icons/graph.svg", page: ""),
                BottomAppBarHelper(icon: "assets/icons/clock.svg", page: ""),
                BottomAppBarHelper(
                    icon: "assets/icons/user.svg", page: "/profile")
              ],
            ),
          ),
        ),
        Obx(() => loadingC.isLoading.value || financeVM.isLoading.value ? Container(color: Colors.black26,
            child: Center(
                child: LoadingAnimationWidget.stretchedDots(color: AppColors
                    .softWhite, size: 70.w,))) : SizedBox(),)
      ],
    );
  }
}
