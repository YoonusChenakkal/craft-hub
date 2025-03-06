import 'package:crafti_hub/user%20side/common/custom_app_bar.dart';
import 'package:crafti_hub/user%20side/screens/category/category_model.dart';
import 'package:crafti_hub/user%20side/screens/home/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryProductsPage extends StatelessWidget {
  final CategoryModel category;
  const CategoryProductsPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);

    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) => homeProvider.ProductsByCategory = [],
      child: Scaffold(
        appBar: customAppBar(title: category.name, backLeading: false),
        body: Padding(
            padding: const EdgeInsets.only(left: 3, right: 3),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: SizedBox(
                      width: 70,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(top: 2),
                          child: ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: category.subCategories.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                  onTap: () {
                                    homeProvider.getProductsofSubcategory(
                                        category.name,
                                        category.subCategories[index].name);
                                  },
                                  child: Column(children: [
                                    Container(
                                        child: ClipRRect(
                                      borderRadius: BorderRadius.circular(13),
                                      child: Image.asset(
                                        category.subCategories[index].image,
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                                    Container(
                                        child: Text(
                                            category.subCategories[index].name))
                                  ]));
                            },
                            separatorBuilder: (context, int index) {
                              return SizedBox(
                                height: 20,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 3, right: 3),
                      child: Consumer<HomeProvider>(
                        builder: (context, provider, child) {
                          final products = provider.ProductsByCategory;
                          print(products.length);
                          // Check if products list is empty
                          if (products.isEmpty || products == null) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons
                                        .search_off, // You can use any icon here
                                    size: 50,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "No Products Found",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          return GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              final product = products[index];
                              return InkWell(
                                onTap: () => Navigator.pushNamed(
                                  context,
                                  '/productDetails',
                                  arguments: products[index],
                                ),
                                child: Container(
                                  margin: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(13),
                                    child: product.imageUrls.isNotEmpty
                                        ? Image.network(
                                            product.imageUrls[0].productImage,
                                            fit: BoxFit.cover,
                                          )
                                        : const Placeholder(),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ])),
      ),
    );
  }
}
