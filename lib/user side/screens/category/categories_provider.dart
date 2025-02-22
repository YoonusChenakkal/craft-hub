import 'package:crafti_hub/user%20side/common/flush_bar.dart';
import 'package:crafti_hub/user%20side/screens/category/categories_respository.dart';
import 'package:crafti_hub/user%20side/screens/category/category_model.dart';
import 'package:flutter/material.dart';

class CategoriesProvider extends ChangeNotifier {
  List<CategoryModel> categories = [];

  final CategoriesRespository _categoryRepository = CategoriesRespository();

  Future<void> fetchCategories(BuildContext context) async {
    try {
      final response = await _categoryRepository.fetchCategories();
      categories = (response.data as List)
          .map((json) => CategoryModel.fromJson(json))
          .toList();
      notifyListeners();
    } catch (e) {
      showFlushbar(
        message: e.toString(),
        color: Colors.red,
        icon: Icons.error,
        context: context,
      );
    }
  }
}
