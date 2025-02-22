import 'package:crafti_hub/user%20side/screens/home/home_provider.dart';
import 'package:crafti_hub/user%20side/screens/products/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryProductsPage extends StatelessWidget {
  final categoryName;
  const CategoryProductsPage({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);

    // Filter products by selected category
    final categoryProducts = homeProvider.allProducts
        .where((product) => product.categoryName == categoryName)
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text(categoryName)),
      body: categoryProducts.isEmpty
          ? Center(child: Text("No products found"))
          : GridView.builder(
              padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 3,
                crossAxisSpacing: 3,
                childAspectRatio: 0.50,
              ),
              itemCount: categoryProducts.length,
              itemBuilder: (context, index) {
                return ProductCard(
                  product: categoryProducts[index],
                  onTap: () => Navigator.pushNamed(
                    context,
                    '/productDetails',
                    arguments: categoryProducts[index],
                  ),
                );
              },
            ),
    );
  }
}
