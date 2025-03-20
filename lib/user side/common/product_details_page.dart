import 'dart:math';

import 'package:crafti_hub/user%20side/common/add_to_cart_sheet.dart';
import 'package:crafti_hub/user%20side/common/custom_app_bar.dart';
import 'package:crafti_hub/user%20side/common/flush_bar.dart';
import 'package:crafti_hub/user%20side/screens/home/home_provider.dart';
import 'package:crafti_hub/user%20side/screens/products/product_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  bool _showAllReviews = false;
  TextEditingController reviewController = TextEditingController();
  int _rating = 0;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    final ProductModel product = args as ProductModel;

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
                        // Product Name and Stock Status
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
                              margin: const EdgeInsets.only(left: 10),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                'In Stock',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.green,
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
                        // Reviews Section
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
                        // Write Review Section
                        const SizedBox(height: 16),
                        const Text(
                          'Write a Review',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Rating Stars
                        Row(
                          children: List.generate(5, (index) {
                            return IconButton(
                              icon: Icon(
                                index < _rating
                                    ? Icons.star_rounded
                                    : Icons.star_outline_rounded,
                                color: Colors.amber,
                                size: 32,
                              ),
                              onPressed: () {
                                setState(() {
                                  _rating = index + 1;
                                });
                              },
                            );
                          }),
                        ),
                        const SizedBox(height: 12),
                        // Review Text Field
                        TextField(
                          controller: reviewController,
                          decoration: const InputDecoration(
                            hintText:
                                'Share your thoughts about the product...',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.yellow),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          maxLines: 4,
                        ),
                        const SizedBox(height: 16),
                        // Submit Button
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.send_rounded,
                                  color: Colors.white, size: 20),
                              label: const Text(
                                'SUBMIT REVIEW',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.yellow.shade600,
                                foregroundColor: Colors.white,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () async {
                                if (_rating == 0) {
                                  showFlushbar(
                                      context: context,
                                      color: Colors.red,
                                      icon: Icons.error,
                                      message: 'Please select a rating');

                                  return;
                                }
                                if (reviewController.text.isEmpty) {
                                  showFlushbar(
                                      context: context,
                                      color: Colors.red,
                                      icon: Icons.error,
                                      message: 'Please write a review');

                                  return;
                                }
                                final homeProvider = Provider.of<HomeProvider>(
                                    context,
                                    listen: false);
                                await homeProvider.addReviewToProduct(context,
                                    product.id, reviewController.text, _rating);
                                // Clear form
                                setState(() {
                                  reviewController.text = '';
                                  _rating = 0;
                                });
                              },
                            ),
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
          _buildAddToCartBar(context, product)
        ],
      ),
    );
  }

  Widget _buildAddToCartBar(BuildContext context, product) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () => _showAddToCartDialog(context, product),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 129, 63, 42),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'ADD TO CART',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddToCartDialog(BuildContext context, product) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => AddToCartSheet(product: product),
    );
  }
}
