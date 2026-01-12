import 'package:get/get.dart';
import 'package:mierp_apps/features/dashboard/presentation/detail/detail_sales_order/detail_sales_order_view_model.dart';

class DetailSalesOrderBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies

    final id = Get.parameters['id'];

    Get.put(DetailSalesOrderViewModel(id: id));
  }
}