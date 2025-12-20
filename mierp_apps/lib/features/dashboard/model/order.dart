class OrderProduct {
  bool? financeApproved;
  DateTime? financeApprovedDate;
  DateTime? orderDate;
  String productId;
  String productCode;
  String productName;
  int quantity;
  int totalCost;
  String userId;
  String firstName;

  OrderProduct({
    required this.financeApproved,
    required this.financeApprovedDate,
    required this.orderDate,
    required this.productId,
    required this.productCode,
    required this.productName,
    required this.quantity,
    required this.totalCost,
    required this.userId,
    required this.firstName,
  });

  factory OrderProduct.fromJson(Map<String, dynamic> json) => OrderProduct(
    financeApproved: json["finance_approved"]??'',
    financeApprovedDate: json["finance_approved_date"] != null? DateTime.tryParse(json["finance_approved_date"]):null,
    orderDate: json["order_date"] != null? DateTime.tryParse(json["order_date"]):null,
    productId: json["product_id"],
    productCode: json["product_code"],
    productName: json["product_name"],
    quantity: json["quantity"],
    totalCost: json["total_cost"],
    userId: json["user_id"],
    firstName: json["first_name"],
  );

  Map<String, dynamic> toJson() => {
    "finance_approved": financeApproved!,
    "finance_approved_date": financeApprovedDate!.toIso8601String(),
    "order_date": orderDate!.toIso8601String(),
    "product_id": productId,
    "product_code": productCode,
    "product_name": productName,
    "quantity": quantity,
    "total_cost": totalCost,
    "user_id": userId,
    "first_name": firstName,
  };
}

