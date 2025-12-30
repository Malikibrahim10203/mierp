import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mierp_apps/core/controller/loading_controller.dart';
import 'package:mierp_apps/features/dashboard/data/warehouse/detail/detail_product_repository.dart';
import 'package:mierp_apps/features/dashboard/model/product.dart';

class DetailProductViewModel extends GetxController {
  DetailProductViewModel(this.docId);
  final docId;

  final detailProduct = Rxn<Product?>();
  final detailProductR = DetailProductRepository();
  final loadingC = Get.find<LoadingController>();

  TextEditingController productCodeC = TextEditingController();
  TextEditingController nameProductC = TextEditingController();
  TextEditingController createdOnC = TextEditingController();
  TextEditingController quantityC = TextEditingController();
  TextEditingController unitPriceC = TextEditingController();
  RxString categoryProductC = "electronics".obs;

  @override
  void onReady() {
    // TODO: implement onReady
    requestSingleProduct(docId);
    super.onReady();
  }

  Future<void> requestSingleProduct(docId) async {
    try {
      detailProduct.value = await detailProductR.getSingleProduct(docId);
      updateDataController();
      print(detailProduct.value!.toJson());
    } catch(e) {
      Get.snackbar("Failed", "$e");
    }
  }

  void updateDataController() {
    productCodeC.text = detailProduct.value!.productCode;
    nameProductC.text = detailProduct.value!.productName;
    createdOnC.text = detailProduct.value!.createdOn;
    quantityC.text = detailProduct.value!.quantity.toString();
    unitPriceC.text = detailProduct.value!.unitPrice.toString();
    categoryProductC.value = detailProduct.value!.category;
  }

  Future<void> updateSingleProduct() async {
    try {
      loadingC.showLoading();
      Product product = Product(id: detailProduct.value!.id, category: categoryProductC.value, createdOn: createdOnC.text, imageProduct: "", productName: nameProductC.text, productCode: productCodeC.text, quantity: int.parse(quantityC.text), unitPrice: int.parse(unitPriceC.text));
      await detailProductR.updateSingleProduct(product);
      Get.snackbar("Success", "Update data success");
      Future.delayed(Duration(seconds: 2), () {
        loadingC.hideLoading();
        Get.offAllNamed("/dashboard_warehouse");
      },);
    } catch(e) {
      Get.snackbar("Failed", "$e");
    }
  }
}