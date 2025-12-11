import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mierp_apps/core/theme/app_colors.dart';
import 'package:mierp_apps/core/theme/app_font_weight.dart';

class CardStock extends StatelessWidget {
  CardStock({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 342.w,
      height: 107.h,
      padding: EdgeInsets.all(13.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.w),
        color: Colors.white,
          boxShadow: [
          BoxShadow(
            color: AppColors.shadowBox,
            spreadRadius: -3.w,
            offset: Offset(0, 4),
            blurRadius: 21.w,
          )
        ]
      ),
      child: Column(
        children: [
          Container(
            width: 318.w,
            height: 79.h,
            child: Center(
              child: Row(
                children: [
                  Container(
                    width: 69.w,
                    height: 69.h,
                    decoration: BoxDecoration(
                      color: Color(0xFFF1F4FF),
                      borderRadius: BorderRadius.circular(10.w)
                    ),
                  ),
                  SizedBox(
                    width: 19.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "WHS01550/F-112",
                        style: GoogleFonts.inter(
                          fontSize: 10.sp,
                          fontWeight: AppFontWeight.light,
                          color: AppColors.gray,
                        ),
                      ),
                      Text(
                        "4501 - Legion 5 15IMH05H Len..",
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          fontWeight: AppFontWeight.regular,
                          color: AppColors.gray,
                        ),
                      ),
                      SizedBox(
                        height: 12.w,
                      ),
                      DottedLine(
                        direction: Axis.horizontal,
                        dashColor: AppColors.charcoal,
                        lineLength: 225.w,
                      ),
                      SizedBox(
                        height: 6.w,
                      ),
                      Container(
                        width: 225.w,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "Data",
                                      style: GoogleFonts.inter(
                                        fontSize: 8.sp,
                                        fontWeight: AppFontWeight.light,
                                        color: AppColors.gray,
                                      ),
                                    ),
                                    Text(
                                      "198",
                                      style: GoogleFonts.inter(
                                        fontSize: 10.sp,
                                        fontWeight: AppFontWeight.regular,
                                        color: AppColors.gray,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 9.w,),
                                Column(
                                  children: [
                                    Text(
                                      "Data",
                                      style: GoogleFonts.inter(
                                        fontSize: 8.sp,
                                        fontWeight: AppFontWeight.light,
                                        color: AppColors.gray,
                                      ),
                                    ),
                                    Text(
                                      "198",
                                      style: GoogleFonts.inter(
                                        fontSize: 10.sp,
                                        fontWeight: AppFontWeight.regular,
                                        color: AppColors.gray,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 9.w,),
                                Column(
                                  children: [
                                    Text(
                                      "Data",
                                      style: GoogleFonts.inter(
                                        fontSize: 8.sp,
                                        fontWeight: AppFontWeight.light,
                                        color: AppColors.gray,
                                      ),
                                    ),
                                    Text(
                                      "198",
                                      style: GoogleFonts.inter(
                                        fontSize: 10.sp,
                                        fontWeight: AppFontWeight.regular,
                                        color: AppColors.gray,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 9.w,),
                                Column(
                                  children: [
                                    Text(
                                      "Data",
                                      style: GoogleFonts.inter(
                                        fontSize: 8.sp,
                                        fontWeight: AppFontWeight.light,
                                        color: AppColors.gray,
                                      ),
                                    ),
                                    Text(
                                      "198",
                                      style: GoogleFonts.inter(
                                        fontSize: 10.sp,
                                        fontWeight: AppFontWeight.regular,
                                        color: AppColors.gray,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              width: 54.w,
                              height: 12.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.w),
                                color: AppColors.coolGray,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
