import 'package:crafti_hub/user%20side/common/flush_bar.dart';
import 'package:crafti_hub/user%20side/const/local_storage.dart';
import 'package:crafti_hub/user%20side/screens/cart/cart_model.dart';
import 'package:crafti_hub/user%20side/screens/cart/repository/cart_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  List<CartItem> cartItems = [];
  double totalPrice = 0.0;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  final CartRepository _cartRepository = CartRepository();
  double calculateTotalSavings() {
    return cartItems.fold(0, (sum, item) {
      double originalTotal = item.product.price * item.quantity;
      double discountedTotal = item.price * item.quantity;
      return sum + (originalTotal - discountedTotal);
    });
  }

  Future<void> fetchCart() async {
    isLoading = true;
    notifyListeners(); // Notify UI that loading has started

    try {
      final userId = await LocalStorage.getUser();

      // Fetch the cart data from the repository
      final response = await _cartRepository.fetchCart(userId);

      // Check if the response contains the "message" key indicating an empty cart
      if (response.data.containsKey('message') &&
          response.data['message'] == 'Cart is empty') {
        cartItems = [];
        totalPrice = 0.0;
        notifyListeners();
        return; // Stop further execution
      }

      print('cart_items  ----------->${response.data['cart_items']}');
      print('total_price  ----------->${response.data['total_price']}');

      // Extract total price safely
      totalPrice = (response.data['total_price'] as num).toDouble();

      // Extract cart items from nested "products" array
      cartItems = (response.data['cart_items'] as List)
          .expand((vendor) => vendor['products'] as List)
          .map((json) => CartItem.fromJson(json))
          .toList();

      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Fetch cart error: $e');
      }
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners(); // Notify UI that loading has stopped
    }
  }

  Future addToCart(Map<String, dynamic> body, int productId, context) async {
    isLoading = true;
    try {
      final userId = await LocalStorage.getUser();

      await _cartRepository.addToCart(body, productId, userId);
      Navigator.pop(context);
      await showFlushbar(
          message: 'Product added to cart',
          icon: Icons.check,
          context: context,
          color: Colors.green);
      fetchCart();
    } catch (e) {
      if (kDebugMode) {
        print('Add to cart error: $e');
      }
      showFlushbar(
          message: e.toString(),
          icon: Icons.error,
          color: Colors.red,
          context: context);
    } finally {
      isLoading = false;
    }
  }

  Future deleteCart(int cartItemId, BuildContext context) async {
    try {
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

  // checkOut
  Future checkOut(BuildContext context, body) async {
    try {
      isLoading = true;
      await _cartRepository.checkOut(body);
      fetchCart();
      notifyListeners();
      showFlushbar(
          message: 'Order placed successfully',
          color: Colors.green,
          icon: Icons.check,
          context: context);
    } catch (e) {
      if (kDebugMode) {
        print('Checkout error: $e');
      }
      showFlushbar(
          message: e.toString(),
          icon: Icons.error,
          color: Colors.red,
          context: context);
    } finally {
      isLoading = false;
    }
  }
}
