class CartModel {
  final double totalPrice;
  final List<CartVendor> cartItems;

  CartModel({required this.totalPrice, required this.cartItems});

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      totalPrice: (json['total_price'] as num).toDouble(),
      cartItems: (json['cart_items'] as List)
          .map((item) => CartVendor.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_price': totalPrice,
      'cart_items': cartItems.map((item) => item.toJson()).toList(),
    };
  }
}

class CartVendor {
  final String vendor;
  final int vendorId;
  final List<CartItem> products;

  CartVendor(
      {required this.vendor, required this.vendorId, required this.products});

  factory CartVendor.fromJson(Map<String, dynamic> json) {
    return CartVendor(
      vendor: json['vendor'],
      vendorId: json['vendor_id'],
      products: (json['products'] as List)
          .map((item) => CartItem.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vendor': vendor,
      'vendor_id': vendorId,
      'products': products.map((item) => item.toJson()).toList(),
    };
  }
}

class CartItem {
  final int id;
  final String user;
  final ProductModel product;
  final int quantity;
  final double price;
  final double totalPrice;
  final DateTime createdAt;
  final DateTime updatedAt;

  CartItem({
    required this.id,
    required this.user,
    required this.product,
    required this.quantity,
    required this.price,
    required this.totalPrice,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      user: json['user'],
      product: ProductModel.fromJson(json['product']),
      quantity: json['quantity'],
      price: double.parse(json['price']),
      totalPrice: (json['total_price'] as num).toDouble(),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user,
      'product': product.toJson(),
      'quantity': quantity,
      'price': price.toStringAsFixed(2),
      'total_price': totalPrice,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class ProductModel {
  final int id;
  final String productName;
  final String productDescription;
  final double price;
  final double offerPrice;
  final bool isOfferProduct;
  final double? discount;
  final bool popularProducts;
  final DateTime createdAt;
  final bool newArrival;
  final bool trendingOne;
  final int vendor;
  final int category;
  final List<String> images;

  ProductModel({
    required this.id,
    required this.productName,
    required this.productDescription,
    required this.price,
    required this.offerPrice,
    required this.isOfferProduct,
    this.discount,
    required this.popularProducts,
    required this.createdAt,
    required this.newArrival,
    required this.trendingOne,
    required this.vendor,
    required this.category,
    required this.images,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      productName: json['product_name'],
      productDescription: json['product_description'],
      price: double.parse(json['price']),
      offerPrice: double.parse(json['offerprice']),
      isOfferProduct: json['isofferproduct'],
      discount:
          json['discount'] != null ? double.parse(json['discount']) : null,
      popularProducts: json['Popular_products'],
      createdAt: DateTime.parse(json['created_at']),
      newArrival: json['newarrival'],
      trendingOne: json['trending_one'],
      vendor: json['vendor'],
      category: json['category'],
      images: List<String>.from(json['images']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_name': productName,
      'product_description': productDescription,
      'price': price.toStringAsFixed(2),
      'offerprice': offerPrice.toStringAsFixed(2),
      'isofferproduct': isOfferProduct,
      'discount': discount?.toStringAsFixed(2),
      'Popular_products': popularProducts,
      'created_at': createdAt.toIso8601String(),
      'newarrival': newArrival,
      'trending_one': trendingOne,
      'vendor': vendor,
      'category': category,
      'images': images,
    };
  }
}
