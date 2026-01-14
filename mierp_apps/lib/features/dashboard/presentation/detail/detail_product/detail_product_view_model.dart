import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mierp_apps/core/utils/loading_controller.dart';
import 'package:mierp_apps/data/warehouse/detail/detail_product_repository.dart';
import 'package:mierp_apps/core/models/product.dart';
import 'package:mierp_apps/domain/item/repositories/item_repository.dart';
import 'package:mierp_apps/state/item_store.dart';

class DetailProductViewModel extends GetxController {

  final id;
  final ItemRepository itemRepository;
  final ItemStore itemStore;
  DetailProductViewModel({required this.id, required this.itemRepository, required this.itemStore});

  final detailProductR = DetailProductRepository();
  final loadingC = Get.find<LoadingController>();

  RxBool isLoading = false.obs;

  TextEditingController productCodeC = TextEditingController();
  TextEditingController nameProductC = TextEditingController();
  TextEditingController createdOnC = TextEditingController();
  TextEditingController quantityC = TextEditingController();
  TextEditingController unitPriceC = TextEditingController();
  RxString categoryProductC = "electronics".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    getDetailProduct();
    super.onInit();
  }

  Rxn<Product> get detailProduct {
    return itemStore.products;
  }

  Future<void> getDetailProduct() async {
    try {
      isLoading.value = true;
      await itemRepository.getDetailDataStock(id);
      updateDataController();
      isLoading.value = false;
    } catch(e) {
      isLoading.value = false;
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