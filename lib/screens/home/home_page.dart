import 'package:crafti_hub/common/custom_app_bar.dart';
import 'package:crafti_hub/screens/home/home_provider.dart';
import 'package:crafti_hub/screens/products/product_card.dart';
import 'package:crafti_hub/screens/products/product_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);

    homeProvider.fetchOfferProducts(context);
    homeProvider.fetchPopularProducts(context);
    homeProvider.fetchAllProducts(context);
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    return Scaffold(
      appBar: homeAppBar(
          userName: 'userName',
          onPressed: () {
            Navigator.pushNamed(context, '/cart');
          }),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (homeProvider.popularProducts.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text(
                  textScaler: TextScaler.noScaling,
                  'Popolar',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
            if (homeProvider.offerProducts.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text(
                  textScaler: TextScaler.noScaling,
                  'offerProducts',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
              rowProductSection(homeProvider.offerProducts)
            ],
            allProductSection()
          ],
        ),
      ),
    );
  }

  rowProductSection(products) {
    return products.isEmpty
        ? const Center(
            child: Text(
              "No products found",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          )
        : SizedBox(
            height: 28.h, // Adjusted height for better proportion
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 0,
                crossAxisSpacing: 0,
                childAspectRatio: 2,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) => ProductCard(
                product: products[index],
                onTap: () => Navigator.pushNamed(
                  context,
                  '/productDetails',
                  arguments: products[index],
                ),
              ),
            ),
          );
  }

  allProductSection() {
    return Consumer<HomeProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return provider.allProducts.isEmpty
            ? const Center(
                child: Text(
                  "No products found",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              )
            : GridView.builder(
                padding: const EdgeInsets.all(16),
                shrinkWrap: true, // Allows GridView to fit inside Column
                physics:
                    const NeverScrollableScrollPhysics(), // Disables GridView scrolling
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 3,
                  childAspectRatio: 0.75,
                ),
                itemCount: provider.allProducts.length,
                itemBuilder: (context, index) => ProductCard(
                  product: provider.allProducts[index],
                  onTap: () => Navigator.pushNamed(
                    context,
                    '/productDetails',
                    arguments: provider.allProducts[index],
                  ),
                ),
              );
      },
    );
  }
}
