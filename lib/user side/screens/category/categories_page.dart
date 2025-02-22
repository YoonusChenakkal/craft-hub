import 'package:crafti_hub/user%20side/common/custom_app_bar.dart';
import 'package:crafti_hub/user%20side/screens/category/categories_provider.dart';
import 'package:crafti_hub/user%20side/screens/category/category_products_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final categoriesprovider =
        Provider.of<CategoriesProvider>(context, listen: false);
    categoriesprovider.fetchCategories(context);
  }

  @override
  Widget build(BuildContext context) {
    final categoriesprovider = Provider.of<CategoriesProvider>(context);
    final categories = categoriesprovider.categories;

    return Scaffold(
      appBar: customAppBar(title: 'Categories', backLeading: false),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Card(
            color: const Color.fromARGB(255, 234, 232, 232),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryProductsPage(
                        categoryName: categories[index].categoryName),
                  ),
                );
              },
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  categories[index].categoryImage,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(categories[index].categoryName,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          );
        },
      ),
    );
  }
}
