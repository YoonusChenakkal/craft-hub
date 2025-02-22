import 'package:crafti_hub/Vandor%20side/common/form_field_features.dart';
import 'package:crafti_hub/Vandor%20side/screens/products/product_Provider.dart';
import 'package:crafti_hub/Vandor%20side/screens/products/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VendorProductsPage extends StatefulWidget {
  const VendorProductsPage({super.key});

  @override
  State<VendorProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<VendorProductsPage> {
  @override
  void initState() {
    super.initState();

    // Fetch products only once when the screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<VendorProductProvider>(context, listen: false)
          .fetchProducts(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<VendorProductProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (value) {
                  productProvider.setSearchQuery(value);
                },
                decoration: textFormFieldDecoration(
                  hinttext: "Search Products...",
                  prefixIcon: Icons.search,
                ),
              ),
            ),
            // Product List
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await productProvider.fetchProducts(context);
                },
                child: Consumer<VendorProductProvider>(
                  builder: (context, provider, _) {
                    final filteredProducts = provider.filteredProducts;

                    if (provider.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return filteredProducts.isEmpty
                        ? const Center(
                            child: Text(
                              "No products found",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          )
                        : GridView.builder(
                            padding: const EdgeInsets.all(16),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 16,
                              crossAxisSpacing: 16,
                              childAspectRatio: 0.7,
                            ),
                            itemCount: filteredProducts.length,
                            itemBuilder: (context, index) => ProductCard(
                              product: filteredProducts[index],
                              onTap: () => Navigator.pushNamed(
                                context,
                                '/vendorProductDetails',
                                arguments: filteredProducts[index],
                              ),
                            ),
                          );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
