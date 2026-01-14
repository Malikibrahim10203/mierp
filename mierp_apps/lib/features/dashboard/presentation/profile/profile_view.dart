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
import 'package:mierp_apps/core/widgets/button_profile_widget.dart';
import 'package:mierp_apps/features/dashboard/presentation/profile/profile_view_model.dart';
import 'package:mierp_apps/features/login/presentation/login_view_model.dart';

class ProfileView extends GetView<ProfileViewModel> {
  ProfileView({super.key});
  final loadingC = Get.find<LoadingController>();
  final movePageC = Get.find<MovePageController>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 144.h,),
                    SizedBox(
                      width: 110.w,
                      height: 110.h,
                      child: Image.asset("assets/images/profile-box.png"),
                    ),
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 21.9.h,),
                              Text(
                                "Livia Vaccaro",
                                style: GoogleFonts.lexendDeca(
                                  fontSize: 16.sp,
                                  fontWeight: AppFontWeight.semiBold,
                                  color: AppColors.grayTitle,
                                ),
                              ),
                              SizedBox(height: 5.h,),
                              Text(
                                "WAREHOUSE",
                                style: GoogleFonts.lexendDeca(
                                  fontSize: 12.sp,
                                  fontWeight: AppFontWeight.light,
                                  color: AppColors.grayTitle,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            SizedBox(height: 43.h,),
                            SizedBox(
                              width: double.infinity,
                              child: SvgPicture.asset("assets/images/shape.svg"),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 27.h,),
                    Column(
                      spacing: 11.1.w,
                      children: [
                        ButtonProfileWidget(icon: "user-profile", label: "Account Info", onPress: null),
                        ButtonProfileWidget(icon: "link", label: "Link Account to Google", onPress: "link"),
                        ButtonProfileWidget(icon: "logout", label: "Logout", onPress: "logout")
                      ],
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    width: double.infinity,
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
                                        movePageC.movePageBack();
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
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          bottomNavigationBar: Container(
            height: 88.w,
            padding: EdgeInsetsGeometry.only(left: 16.w, right: 16.w, top: 12.w, bottom: 6.w),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, -5),
                    blurRadius: 12.w,
                    color: Color(0xFFEDEDED)
                  )
                ]
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MainBottomAppBarHelper(icon: "assets/icons/home-2.svg", label: "Home"),
                BottomAppBarHelper(icon: "assets/icons/search-normal.svg", page: ""),
                BottomAppBarHelper(icon: "assets/icons/graph.svg", page: ""),
                BottomAppBarHelper(icon: "assets/icons/clock.svg", page: ""),
                BottomAppBarHelper(icon: "assets/icons/user.svg", page: "/profile")
              ],
            ),
          ),
        ),
        Obx(() =>
        loadingC.isLoading.value ? Container(color: Colors.black26,
            child: Center(child: LoadingAnimationWidget.stretchedDots(
              color: AppColors.softWhite, size: 70.w,))) : SizedBox(),),
      ],
    );
  }
}
