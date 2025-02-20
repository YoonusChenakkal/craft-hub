class ProductBannerModel {
  final int id;
  final int vendor;
  final int product;
  final String bannerImage;
  final String? description;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProductBannerModel({
    required this.id,
    required this.vendor,
    required this.product,
    required this.bannerImage,
    this.description,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor to create ProductBanner from JSON
  factory ProductBannerModel.fromJson(Map<String, dynamic> json) {
    return ProductBannerModel(
      id: json['id'],
      vendor: json['vendor'],
      product: json['product'],
      bannerImage: json['banner_image'],
      description: json['description'],
      isActive: json['is_active'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
