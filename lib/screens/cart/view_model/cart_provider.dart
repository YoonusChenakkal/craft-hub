import 'package:crafti_hub/common/flush_bar.dart';
import 'package:crafti_hub/const/local_storage.dart';
import 'package:crafti_hub/screens/cart/cart_model.dart';
import 'package:crafti_hub/screens/cart/repository/cart_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  List<CartItem> cartItems = [];
  double totalPrice = 0.0;

  final CartRepository _cartRepository = CartRepository();
  double calculateTotalSavings() {
    return cartItems.fold(0, (sum, item) {
      double originalTotal = item.product.price * item.quantity;
      double discountedTotal = item.price * item.quantity;
      return sum + (originalTotal - discountedTotal);
    });
  }

  Future<void> fetchCart() async {
    try {
      final userId = 7;

      // Fetch the cart data from the repository
      final response = await _cartRepository.fetchCart(userId);

      print('cart_items  ----------->${response.data['cart_items']}');
      print('total_price  ----------->${response.data['total_price']}');

      // Extract cart items safely
      cartItems = (response.data['cart_items'] as List)
          .map((json) => CartItem.fromJson(json))
          .toList();

      // Extract total price safely
      totalPrice = (response.data['total_price'] as num).toDouble();

      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Fetch cart error: $e');
      }
      rethrow;
    }
  }

  // Future addToCart(Map<String, dynamic> body, int productId, context) async {
  //   try {
  //     final userId = await LocalStorage.getUser();

  //     final response = await _cartRepository.addToCart(body, productId, userId);
  //     Utils.flushBar(response['detail'] ?? 'Product added to cart', context,
  //         color: Colors.green);
  //     fetchCart();
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print('Add to cart error: $e');
  //     }
  //     Utils.flushBar(e.toString(), context);
  //   }
  // }

  // Future updateCart(
  //     Map<String, dynamic> body, int productId, BuildContext context) async {
  //   try {
  //     final userId = await LocalStorage.getUser();

  //     final response =
  //         await _cartRepository.updateCart(body, userId, productId);
  //     await fetchCart();
  //     canCheckOut = cartItems.every((item) => item.product.isAvailable);

  //     Utils.flushBar('Updated', context, color: Colors.green);
  //     return response;
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print('Update cart error: $e');
  //     }
  //     Utils.flushBar(e.toString(), context);
  //   }
  // }

  Future deleteCart(int cartItemId, BuildContext context) async {
    try {
      final userId = await LocalStorage.getUser();

      await _cartRepository.deleteCartItem(cartItemId);
      fetchCart();
      notifyListeners();
      showFlushbar(
          message: 'Item removed',
          color: Colors.red,
          icon: Icons.delete,
          context: context);
    } catch (e) {
      if (kDebugMode) {
        print('Remove from cart error: $e');
      }
    }
  }
}
