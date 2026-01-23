import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mierp_apps/core/controller/move_page_controller.dart';
import 'package:mierp_apps/core/theme/app_colors.dart';
import 'package:mierp_apps/core/theme/app_font_weight.dart';


class ButtonProfileWidget extends StatelessWidget {

  final icon, label;
  VoidCallback? onPress;

  ButtonProfileWidget({super.key, required this.icon, required this.label, required this.onPress});

  final movePageC = Get.find<MovePageController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 335.w,
      height: 59.1.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.w),
          boxShadow: [
            BoxShadow(
                color: Color(0xFFE8E8E8),
                blurRadius: 12.w,
                offset: Offset(0, 1.w)
            )
          ]
      ),
      child: ElevatedButton(
        onPressed: onPress != null?
        onPress: null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              spacing: 24.w,
              children: [
                SizedBox(
                  width: 24.w,
                  height: 24.w,
                  child: SvgPicture.asset(
                    "assets/icons/$icon.svg",
                    colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
                  ),
                ),
                Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: AppFontWeight.medium,
                    color: AppColors.grayTitle,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 27.26.w,
              height: 25.5.w,
              child: SvgPicture.asset(
                "assets/icons/chevron-down.svg",
                colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
              ),
            ),
          ],
        ),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 23.1.w, vertical: 18.95.h),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.w),
          ),
          elevation: 0,
          foregroundColor: Colors.black,
        ),
      ),
    );
  }
}
