class Order {
  final int id;
  final String paymentMethod;
  final List<int> productIds;
  final List<String> productNames;
  final List<int> quantities;
  final double totalPrice;
  final int totalCartItems;
  final String status;
  final String orderIds;
  final String? deliveryPin;
  final List<Address> addressDetails;

  Order({
    required this.id,
    required this.paymentMethod,
    required this.productIds,
    required this.productNames,
    required this.quantities,
    required this.totalPrice,
    required this.totalCartItems,
    required this.status,
    required this.orderIds,
    this.deliveryPin,
    required this.addressDetails,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      paymentMethod: json['payment_method'],
      productIds: _convertToIntList(json['product_ids']),
      productNames: json['product_names'].split(','),
      quantities: _convertToIntList(json['quantities']),
      totalPrice: (json['total_price'] as num).toDouble(),
      totalCartItems: json['total_cart_items'],
      status: json['status'].trim(),
      orderIds: json['order_ids'],
      deliveryPin: json['delivery_pin'],
      addressDetails: (json['address_details'] as List)
          .map((address) => Address.fromJson(address))
          .toList(),
    );
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
      'status': status,
      'order_ids': orderIds,
      'delivery_pin': deliveryPin,
      'address_details': addressDetails.map((e) => e.toJson()).toList(),
    };
  }

  static List<int> _convertToIntList(dynamic data) {
    if (data is String) {
      return data.split(',').map((e) => int.tryParse(e.trim()) ?? 0).toList();
    } else if (data is List) {
      return data.map((e) => int.tryParse(e.toString()) ?? 0).toList();
    } else {
      return [];
    }
  }
}

class Address {
  final int id;
  final String addressLine1;
  final String? addressLine2;
  final String city;
  final String state;
  final String country;
  final String pincode;
  final bool isPrimary;
  final String createdAt;
  final String updatedAt;
  final String mobileNumber;
  final String whatsappNumber;

  Address({
    required this.id,
    required this.addressLine1,
    this.addressLine2,
    required this.city,
    required this.state,
    required this.country,
    required this.pincode,
    required this.isPrimary,
    required this.createdAt,
    required this.updatedAt,
    required this.mobileNumber,
    required this.whatsappNumber,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      addressLine1: json['address_line1'],
      addressLine2: json['address_line2'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      pincode: json['pincode'],
      isPrimary: json['is_primary'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      mobileNumber: json['mobile_number'],
      whatsappNumber: json['whatsapp_number'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'address_line1': addressLine1,
      'address_line2': addressLine2,
      'city': city,
      'state': state,
      'country': country,
      'pincode': pincode,
      'is_primary': isPrimary,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'mobile_number': mobileNumber,
      'whatsapp_number': whatsappNumber,
    };
  }
}
