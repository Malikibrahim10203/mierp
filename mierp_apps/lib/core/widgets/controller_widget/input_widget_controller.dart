import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InputWidgetController extends GetxController {
  FocusNode focusNode = FocusNode();
  RxBool isFocus = false.obs;
  RxBool isNotVisible = true.obs;
  RxString eCode = "".obs;

  @override
  void onClose() {
    // TODO: implement onClose
    focusNode.dispose();
    super.onClose();
  }

  void changeIsNotVisible() => isNotVisible.value = !isNotVisible.value;
}