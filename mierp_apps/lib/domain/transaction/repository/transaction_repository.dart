
abstract class TransactionRepository {

  Future<void> payProductOrderInvoice(prodId,totalQty,date);
  Future<void> paySalesOrderInvoice(prodId,totalQty,date);
}