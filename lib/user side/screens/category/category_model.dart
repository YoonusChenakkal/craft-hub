class CategoryModel {
  final int id;
  final String categoryName;
  final String categoryImage;
  final DateTime createdAt;

  CategoryModel({
    required this.id,
    required this.categoryName,
    required this.categoryImage,
    required this.createdAt,
  });

  // Factory method to create an instance from JSON
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      categoryName: json['category_name'],
      categoryImage: json['category_image'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  // Method to convert the instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category_name': categoryName,
      'category_image': categoryImage,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
