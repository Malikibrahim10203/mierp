import 'package:get/get.dart';
import 'package:mierp_apps/domain/item/repositories/item_repository.dart';
import 'package:mierp_apps/domain/transaction/repository/transaction_repository.dart';

class TransactionServices extends GetxService {

  final ItemRepository itemRepository;
  final TransactionRepository transactionRepository;

  TransactionServices({required this.itemRepository, required this.transactionRepository});

  Future<void> payProductOrderServices(prodId, totalQty, date) async {
    try {
      await transactionRepository.payProductOrderInvoice(prodId, totalQty, date);
      await itemRepository.getDetailDataOrder(prodId);
    } catch(e) {
      print("$e");
    }
  }
}