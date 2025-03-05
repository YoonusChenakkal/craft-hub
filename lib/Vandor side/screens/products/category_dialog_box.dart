import 'package:crafti_hub/Vandor%20side/screens/products/category_model.dart';
import 'package:crafti_hub/Vandor%20side/screens/products/product_Provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryDialogBox extends StatefulWidget {
  const CategoryDialogBox({super.key});

  @override
  State<CategoryDialogBox> createState() => _CategoryDialogBoxState();
}

class _CategoryDialogBoxState extends State<CategoryDialogBox> {
  @override
  Widget build(BuildContext context) {
    final productProvider =
        Provider.of<VendorProductProvider>(context, listen: false);

    return AlertDialog(
      title: const Text("Select Category"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Category Dropdown
          DropdownButtonFormField<CategoryModel>(
            value: productProvider.selectedCategory,
            hint: const Text("Choose a Category"),
            items: productProvider.categories.map((category) {
              return DropdownMenuItem<CategoryModel>(
                value: category,
                child: Text(category.name),
              );
            }).toList(),
            onChanged: (CategoryModel? newCategory) {
              setState(() {
                productProvider.selectedSubCategory = null;
                productProvider.selectedCategory = newCategory;
              });
            },
          ),

          const SizedBox(height: 16),

          // Subcategory Dropdown (Enabled only when a category is selected)
          DropdownButtonFormField<SubCategoryModel>(
            value: productProvider.selectedSubCategory,
            hint: const Text("Choose a Sub Category"),
            items: productProvider.selectedCategory?.subCategories
                .map((subCategory) {
              return DropdownMenuItem<SubCategoryModel>(
                value: subCategory,
                child: Text(subCategory.name),
              );
            }).toList(),
            onChanged: (SubCategoryModel? newSubCategory) {
              setState(() {
                productProvider.selectedSubCategory = newSubCategory;
              });
            },
          ),

          const SizedBox(height: 16),

          // Confirm Button
          ElevatedButton(
            onPressed: () {
              if (productProvider.selectedCategory != null &&
                  productProvider.selectedSubCategory != null) {
                Navigator.pop(context); // Close the dialog
              }
            },
            child: const Text("Confirm"),
          ),
        ],
      ),
    );
  }
}
