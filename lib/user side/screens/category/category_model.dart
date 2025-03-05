// class CategoryModel {
//   final int id;
//   final String categoryName;
//   final String categoryImage;
//   final DateTime createdAt;

//   CategoryModel({
//     required this.id,
//     required this.categoryName,
//     required this.categoryImage,
//     required this.createdAt,
//   });

//   // Factory method to create an instance from JSON
//   factory CategoryModel.fromJson(Map<String, dynamic> json) {
//     return CategoryModel(
//       id: json['id'],
//       categoryName: json['category_name'],
//       categoryImage: json['category_image'],
//       createdAt: DateTime.parse(json['created_at']),
//     );
//   }

//   // Method to convert the instance to JSON
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'category_name': categoryName,
//       'category_image': categoryImage,
//       'created_at': createdAt.toIso8601String(),
//     };
//   }
// }
class SubCategoryModel {
  final int id;
  final String image;
  final String name;

  SubCategoryModel({
    required this.id,
    required this.image,
    required this.name,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryModel(
      id: json['id'],
      image: json['image'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'name': name,
    };
  }
}

class CategoryModel {
  final int id;
  final String image;
  final String name;
  final List<SubCategoryModel> subCategories;

  CategoryModel({
    required this.id,
    required this.image,
    required this.name,
    required this.subCategories,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      image: json['image'],
      name: json['name'],
      subCategories: (json['sub_categories'] as List<dynamic>?)
              ?.map((subJson) => SubCategoryModel.fromJson(subJson))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'name': name,
      'sub_categories': subCategories.map((sub) => sub.toJson()).toList(),
    };
  }
}
