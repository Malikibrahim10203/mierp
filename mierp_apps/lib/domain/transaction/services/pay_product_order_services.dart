import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mierp_apps/data/warehouse/detail/detail_product_order_repository.dart';

class PayProductOrderServices {
  DetailProductOrderRepository detailProductOrderRepository;

  PayProductOrderServices(this.detailProductOrderRepository);

  Future<void> payInvoice(docId, prodId, totalQty) async {
    try {
      final product = await detailProductOrderRepository.getProduct(prodId);
      if (totalQty >= product.quantity) {
        throw Exception("Out of stock");
      }
      final now = DateTime.now();
      final dateParse = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
      await detailProductOrderRepository.payInvoiceProduct(docId, prodId, dateParse, totalQty);
    } catch(e) {
      rethrow;
    }
  }
}