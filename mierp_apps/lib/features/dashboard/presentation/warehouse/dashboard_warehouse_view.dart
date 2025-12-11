import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mierp_apps/core/theme/app_colors.dart';
import 'package:mierp_apps/core/theme/app_font_weight.dart';
import 'package:mierp_apps/core/widgets/card_dashboard.dart';
import 'package:mierp_apps/core/widgets/card_stock.dart';
import 'package:mierp_apps/features/login/data/login_repository.dart';
import 'package:mierp_apps/features/login/presentation/login_view_model.dart';

class DashboardWarehouseView extends StatelessWidget {
  DashboardWarehouseView({super.key});

  final loginViewModel = Get.find<LoginViewModel>();
  final linkVM = Get.find<LoginRepository>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60.w)),
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
                              child: Image.asset("assets/images/warehouse_group.png"),
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
                          height: 66.h,
                          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.w),topLeft: Radius.circular(20.w)),
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
                                    borderRadius: BorderRadius.circular(10.w)
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Image.asset("assets/images/person.png",width: 33.w, height: 33.h,),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 13.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "Hello!"
                                  ),
                                  Text(
                                      "Livia Vacaro!"
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 38.w,
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.notifications_active, size: 24.w,),
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
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CardDashboard(),
                      CardDashboard(),
                    ],
                  ),
                  SizedBox(
                    height: 9.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CardDashboard(),
                      CardDashboard(),
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
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 22.w),
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
                child:  Center(
                  child: Container(
                    width: 310.w,
                    height: 33.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Add New Unit",
                        ),
                        Container(
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
                  horizontal: 24.h
              ),
              child: Column(
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            "Stock Summary"
                        ),
                        Row(
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
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 22.h,
                  ),
                  CardStock(),
                  SizedBox(height: 10.h,),
                  CardStock(),
                  SizedBox(height: 10.h,),
                ],
              ),
            ),
            SizedBox(
              height: 22.h,
            ),
            ElevatedButton(
              onPressed: loginViewModel.logout,
              child: Text("Logout"),
            ),
            ElevatedButton(onPressed: (){
              linkVM.linkToAnotherAccount();
            }, child: Text("Linking")),
          ],
        ),
      ),
    );
  }
}
