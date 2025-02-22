import 'package:carousel_slider/carousel_slider.dart';
import 'package:crafti_hub/user%20side/common/custom_app_bar.dart';
import 'package:crafti_hub/user%20side/screens/home/carousels.dart';
import 'package:crafti_hub/user%20side/screens/home/home_provider.dart';
import 'package:crafti_hub/user%20side/screens/home/promo_banner.dart';
import 'package:crafti_hub/user%20side/screens/products/product_card.dart';
import 'package:crafti_hub/user%20side/screens/profile/profile_provider.dart';
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

    homeProvider.fetchAllProducts(context);
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    final user = Provider.of<ProfileProvider>(context).user;
    return Scaffold(
      appBar: homeAppBar(
          userName: user?.username ?? 'Guest',
          onPressed: () {
            Navigator.pushNamed(context, '/cart');
          }),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (homeProvider.promoBanners.isNotEmpty) PromoBanner(),
            if (homeProvider.popularProducts.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text(
                  textScaler: TextScaler.noScaling,
                  'Popular',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
              rowProductSection(homeProvider.popularProducts)
            ],
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
            if (homeProvider.carousels.isNotEmpty) Carousels(),
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
                  mainAxisSpacing: 3,
                  crossAxisSpacing: 3,
                  childAspectRatio: 0.50,
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
