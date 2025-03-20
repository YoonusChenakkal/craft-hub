class ProductModel {
  final int id;
  final int vendor;
  final String vendorName;
  final int category;
  final String categoryName;
  final String? subcategory;
  final String? displaycategoryname;

  final String productName;
  final String productDescription;
  final double price;
  final double offerPrice;
  final double? discount;
  final bool isOfferProduct;
  final bool popularProducts;
  final bool newArrival;
  final bool trendingOne;
  final List<ProductImage> imageUrls;
  final List<Review> reviews;

  final DateTime createdAt;

  ProductModel({
    required this.id,
    required this.vendor,
    required this.vendorName,
    required this.category,
    this.subcategory,
    this.displaycategoryname,
    required this.categoryName,
    required this.productName,
    required this.productDescription,
    required this.price,
    required this.offerPrice,
    this.discount,
    required this.isOfferProduct,
    required this.popularProducts,
    required this.newArrival,
    required this.trendingOne,
    required this.imageUrls,
    required this.reviews,
    required this.createdAt,
  });

  /// Factory constructor to create a `Product` from JSON
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      vendor: json['vendor'],
      vendorName: json['vendor_name'],
      category: json['category'],
      categoryName: json['category_name'],
      subcategory: json['subcategory'],
      displaycategoryname: json['categoryname'],
      productName: json['product_name'],
      productDescription: json['product_description'],
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      offerPrice: double.tryParse(json['offerprice'].toString()) ?? 0.0,
      discount: json['discount'] != null
          ? double.tryParse(json['discount'].toString())
          : null,
      isOfferProduct: json['isofferproduct'] ?? false,
      popularProducts: json['Popular_products'] ?? false,
      newArrival: json['newarrival'] ?? false,
      trendingOne: json['trending_one'] ?? false,
      imageUrls: (json['image_urls'] as List)
          .map((img) => ProductImage.fromJson(img))
          .toList(),
      reviews: (json['reviews'] as List)
          .map((review) => Review.fromJson(review))
          .toList(),
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  /// Convert `Product` object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vendor': vendor,
      'vendor_name': vendorName,
      'category': category,
      'category_name': categoryName,
      "subcategory": subcategory,
      "categoryname": displaycategoryname,
      'product_name': productName,
      'product_description': productDescription,
      'price': price.toStringAsFixed(2),
      'offerprice': offerPrice.toStringAsFixed(2),
      'discount': discount?.toStringAsFixed(2),
      'isofferproduct': isOfferProduct,
      'Popular_products': popularProducts,
      'newarrival': newArrival,
      'trending_one': trendingOne,
      'image_urls': imageUrls.map((img) => img.toJson()).toList(),
      'created_at': createdAt.toIso8601String(),
    };
  }

  /// Convert a JSON string to a list of `Product` objects
}

/// Model class for product images
class ProductImage {
  final int id;
  final int product;
  final String productImage;

  ProductImage({
    required this.id,
    required this.product,
    required this.productImage,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      id: json['id'],
      product: json['product'],
      productImage: json['product_image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': product,
      'product_image': productImage,
    };
  }
}

class Review {
  final int id;
  final String user;
  final int product;
  final double rating;
  final String? review;
  final DateTime createdAt;

  Review({
    required this.id,
    required this.user,
    required this.product,
    required this.rating,
    this.review,
    required this.createdAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      user: json['user'],
      product: json['product'],
      rating: double.parse(json['rating']),
      review: json['review'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
