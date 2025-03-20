import 'package:crafti_hub/local_storage.dart';
import 'package:crafti_hub/user%20side/screens/orders/order_model.dart';
import 'package:crafti_hub/user%20side/screens/orders/order_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';

class OrderProvider extends ChangeNotifier {
  List<Order> orders = [];
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  final OrderRepository _orderRepository = OrderRepository();

  Future fetchOrders() async {
    SVProgressHUD.show();

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
      SVProgressHUD.dismiss();

      isLoading = false;
    }
  }
}
