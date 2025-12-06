import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mierp_apps/core/widgets/controller/checkbox_widget_controller.dart';

class CheckboxWidget extends StatelessWidget {
  CheckboxWidget({super.key});

  final checkboxWidgetC = Get.put(CheckboxWidgetController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
      width: 15.w,
      height: 15.h,
      child: Checkbox(
        value: checkboxWidgetC.value.value,
        onChanged: (newValue) {
          checkboxWidgetC.value.value = newValue!;
        },
      ),
      );
    });
  }
}
