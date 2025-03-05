import 'package:crafti_hub/Vandor%20side/common/button.dart';
import 'package:crafti_hub/Vandor%20side/screens/home/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<VendorOrderProvider>(context).orders;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Orders",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(3.h),
        child: orders.isEmpty
            ? const Center(
                child: Text(
                  "No orders available",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              )
            : ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return Card(
                    margin: EdgeInsets.only(bottom: 2.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    child: Padding(
                      padding: EdgeInsets.all(3.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Order ID: ${order.orderIds}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                  color: order.status.trim() == "Delivered"
                                      ? Colors.green[50]
                                      : Colors.orange[50],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  order.status.trim(),
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: order.status.trim() == "Delivered"
                                        ? Colors.green
                                        : Colors.orange,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 2),
                          Text(
                            "Items:",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "   ${order.productNames.join(", ")}",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Qty : ",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "   ${order.quantities.join(", ")}",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 1.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total Items: ${order.totalCartItems}",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "Total: ₹${order.totalPrice.toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.brown,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              customRoundButton(
                                textWidget: Text('Confirm',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    )),
                                onPressed: () {},
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
