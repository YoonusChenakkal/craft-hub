import 'package:crafti_hub/Vandor%20side/screens/home/order_model.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class OrderCard extends StatelessWidget {
  final Order order;

  const OrderCard({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70.w,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 249, 249, 249),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // Prevent unnecessary expansion
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: order.status.trim() == "REJECTED"
                      ? Colors.red[50]
                      : order.status.trim() == "DELIVERED" ||
                              order.status.trim() == "CONFIRMED" ||
                              order.status.trim() == "OUT FOR DELIVERY"
                          ? Colors.green[50]
                          : Colors.orange[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  order.status.trim(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: order.status.trim() == "REJECTED"
                        ? Colors.red
                        : order.status.trim() == "DELIVERED" ||
                                order.status.trim() == "CONFIRMED" ||
                                order.status.trim() == "OUT FOR DELIVERY"
                            ? Colors.green
                            : Colors.orange,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            order.productNames.join(','),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.shopping_bag, size: 16, color: Colors.grey),
              const SizedBox(width: 4),
              Text("${order.totalCartItems} items"),
              const Spacer(),
              Text(
                "₹${order.totalPrice.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
