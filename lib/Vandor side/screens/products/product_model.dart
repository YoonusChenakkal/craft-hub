class ProductModel {
  final int id;
  final int vendor;
  final String vendorName;
  final int category;
  final String subcategory;
  final String categoryName;
  final String categoryDisplayName;
  final String productName;
  final String productDescription;
  final double price;
  final double offerPrice;
  final double discount;
  final bool isOfferProduct;
  final bool isPopularProduct;
  final bool isNewArrival;
  final bool isTrending;
  final List<ProductImage> imageUrls;
  final DateTime createdAt;

  ProductModel({
    required this.id,
    required this.vendor,
    required this.vendorName,
    required this.category,
    required this.subcategory,
    required this.categoryName,
    required this.categoryDisplayName,
    required this.productName,
    required this.productDescription,
    required this.price,
    required this.offerPrice,
    required this.discount,
    required this.isOfferProduct,
    required this.isPopularProduct,
    required this.isNewArrival,
    required this.isTrending,
    required this.imageUrls,
    required this.createdAt,
  });

  // Factory method to create an object from JSON
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      vendor: json['vendor'],
      vendorName: json['vendor_name'],
      category: json['category'],
      subcategory: json['subcategory'] ?? '',
      categoryName: json['category_name'] ?? '',
      categoryDisplayName: json['categoryname'] ?? '',
      productName: json['product_name'] ?? '',
      productDescription: json['product_description'] ?? '',
      price: double.tryParse(json['price'] ?? '0.0') ?? 0.0,
      offerPrice: double.tryParse(json['offerprice'] ?? '0.0') ?? 0.0,
      discount: double.tryParse(json['discount'] ?? '0.0') ?? 0.0,
      isOfferProduct: json['isofferproduct'] ?? false,
      isPopularProduct: json['Popular_products'] ?? false,
      isNewArrival: json['newarrival'] ?? false,
      isTrending: json['trending_one'] ?? false,
      imageUrls: (json['image_urls'] as List<dynamic>?)
              ?.map((e) => ProductImage.fromJson(e))
              .toList() ??
          [],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  // Convert object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vendor': vendor,
      'vendor_name': vendorName,
      'category': category,
      'subcategory': subcategory,
      'category_name': categoryName,
      'categoryname': categoryDisplayName,
      'product_name': productName,
      'product_description': productDescription,
      'price': price.toStringAsFixed(2),
      'offerprice': offerPrice.toStringAsFixed(2),
      'discount': discount.toStringAsFixed(2),
      'isofferproduct': isOfferProduct,
      'Popular_products': isPopularProduct,
      'newarrival': isNewArrival,
      'trending_one': isTrending,
      'image_urls': imageUrls.map((e) => e.toJson()).toList(),
      'created_at': createdAt.toIso8601String(),
    };
  }
}

// Model for product images
class ProductImage {
  final int id;
  final int productId;
  final String productImage;

  ProductImage({
    required this.id,
    required this.productId,
    required this.productImage,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      id: json['id'],
      productId: json['product'],
      productImage: json['product_image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': productId,
      'product_image': productImage,
    };
  }
}
