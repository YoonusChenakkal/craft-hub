import 'package:crafti_hub/user%20side/screens/category/categories_respository.dart';
import 'package:crafti_hub/user%20side/screens/category/category_model.dart';
import 'package:flutter/material.dart';

class CategoriesProvider extends ChangeNotifier {
  List<CategoryModel> categories = [
    CategoryModel(
        id: 1,
        name: 'Frames',
        image: "assets/image1/frames.jpeg",
        subCategories: [
          SubCategoryModel(
              id: 1,
              image: "assets/image1/spot1 (1).jpeg",
              name: 'Spotify Frames'),
          SubCategoryModel(
              id: 2, image: "assets/image1/hoopp.jpeg", name: 'Hoop Frames'),
          SubCategoryModel(
              id: 3, image: "assets/image1/number.jpeg", name: 'Number Frames'),
          SubCategoryModel(
              id: 4, image: "assets/image1/boxxx (1).jpeg", name: 'Box Frames'),
          SubCategoryModel(
              id: 5, image: "assets/image1/beeds.jpeg", name: 'Beed Frames'),
          SubCategoryModel(
              id: 6,
              image: "assets/image1/polaroid.jpeg",
              name: 'Polaroid Frames'),
        ]),
    CategoryModel(
        id: 2,
        name: 'Gift Hampers',
        image: "assets/image1/gifthamper.jpeg",
        subCategories: [
          SubCategoryModel(
              id: 1,
              image: "assets/image1/shirt hamper.jpeg",
              name: 'Shirt Hamper'),
          SubCategoryModel(
              id: 2, image: "assets/image1/giftham.jpeg", name: 'Gift Hamper'),
        ]),
    CategoryModel(
        id: 3,
        name: 'Bouquets',
        image: "assets/image1/bouquets.jpeg",
        subCategories: [
          SubCategoryModel(
              id: 1,
              image: "assets/image1/bride.jpeg",
              name: 'Bridal Bouquets'),
          SubCategoryModel(
              id: 2,
              image: "assets/image1/flower.jpeg",
              name: 'Flower Bouquets'),
          SubCategoryModel(
              id: 3, image: "assets/image1/candy.jpeg", name: 'Candy Bouquets'),
        ]),
    CategoryModel(
        id: 4,
        name: 'Resins',
        image: "assets/image1/resin.jpeg",
        subCategories: [
          SubCategoryModel(
              id: 1,
              image: "assets/image1/clock1 (5).jpeg",
              name: 'Clock Resins'),
          SubCategoryModel(
              id: 2,
              image: "assets/image1/Rframe1 (5).jpeg",
              name: 'Frame Resins'),
          SubCategoryModel(
              id: 3,
              image: "assets/image1/jewe1 (5).jpeg",
              name: 'Jewellery Resins'),
          SubCategoryModel(
              id: 4, image: "assets/image1/key1 (5).jpeg", name: 'Key Chain'),
          SubCategoryModel(
              id: 5, image: "assets/image1/pres1 (5).jpeg", name: 'Preserved '),
          SubCategoryModel(
              id: 6, image: "assets/image1/wall1 (5).jpeg", name: 'Decore'),
          SubCategoryModel(
              id: 7, image: "assets/image1/other1 (5).jpeg", name: 'Others')
        ]),
  ];
  String? selectedSubCategoryname;
}
