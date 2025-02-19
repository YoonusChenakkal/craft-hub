import 'package:crafti_hub/screens/category/category_products_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crafti_hub/screens/home/home_provider.dart';

class CategoriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);

    // Extract unique categories from products
    final categories = homeProvider.allProducts
        .map((product) => product.categoryName)
        .toSet()
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text("Categories")),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(categories[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CategoryProductsPage(categoryName: categories[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
