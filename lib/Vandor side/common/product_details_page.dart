import 'dart:math';

import 'package:crafti_hub/Vandor%20side/common/button.dart';
import 'package:crafti_hub/Vandor%20side/common/custom_app_bar.dart';
import 'package:crafti_hub/user%20side/screens/products/product_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VendorProductDetailPage extends StatefulWidget {
  @override
  State<VendorProductDetailPage> createState() =>
      _VendorProductDetailPageState();
}

class _VendorProductDetailPageState extends State<VendorProductDetailPage> {
  bool _showAllReviews = false;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    ProductModel product = args as ProductModel;

    final double originalPrice = (product.price);
    final double savings = product.price - product.offerPrice;
    final bool hasDiscount = product.offerPrice < product.price;

    return Scaffold(
      appBar: customAppBar(title: 'Product Details'),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Product Image Carousel
                  SizedBox(
                    height: 300,
                    child: product.imageUrls.isNotEmpty
                        ? PageView.builder(
                            itemCount: product.imageUrls.length,
                            itemBuilder: (_, index) => Image.network(
                              product.imageUrls[index].productImage,
                              fit: BoxFit.cover,
                              width: 150,
                              height: 150,
                              errorBuilder: (_, __, ___) => const Center(
                                  child: Icon(
                                Icons.broken_image,
                                size: 100,
                                color: Colors.grey,
                              )),
                            ),
                          )
                        : const Center(
                            child: Icon(
                              Icons.image_not_supported,
                              size: 100,
                              color: Colors.grey,
                            ),
                          ),
                  ),
                  // Product Details
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product Name
                        Row(
                          children: [
                            Text(
                              product.productName,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.2),
                                // : Colors.red.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'In Stock',
                                // : 'Out Of Stock',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.green,
                                  // : Colors.red,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 8),
                        // Price Section
                        Row(
                          children: [
                            Text(
                              '₹${product.offerPrice}',
                              style: const TextStyle(
                                fontSize: 28,
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '/ ',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                        // Savings and Discount
                        if (hasDiscount) ...[
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                '₹${product.price}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey.shade500,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  'Save ₹${savings.toStringAsFixed(2)} (${product.discount}% off)',
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                        const SizedBox(height: 16),
                        // Product Description
                        Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          product.productDescription,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Customer Reviews',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const Divider(),
                        const SizedBox(height: 8),
                        // Reviews List
                        // Add a state variable to track whether to show all reviews

// Inside the build method, update the reviews section
                        if (product.reviews != null &&
                            product.reviews.isNotEmpty)
                          Column(
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: _showAllReviews
                                    ? product.reviews.length
                                    : min(3, product.reviews.length),
                                itemBuilder: (context, index) {
                                  final review = product.reviews[index];
                                  return Card(
                                    color: const Color.fromARGB(
                                        255, 250, 250, 250),
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    elevation: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                review.user,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              const Spacer(),
                                              ...List.generate(
                                                5,
                                                (starIndex) => Icon(
                                                  starIndex <
                                                          review.rating.toInt()
                                                      ? Icons.star_rounded
                                                      : Icons
                                                          .star_outline_rounded,
                                                  color: Colors.amber,
                                                  size: 20,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            review.review ?? 'No review ',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey.shade700,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            DateFormat.yMd()
                                                .format(review.createdAt),
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey.shade500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                              if (product.reviews.length >
                                  3) // Show "View All" button only if there are more than 3 reviews
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _showAllReviews =
                                          !_showAllReviews; // Toggle between showing all and showing 3
                                    });
                                  },
                                  child: Text(
                                    _showAllReviews ? 'Show Less' : 'View All',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                            ],
                          )
                        else
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: Text(
                              'No reviews yet. Be the first to review!',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Add to Cart Bar
          Padding(
              padding: EdgeInsets.all(15),
              child: customButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/vendorEditProduct',
                        arguments: product);
                  },
                  buttonName: 'Edit Product',
                  color: Colors.brown))
        ],
      ),
    );
  }
}
