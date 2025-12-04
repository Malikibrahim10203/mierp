import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.electricBlue,
      body: Column(
        mainAxisAlignment: .end,
        children: [
          Stack(
            children: [
              Container(
                width: 1.sw,
                child: Column(
                  mainAxisAlignment: .center,
                  children: [
                    Container(
                      width: 350.w,
                      height: 621.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.horizontal(left: Radius.circular(20.r), right: Radius.circular(20.r)),
                        color: AppColors.shadowElectricBlue.withValues(alpha: 0.29),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 1.sw,
                height: 621.h,
                child: Column(
                  mainAxisAlignment: .end,
                  children: [
                    Container(
                      width: 1.sw,
                      height: 609.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.horizontal(left: Radius.circular(20.r), right: Radius.circular(20.r)),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: .center,
                        children: [
                          SizedBox(height: 44.w,),
                          Row(
                            mainAxisAlignment: .center,
                            children: [
                              Image.asset("assets/images/mierp.png", width: 120.w, height: 34.h,),
                            ],
                          ),
                          SizedBox(height: 24.w,),
                          Row(
                            mainAxisAlignment: .center,
                            children: [
                              Text(
                                "Log in to your account",
                                style: TextStyle(),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.w,),
                          Row(
                            mainAxisAlignment: .center,
                            children: [
                              Text(
                                "Welcome back! Please enter your details.",
                                style: TextStyle(),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
