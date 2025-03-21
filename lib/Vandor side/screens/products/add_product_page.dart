import 'package:crafti_hub/Vandor%20side/common/button.dart';
import 'package:crafti_hub/Vandor%20side/common/custom_app_bar.dart';
import 'package:crafti_hub/Vandor%20side/common/flush_bar.dart';
import 'package:crafti_hub/Vandor%20side/common/form_field_features.dart';
import 'package:crafti_hub/Vandor%20side/screens/products/category_dialog_box.dart';
import 'package:crafti_hub/Vandor%20side/screens/products/offer_dialog_box.dart';
import 'package:crafti_hub/Vandor%20side/screens/products/image_pick_section.dart';
import 'package:crafti_hub/Vandor%20side/screens/products/product_Provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class VendorAddProductPage extends StatelessWidget {
  const VendorAddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final productProvider = Provider.of<VendorProductProvider>(
      context,
    );

    String getSelectedOffers(VendorProductProvider productProvider) {
      List<String> selectedOffers = [];

      if (productProvider.isOfferProduct) selectedOffers.add('Offer Product');
      if (productProvider.isPopular) selectedOffers.add('Popular Product');
      if (productProvider.isNewArrival) selectedOffers.add('New Arrival');
      if (productProvider.isTrending) selectedOffers.add('Trending Product');

      return selectedOffers.isNotEmpty ? selectedOffers.join(', ') : 'Select';
    }

    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) => productProvider.reset(),
      child: Scaffold(
        appBar: customAppBar(title: 'Add Product', leading: false),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 2.h),

                  // Image Upload Section
                  ImagePickSection(),

                  SizedBox(height: 3.h),

                  // Product Name
                  TextFormField(
                    controller: productProvider.tcProductName,
                    validator: emptyCheckValidator,
                    decoration: textFormFieldDecoration(
                      hinttext: 'Product Name',
                      prefixIcon: Icons.production_quantity_limits_outlined,
                    ),
                  ),
                  SizedBox(height: 1.h),

                  // Product Description
                  TextFormField(
                    controller: productProvider.tcProductDescription,
                    validator: emptyCheckValidator,
                    decoration: textFormFieldDecoration(
                      hinttext: 'Product Description',
                      prefixIcon: Icons.description_outlined,
                    ),
                  ),
                  SizedBox(height: 1.h),

                  // Price
                  TextFormField(
                    controller: productProvider.tcPrice,
                    keyboardType: TextInputType.number,
                    validator: emptyCheckValidator,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(6),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: textFormFieldDecoration(
                      hinttext: 'Price',
                      prefixIcon: Icons.currency_rupee,
                    ),
                  ),
                  SizedBox(height: 1.h),

                  // Discount
                  InkWell(
                    onTap: () {
                      showDiscountDialog(context, productProvider);
                    },
                    child: TextFormField(
                      enabled: false,
                      controller: productProvider.tcDiscount,
                      decoration: textFormFieldDecoration(
                        hinttext: productProvider.tcDiscount.text.isEmpty
                            ? 'Enter Discount %'
                            : 'Discount: ${productProvider.tcDiscount.text}%',
                        prefixIcon: Icons.currency_exchange_rounded,
                      ),
                    ),
                  ),

                  SizedBox(height: 1.h),

                  // Select Category
                  InkWell(
                    onTap: () async {
                      if (!productProvider.isLoading) {
                        showCategoryDialog(context);
                      }
                    },
                    child: TextFormField(
                      enabled: false,
                      decoration: textFormFieldDecoration(
                        hinttext: productProvider.selectedCategory == null
                            ? 'Select Category'
                            : '${productProvider.selectedCategory?.name} - ${productProvider.selectedSubCategory?.name ?? 'select Sub Category'}',
                        prefixIcon: Icons.category_outlined,
                      ),
                    ),
                  ),

                  SizedBox(height: 1.h),

                  // selct  Offers
                  InkWell(
                    onTap: () {
                      showOfferDialogBox(context);
                    },
                    child: TextFormField(
                      enabled: false,
                      decoration: textFormFieldDecoration(
                        hinttext: getSelectedOffers(productProvider),
                        prefixIcon: Icons.local_offer_outlined,
                      ),
                    ),
                  ),

                  SizedBox(height: 3.h),

                  // Add Product Button
                  customButton(
                    isLoading: productProvider.isLoading,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (productProvider.selectedImages.isEmpty) {
                          showFlushbar(
                            context: context,
                            color: Colors.red,
                            icon: Icons.image_not_supported,
                            message: 'Please select at least one product image',
                          );
                          return;
                        } else if (productProvider.selectedCategory == null ||
                            productProvider.selectedSubCategory == null) {
                          showFlushbar(
                            context: context,
                            color: Colors.red,
                            icon: Icons.category_rounded,
                            message: 'Please select Category and Sub Category',
                          );
                        } else {
                          productProvider.addProduct(context);
                        }
                      }
                    },
                    buttonName: 'Add Product',
                    color: Color.fromARGB(255, 129, 63, 42),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  showOfferDialogBox(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return OfferDialogBox();
      },
    );
  }

  void showCategoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CategoryDialogBox();
      },
    );
  }

  void showDiscountDialog(
      BuildContext context, VendorProductProvider productProvider) {
    TextEditingController discountController = TextEditingController();
    double price = double.tryParse(productProvider.tcPrice.text) ?? 0.0;
    double discountedPrice = price; // Local state variable for updating UI

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Enter Discount Percentage"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: discountController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      hintText: 'Enter discount %',
                      prefixIcon: const Icon(Icons.percent),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onChanged: (value) {
                      double discount = double.tryParse(value) ?? 0.0;
                      if (discount >= 0 && discount <= 100) {
                        setState(() {
                          discountedPrice = price - (price * (discount / 100));
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Discounted Price: ₹${discountedPrice.toStringAsFixed(2)}",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    double discount =
                        double.tryParse(discountController.text) ?? 0.0;
                    if (discount < 0 || discount > 100) {
                      showFlushbar(
                        context: context,
                        color: Colors.red,
                        icon: Icons.error_outline,
                        message: 'Enter a valid discount percentage (0-100%)',
                      );
                    } else {
                      // Save discount in provider
                      productProvider.tcDiscount.text = discountController.text;
                      productProvider.discountedPrice = discountedPrice;
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Apply"),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
