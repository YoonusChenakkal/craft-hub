import 'package:crafti_hub/user%20side/common/button.dart';
import 'package:crafti_hub/user%20side/screens/cart/view_model/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/products/product_model.dart';

class AddToCartSheet extends StatefulWidget {
  final ProductModel product;

  const AddToCartSheet({
    super.key,
    required this.product,
  });

  @override
  State<AddToCartSheet> createState() => _AddToCartSheetState();
}

class _AddToCartSheetState extends State<AddToCartSheet> {
  int quantity = 1;

  // Increment and decrement quantity
  void increamnetQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decreamentQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Add to Cart',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          quantitySection(),
          const SizedBox(height: 16),
          customRoundButton(
            isLoading: cartProvider.isLoading,
            onPressed:
                // Add the product to the cart
                () async {
              final body = {
                'quantity': quantity,
              };
              await cartProvider.addToCart(body, widget.product.id, context);
            },
            textWidget: Text('Add to Cart',
                style: TextStyle(fontSize: 18, color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget quantitySection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: decreamentQuantity,
        ),
        Text(
          quantity.toString(),
          style: const TextStyle(fontSize: 18),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: increamnetQuantity,
        ),
      ],
    );
  }
}
