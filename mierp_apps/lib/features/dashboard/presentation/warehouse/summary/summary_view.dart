import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mierp_apps/core/controller/convertDollar.dart';
import 'package:mierp_apps/core/controller/loading_controller.dart';
import 'package:mierp_apps/core/controller/move_page_controller.dart';
import 'package:mierp_apps/core/theme/app_colors.dart';
import 'package:mierp_apps/core/theme/app_font_weight.dart';
import 'package:mierp_apps/core/widgets/card_order.dart';
import 'package:mierp_apps/core/widgets/card_sales.dart';
import 'package:mierp_apps/core/widgets/card_stock.dart';
import 'package:mierp_apps/features/dashboard/presentation/warehouse/detail/detail_product_order/detail_product_order_view_model.dart';
import 'package:mierp_apps/features/dashboard/presentation/warehouse/detail/detail_sales_order/detail_sales_order_view_model.dart';
import 'package:mierp_apps/features/dashboard/presentation/warehouse/summary/summary_view_model.dart';
import 'package:mierp_apps/features/dashboard/presentation/warehouse/warehouse_view_model.dart';

class SummaryView extends StatelessWidget {
  SummaryView({super.key});

  final warehouseVM = Get.find<WarehouseViewModel>();
  final summaryVM = Get.find<SummaryViewModel>();
  final movePageC = Get.find<MovePageController>();
  final loadingC = Get.find<LoadingController>();
  final convertDollar = ConvertDollar();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.bgColor,
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                width: double.infinity,
                height: 255.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 112.h,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 4),
                            blurRadius: 14.2.w,
                            spreadRadius: 0,
                            color: AppColors.appBarShadow,
                          )
                        ],
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 63.h,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 30.w),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    movePageC.movePage("/dashboard_warehouse");
                                  },
                                  child: Icon(
                                    Icons.close,
                                    size: 24.w,
                                  ),
                                ),
                                SizedBox(
                                  width: 19.w,
                                ),
                                Text(
                                  "Back To Summary",
                                  style: GoogleFonts.poppins(
                                      fontSize: 16.sp,
                                      fontWeight: AppFontWeight.medium
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 29.h,),
                    Container(
                      width: 344.w,
                      height: 45.29.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              width: 303.47.w,
                              height: 45.29.h,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20.w),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0, 4.w),
                                      color: Color(0xFFE8E8E8),
                                      blurRadius: 20.w,
                                      spreadRadius: 0,
                                    )
                                  ]
                              ),
                              child: TextFormField(
                                controller: summaryVM.searchKeyC,
                                onTap: () {
                                  summaryVM.searchItems();
                                },
                                onChanged: (value) {
                                  summaryVM.searchItems();
                                },
                                textAlignVertical: TextAlignVertical.center,
                                style: GoogleFonts.inter(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.normal
                                ),
                                decoration: InputDecoration(
                                    isDense: true,
                                    hint: Text(
                                      "Search anything...",
                                      style: GoogleFonts.inter(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.normal,
                                        color: AppColors.grayThin,
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 18.03.w),
                                    prefixIcon: Icon(Icons.search, size: 17.47.w,),
                                    border: InputBorder.none
                                ),
                              )
                          ),
                          Icon(
                            Icons.tune,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 22.71.h,),
                    Obx(() {
                      return Container(
                        width: 344.w,
                        height: 32.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: summaryVM.tabs.map((data) {
                            return GestureDetector(
                              onTap: () {
                                summaryVM.changeTab(data);
                              },
                              child: Container(
                                width: 78.w,
                                height: 30.h,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      data!.title,
                                      style: GoogleFonts.manrope(
                                        fontSize: 13.sp,
                                        fontWeight: AppFontWeight.medium,
                                        color: Colors.black,
                                      ),
                                    ),
                                    !data.isActive.value ? SizedBox() : Column(
                                      children: [
                                        SizedBox(height: 7.h,),
                                        Container(
                                          height: 3.h,
                                          color: AppColors.electricBlue,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    }),
                  ],
                ),
              ),
              Obx(() {
                if(summaryVM.collection.value == "products") {
                  return Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        spacing: 10.w,
                        children: warehouseVM.listProduct.map((data) {
                          return GestureDetector(
                            onTap: () {
                              Get.toNamed("/detail_product", arguments: data.id);
                            },
                            child: CardStock(idBarang: data!.productCode,
                                namaBarang: data!.productName,
                                quantity: data!.quantity,
                                unitPrice: data!.unitPrice,
                                lineTotal: data!.unitPrice *
                                    data!.quantity,
                                type: data!.category),
                          );
                        }).toList(),
                      ).paddingOnly(top: 12.w, bottom: 24.w),
                    ),
                  );
                } else if (summaryVM.collection.value == "warehouse_orders") {
                  return Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        spacing: 10.w,
                        children: warehouseVM.listOrder.map(
                              (data) {
                            return GestureDetector(
                              onTap: () {
                                final detailProductOrder = Get.put(DetailProductOrderViewModel());
                                detailProductOrder.requestSingleProductOrder(data.id);
                              },
                              child: CardOrder(idBarang: data!.productCode,
                                  namaBarang: data!.productName,
                                  financeApproved: data!.financeApproved,
                                  createdOn: data!.orderDate,
                                  nameUser: data!.firstName,
                                  quantity: data!.quantity,
                                  unitPrice: data!.unitPrice,
                                  lineTotal: data!.totalCost),
                            );
                          },
                        ).toList(),
                      ).paddingOnly(top: 12.w, bottom: 24.w),
                    ),
                  );
                } else {
                  return Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        spacing: 10.w,
                        children: warehouseVM.listSalesOrder.map((
                            data) =>
                            GestureDetector(
                              onTap: () {
                                final detailSalesOrderVM = Get.put(DetailSalesOrderViewModel());
                                detailSalesOrderVM.requestSingleSalesOrder(data.id);
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
                            ),).toList(),
                      ).paddingOnly(top: 12.w, bottom: 24.w),
                    ),
                  );
                }
              }),
            ],
          ),
          Obx(()=>loadingC.isLoading.value? Container(color: Colors.black26, child: Center(child: LoadingAnimationWidget.stretchedDots(color: AppColors.softWhite, size: 70.w,))):SizedBox(),)
        ],
      ),
    );
  }
}
