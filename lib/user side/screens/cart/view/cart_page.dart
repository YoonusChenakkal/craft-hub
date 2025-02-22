import 'package:crafti_hub/user%20side/common/button.dart';
import 'package:crafti_hub/user%20side/common/custom_app_bar.dart';
import 'package:crafti_hub/user%20side/screens/cart/cart_model.dart';
import 'package:crafti_hub/user%20side/screens/cart/view_model/cart_provider.dart';
import 'package:crafti_hub/user%20side/screens/profile/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    // TODO: implement initState
    super.initState();
    cartProvider.fetchCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'Your Cart'),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Consumer<CartProvider>(
              builder: (context, cart, _) {
                if (cart.cartItems.isEmpty) {
                  return const Center(
                    child: Text('Your cart is empty.'),
                  );
                }

                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: cart.cartItems.length,
                        itemBuilder: (context, index) {
                          final item = cart.cartItems[index];
                          return _buildCartItem(context, item, cart);
                        },
                      ),
                    ),
                    _buildCheckOutSection(context, cart),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(
      BuildContext context, CartItem cartItem, CartProvider cartProvider) {
    return Card(
      color: const Color.fromARGB(255, 234, 232, 232),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: cartItem.product.images.isEmpty ||
                  cartItem.product.images.first == null
              ? Icon(
                  Icons.image,
                  size: 50,
                  color: Colors.grey,
                )
              : Image.network(
                  cartItem.product.images.first,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
        ),
        title: Text(cartItem.product.productName),
        subtitle: Row(
          children: [
            Text(
              '${cartItem.price} x ${cartItem.quantity} = ',
            ),
            Text('₹ ${cartItem.price * cartItem.quantity}',
                style: const TextStyle(color: Colors.green)),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: cartProvider.isLoading
                  ? null
                  : () => cartProvider.deleteCart(cartItem.id, context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckOutSection(BuildContext context, CartProvider cart) {
    String selectedPayment = 'Cash on Delivery'; // Default payment method

    return Container(
      padding: const EdgeInsets.all(16),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Total Price Section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total:',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              DropdownButton<String>(
                value: selectedPayment,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    if (newValue == 'Online Payment') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text('Online Payment is currently unavailable.'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } else {
                      selectedPayment = newValue;
                    }
                  }
                },
                items: [
                  DropdownMenuItem(
                    value: 'Cash on Delivery',
                    child: Text('Cash on Delivery'),
                  ),
                  DropdownMenuItem(
                    value: 'Online Payment',
                    child: Text('Online Payment (Unavailable)',
                        style: TextStyle(color: Colors.grey)),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Payment Method Dropdown
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '₹ ${cart.totalPrice}',
                style: const TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              customRoundButton(
                isLoading: cart.isLoading,
                onPressed: () async {
                  if (selectedPayment == 'Online Payment') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text('Online Payment is currently unavailable.'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else {
                    final profileProvider =
                        Provider.of<ProfileProvider>(context, listen: false);

                    final data = {
                      "payment_method": "COD",
                      "user_name": profileProvider.user!.username,
                    };
                    await cart.checkOut(context, data);
                  }
                },
                textWidget: Text(
                  'Place Order',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
