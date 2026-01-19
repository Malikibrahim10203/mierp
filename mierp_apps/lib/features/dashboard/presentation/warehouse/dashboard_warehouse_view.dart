import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mierp_apps/core/utils/loading_controller.dart';
import 'package:mierp_apps/core/controller/move_page_controller.dart';
import 'package:mierp_apps/core/theme/app_colors.dart';
import 'package:mierp_apps/core/theme/app_font_weight.dart';
import 'package:mierp_apps/core/widgets/bottom_navbar_helper.dart';
import 'package:mierp_apps/core/widgets/card_dashboard.dart';
import 'package:mierp_apps/core/widgets/card_order.dart';
import 'package:mierp_apps/core/widgets/card_stock.dart';
import 'package:mierp_apps/features/dashboard/presentation/warehouse/warehouse_view_model.dart';
import 'package:mierp_apps/data/login/login_repository.dart';
import 'package:mierp_apps/features/login/presentation/login_view_model.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class DashboardWarehouseView extends StatelessWidget {
  DashboardWarehouseView({super.key});

  final linkVM = Get.find<LoginRepository>();
  final warehouseVM = Get.find<WarehouseViewModel>();
  final movePageC = Get.find<MovePageController>();
  final loadingC = LoadingController();

  PersistentTabController _controller = PersistentTabController(
      initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppColors.bgColor,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: 394.w,
                      height: 158.h,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/warehouse_card.png"),
                          fit: BoxFit.cover,
                          alignment: AlignmentGeometry.directional(0, 0.5),
                        ),
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF7A00E6),
                            Color(0xFF4B3FEB),
                            Color(0xFF29B1FF)
                          ],
                          transform: GradientRotation(0.35.sw),
                        ),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(60.w)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 77.h,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 24.w),
                            child: Row(
                              children: [
                                Container(
                                  width: 18.w,
                                  height: 18.h,
                                  child: Image.asset(
                                      "assets/images/warehouse_group.png"),
                                ),
                                SizedBox(
                                  width: 63.w,
                                ),
                                Text(
                                  "Summary Warehouse",
                                  style: GoogleFonts.inter(
                                    fontSize: 16.sp,
                                    fontWeight: AppFontWeight.semiBold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 123.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: 289.w,
                              height: 70.h,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24.w, vertical: 12.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius
                                        .circular(20.w),
                                    topLeft: Radius.circular(20.w)),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.shadowBox,
                                    spreadRadius: -3.w,
                                    offset: Offset(0, 4),
                                    blurRadius: 21.w,
                                  )
                                ],
                              ),
                              child: Row(
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
                                  Container(
                                    width: 192.w,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [
                                            Text(
                                              "Hello!",
                                              style: GoogleFonts.lexendDeca(
                                                  fontWeight: AppFontWeight.regular,
                                                  fontSize: 14.sp,
                                                  color: AppColors.grayTitle
                                              ),
                                            ),
                                            Container(
                                              width: 130.w,
                                              child: Obx(() {
                                                return Text(
                                                  "${warehouseVM.userName.value}!",
                                                  style: GoogleFonts.lexendDeca(
                                                      fontWeight: AppFontWeight.semiBold,
                                                      fontSize: 16.sp,
                                                      color: AppColors.grayTitle
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                );
                                              }),
                                            ),
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
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    spacing: 9.h,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CardDashboard(nameBox: "Product",
                            description: "All stock items that are low inventory",
                            totalItems: warehouseVM.lenghtProduct,
                            urgent: false,),
                          CardDashboard(nameBox: "Total Qty",
                            description: "All stock items that are low inventory",
                            totalItems: warehouseVM.totalQtyProduct,
                            urgent: false,)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CardDashboard(nameBox: "Low Stock",
                            description: "All stock items that are low inventory",
                            totalItems: warehouseVM.totalLowProduct,
                            urgent: true,),
                          CardDashboard(nameBox: "Upcoming Stock",
                            description: "All stock items that are low inventory",
                            totalItems: warehouseVM.totalUpcomingProduct,
                            urgent: true,),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 22.h,
                ),
                Padding(
                  padding: EdgeInsetsGeometry.symmetric(
                      horizontal: 14.h
                  ),
                  child: Container(
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
                          children: [
                            Text(
                              "Add New Unit",
                            ),
                            GestureDetector(
                              onTap: () {
                                movePageC.movePage("/add_unit");
                              },
                              child: Container(
                                width: 36.w,
                                height: 33.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.w),
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF00B2FF),
                                      Color(0xFF7A00E6)
                                    ],
                                    transform: GradientRotation(-0.05.sw),
                                  ),
                                ),
                                child: Icon(Icons.add, color: Colors.white,),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 22.h,
                ),
                Padding(
                  padding: EdgeInsetsGeometry.symmetric(
                      horizontal: 14.h
                  ),
                  child: Container(
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
                          children: [
                            Text(
                              "Add Sales Order",
                            ),
                            GestureDetector(
                              onTap: () {
                                movePageC.movePage("/add_sales_order");
                              },
                              child: Container(
                                width: 36.w,
                                height: 33.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.w),
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF00B2FF),
                                      Color(0xFF7A00E6)
                                    ],
                                    transform: GradientRotation(-0.05.sw),
                                  ),
                                ),
                                child: Icon(Icons.add, color: Colors.white,),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 22.h,
                ),
                Padding(
                  padding: EdgeInsetsGeometry.symmetric(
                      horizontal: 14.h
                  ),
                  child: Container(
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
                          children: [
                            Text(
                              "Add Product Order",
                            ),
                            GestureDetector(
                              onTap: () {
                                movePageC.movePage("/add_product_order");
                              },
                              child: Container(
                                width: 36.w,
                                height: 33.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.w),
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF00B2FF),
                                      Color(0xFF7A00E6)
                                    ],
                                    transform: GradientRotation(-0.05.sw),
                                  ),
                                ),
                                child: Icon(Icons.add, color: Colors.white,),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 22.h,
                ),
                Padding(
                  padding: EdgeInsetsGeometry.symmetric(
                      horizontal: 14.h
                  ),
                  child: Container(
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
                          children: warehouseVM.tabs.map(
                                (e) =>
                                Obx(() {
                                  final isActive = e.isActive.value;
                                  return GestureDetector(
                                    onTap: () async {
                                      warehouseVM.changeTab(e);
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
                ),
                SizedBox(
                  height: 22.h,
                ),
                Padding(
                  padding: EdgeInsetsGeometry.symmetric(
                      horizontal: 24.h
                  ),
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                "Summary"
                            ),
                            GestureDetector(
                              onTap: () {
                                movePageC.movePageWithBack("/summary");
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
                      SizedBox(
                        height: 22.h,
                      ),
                      Obx(() {
                        if (warehouseVM.collection.value == "products") {
                          if (warehouseVM.collection.value.isNotEmpty) {
                            return Container(
                              height: warehouseVM.listProduct.length >= 2
                                  ? 230.w
                                  : 500.w,
                              child: Column(
                                spacing: 10.w,
                                children: warehouseVM.listProduct.take(2)
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
                        if (warehouseVM.collection.value == "warehouse_order") {
                          if (warehouseVM.listOrder.isNotEmpty) {
                            return Column(
                              spacing: 10.w,
                              children: warehouseVM.listOrder.take(2).map(
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
                                        onPayPressed: (){},
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
                            children: warehouseVM.listSalesOrder.take(2).map(
                                  (data) =>
                                  Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.toNamed("/detail_sales_order/${data!.id}");
                                        },
                                        child: CardOrder(
                                          idOrder: data!.id,
                                          idBarang: data!.productCode,
                                          namaBarang: data!.productName,
                                          financeApproved: data!.financeApproved,
                                          createdOn: data!.purchasedDate,
                                          nameUser: data!.firstName,
                                          quantity: data!.quantity,
                                          unitPrice: data!.unitPrice,
                                          lineTotal: data!.totalPrice,
                                          onPayPressed: (){},
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
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            padding: EdgeInsetsGeometry.only(left: 16.w, right: 16.w, top: 12.w, bottom: 6.w),
            height: 58.w,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MainBottomAppBarHelper(icon: "assets/icons/home-2.svg", label: "Home", voidCallback: (){}),
                BottomAppBarHelper(icon: "assets/icons/search-normal.svg", page: ""),
                BottomAppBarHelper(icon: "assets/icons/graph.svg", page: ""),
                BottomAppBarHelper(icon: "assets/icons/clock.svg", page: ""),
                BottomAppBarHelper(icon: "assets/icons/user.svg", page: "/profile")
              ],
            ),
          ),
        ),
        Obx(() => loadingC.isLoading.value ? Container(color: Colors.black26,
            child: Center(child: LoadingAnimationWidget.stretchedDots(
              color: AppColors.softWhite, size: 70.w,))) : SizedBox(),)
      ],
    );
  }
}
