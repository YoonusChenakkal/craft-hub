import 'package:crafti_hub/user%20side/screens/products/product_model.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onTap;

  const ProductCard({super.key, required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    double offerPrice = product.offerPrice;
    double price = product.price;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 50.w,
        child: Column(
          children: [
            SizedBox(
              height: 16.h,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: product.imageUrls.isNotEmpty
                      ? Image.network(
                          product.imageUrls[0].productImage,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const Center(
                              child: Icon(
                            Icons.broken_image,
                            size: 60,
                            color: Colors.grey,
                          )),
                        )
                      : const Center(
                          child: Icon(
                          Icons.image_not_supported,
                          size: 60,
                          color: Color.fromARGB(255, 101, 97, 97),
                        )),
                ),
              ),
            ),
            Expanded(
              // Use Expanded to prevent overflow
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.productName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '₹${offerPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (offerPrice < price)
                      Text(
                        '₹${price.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade500,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
