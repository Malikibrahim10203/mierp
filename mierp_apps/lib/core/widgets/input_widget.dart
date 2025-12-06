import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mierp_apps/core/theme/app_colors.dart';
import 'package:mierp_apps/core/theme/app_font_weight.dart';
import 'package:mierp_apps/core/widgets/controller/input_widget_controller.dart';

class InputWidget extends StatelessWidget {
  InputWidget({super.key, required this.head, required this.controller, required this.placeholder, required this.necessary, required this.isPassword});

  final head,controller,placeholder,necessary, isPassword;

  final inputWidgetC = Get.put(InputWidgetController(), tag: UniqueKey().toString());

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 322.w,
      height: 73.w,
      child: Column(
        children: [
          Row(
            children: [
              necessary?
                  Text(
                    "*",
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      fontWeight: AppFontWeight.medium,
                      color: Colors.red,
                    ),
                  ):SizedBox(),
              Text(
                head,
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  fontWeight: AppFontWeight.medium,
                  color: AppColors.grayTitle,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.w,),
          Obx(
              () => Container(
                width: 322.w,
                height: 45.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6.w),
                  boxShadow: inputWidgetC.isFocus.value?
                  [BoxShadow(
                      color: AppColors.blueLineShadow,
                      spreadRadius: 4
                  )]: [BoxShadow(
                      color: Colors.white,
                      spreadRadius: 2
                  )],
                ),
                child: isPassword?
                TextFormField(
                  controller: controller,
                  obscureText: inputWidgetC.isNotVisible.value,
                  focusNode: inputWidgetC.focusNode,
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    fontWeight: AppFontWeight.regular,
                    height: 1.0,
                  ),
                  decoration: InputDecoration(
                    hintText: "Enter your password",
                    hintStyle: GoogleFonts.inter(
                      fontSize: 13.sp,
                      fontWeight: AppFontWeight.regular,
                      height: 1.0,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6.w),
                        borderSide: BorderSide(color: AppColors.blueLine, width: 1.w)
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6.w),
                        borderSide: BorderSide(color: AppColors.coolGray, width: 1.w)
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6.w),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.5.w),
                    suffixIcon: IconButton(
                      icon: inputWidgetC.isNotVisible.value?Icon(Icons.visibility_off):Icon(Icons.visibility),
                      onPressed: ()=>inputWidgetC.changeIsNotVisible(),
                    ),
                  ),
                ):
                TextFormField(
                  controller: controller,
                  focusNode: inputWidgetC.focusNode,
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    fontWeight: AppFontWeight.regular,
                    height: 1.0,
                  ),
                  decoration: InputDecoration(
                    hintText: "Enter your email",
                    hintStyle: GoogleFonts.inter(
                      fontSize: 13.sp,
                      fontWeight: AppFontWeight.regular,
                      height: 1.0,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6.w),
                        borderSide: BorderSide(color: AppColors.blueLine, width: 1.w)
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6.w),
                        borderSide: BorderSide(color: AppColors.coolGray, width: 1.w)
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6.w),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.5.w),
                  ),
                ),
              ),
          ),
        ],
      ),
    );
  }
}
