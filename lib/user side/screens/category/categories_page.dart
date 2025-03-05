import 'package:crafti_hub/user%20side/common/custom_app_bar.dart';
import 'package:crafti_hub/user%20side/screens/category/categories_provider.dart';
import 'package:crafti_hub/user%20side/screens/category/category_products_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final categoriesprovider = Provider.of<CategoriesProvider>(context);
    final categories = categoriesprovider.categories;

    return Scaffold(
      appBar: customAppBar(title: 'Categories', backLeading: false),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CategoryProductsPage(category: categories[index]),
                  ));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(13),
                child: Image.asset(
                  categories[index].image,
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
