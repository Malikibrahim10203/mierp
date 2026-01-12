import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'package:mierp_apps/core/controller/loading_controller.dart';
import 'package:mierp_apps/core/controller/move_page_controller.dart';
import 'package:mierp_apps/core/controller/payment_order_product_controller.dart';
import 'package:mierp_apps/domain/item/repositories/item_repository.dart';
import 'package:mierp_apps/data/item/repositories/item_repository_impl.dart';
import 'package:mierp_apps/domain/transaction/services/pay_product_order_services.dart';
import 'package:mierp_apps/domain/transaction/services/pay_sales_order_services.dart';
import 'package:mierp_apps/data/warehouse/detail/detail_product_order_repository.dart';
import 'package:mierp_apps/data/warehouse/detail/detail_sales_order_repository.dart';
import 'package:mierp_apps/features/login/presentation/login_view_model.dart';
import 'package:mierp_apps/features/onboarding/onboarding_view_model.dart';
import 'package:mierp_apps/features/register/presentation/register_view_model.dart';
import 'package:mierp_apps/features/splash/presentation/splash_view_model.dart';
import 'package:mierp_apps/state/item_store.dart';

class GlobalBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => PayProductOrderServices(DetailProductOrderRepository()), fenix: true);
    Get.lazyPut(() => PaySalesOrderServices(DetailSalesOrderRepository()), fenix: true);

    Get.put(LoadingController(), permanent: true);
    Get.put(LoginViewModel(), permanent: true);
    Get.lazyPut(()=>RegisterViewModel());

    Get.lazyPut(()=>SplashViewModel());

    Get.lazyPut(()=>MovePageController(),fenix: true);
    
    Get.put(FirebaseFirestore.instance);
    Get.put(ItemStore(), permanent: true);
    Get.put<ItemRepository>(ItemStoreRepositoryImpl(Get.find<FirebaseFirestore>(),Get.find<ItemStore>()));

    Get.put(PayProductOrderServices(DetailProductOrderRepository()));
  }
}