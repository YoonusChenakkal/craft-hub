import 'package:crafti_hub/user%20side/common/custom_app_bar.dart';
import 'package:crafti_hub/user%20side/screens/orders/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<OrderProvider>(context, listen: false).fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<OrderProvider>(context).orders;
    return Scaffold(
      appBar: customAppBar(title: 'Your Orders'),
      body: orders.isEmpty
          ? const Center(
              child: Text(
                'No orders found.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];

                // Date parsing and formatting
                DateTime? orderDate;
                try {
                  orderDate = DateTime.parse(order.orderTime);
                } catch (e) {
                  orderDate = null;
                }

                final formattedOrderDate = orderDate != null
                    ? DateFormat('MMM dd, yyyy - hh:mm a').format(orderDate)
                    : order.orderTime;

                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 6,
                  shadowColor: Colors.grey.shade400,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Order ID: ${order.orderIds}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 6),
                              decoration: BoxDecoration(
                                color: order.status == 'CONFIRMED'
                                    ? Colors.green.shade100
                                    : Colors.red.shade100,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                order.status,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: order.status == 'CONFIRMED'
                                      ? Colors.green.shade800
                                      : Colors.red.shade800,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                            height: 20, thickness: 1, color: Colors.grey),
                        Text(
                          'Products: ${order.productNames}',
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total Price:',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '₹${order.totalPrice.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Payment Method: ${order.paymentMethod}',
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 12),
                        _buildOrderTimeline(
                          orderDate: formattedOrderDate,
                          deliveryDate: '5-7 days from order date',
                          status: order.status,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget _buildOrderTimeline({
    required String orderDate,
    required String deliveryDate,
    required String status,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTimelineRow(
          icon: Icons.shopping_cart_checkout,
          title: 'Order Placed',
          subtitle: orderDate,
          iconColor: Colors.blue,
        ),
        const SizedBox(height: 8),
        _buildTimelineRow(
          icon: Icons.delivery_dining,
          title:
              status == 'CONFIRMED' ? 'Expected Delivery' : 'Delivery Status',
          subtitle: status == 'CONFIRMED'
              ? deliveryDate
              : 'Will update once confirmed',
          iconColor: status == 'CONFIRMED' ? Colors.orange : Colors.grey,
        ),
      ],
    );
  }

  Widget _buildTimelineRow({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color iconColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: iconColor, size: 20),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        )
      ],
    );
  }
}
