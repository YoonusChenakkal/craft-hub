import 'package:crafti_hub/Vandor%20side/screens/home/order_model.dart';
import 'package:crafti_hub/Vandor%20side/screens/home/order_repository.dart';
import 'package:crafti_hub/local_storage.dart';
import 'package:flutter/material.dart';

class VendorOrderProvider extends ChangeNotifier {
  List<Order> orders = [];
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  final OrderRepository _orderRepository = OrderRepository();

  Future fetchOrders() async {
    isLoading = true;
    notifyListeners(); // Notify UI that loading has started

    try {
      final userId = await LocalStorage.getUser();

      // Fetch the order data from the repository
      final response = await _orderRepository.fetchOrders(userId);

      // Extract orders from nested "orders" array
      orders =
          (response.data as List).map((json) => Order.fromJson(json)).toList();

      notifyListeners();
    } catch (e) {
      print('Error fetching orders: $e');
    } finally {
      isLoading = false;
    }
  }
}
