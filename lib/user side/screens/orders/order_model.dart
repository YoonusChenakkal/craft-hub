// Order Model
class Order {
  final int id;
  final int user;
  final String userName;
  final String status;
  final String createdAt;
  final String productNames;
  final String paymentMethod;
  final String productIds;
  final double totalPrice;
  final String orderIds;
  final int totalCartItems;
  final String orderTime;

  Order({
    required this.id,
    required this.user,
    required this.userName,
    required this.status,
    required this.createdAt,
    required this.productNames,
    required this.paymentMethod,
    required this.productIds,
    required this.totalPrice,
    required this.orderIds,
    required this.totalCartItems,
    required this.orderTime,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      user: json['user'],
      userName: json['user_name'],
      status: json['status'].trim(),
      createdAt: json['created_at'],
      productNames: json['product_names'],
      paymentMethod: json['payment_method'],
      productIds: json['product_ids'],
      totalPrice: (json['total_price'] as num).toDouble(),
      orderIds: json['order_ids'],
      totalCartItems: json['total_cart_items'],
      orderTime: json['order_time'],
    );
  }
}
