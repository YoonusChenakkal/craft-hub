class Order {
  final int id;
  final String paymentMethod;
  final List<int> productIds;
  final List<String> productNames;
  final List<int> quantities;
  final double totalPrice;
  final int totalCartItems;
  final String? address;
  final String? city;
  final String? state;
  final String? pinCode;
  final String status;
  final String orderIds;
  final String? deliveryPin;

  Order({
    required this.id,
    required this.paymentMethod,
    required this.productIds,
    required this.productNames,
    required this.quantities,
    required this.totalPrice,
    required this.totalCartItems,
    this.address,
    this.city,
    this.state,
    this.pinCode,
    required this.status,
    required this.orderIds,
    this.deliveryPin,
  });
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      paymentMethod: json['payment_method'],
      productIds: _convertToIntList(json['product_ids']),
      productNames: json['product_names'].split(',').toList(),
      quantities: _convertToIntList(json['quantities']),
      totalPrice: json['total_price'].toDouble(),
      totalCartItems: json['total_cart_items'],
      address: json['address'],
      city: json['city'],
      state: json['state'],
      pinCode: json['pin_code'],
      status: json['status'].trim(), // Remove trailing spaces
      orderIds: json['order_ids'],
      deliveryPin: json['delivery_pin'],
    );
  }

// Helper function to handle both string and list formats
  static List<int> _convertToIntList(dynamic data) {
    if (data is String) {
      return data.split(',').map((e) => int.tryParse(e.trim()) ?? 0).toList();
    } else if (data is List) {
      return data.map((e) => int.tryParse(e.toString()) ?? 0).toList();
    } else {
      return [];
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'payment_method': paymentMethod,
      'product_ids': productIds.join(','),
      'product_names': productNames.join(','),
      'quantities': quantities.join(','),
      'total_price': totalPrice,
      'total_cart_items': totalCartItems,
      'address': address,
      'city': city,
      'state': state,
      'pin_code': pinCode,
      'status': status,
      'order_ids': orderIds,
      'delivery_pin': deliveryPin,
    };
  }
}
