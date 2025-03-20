import 'package:crafti_hub/Vandor%20side/common/button.dart';
import 'package:crafti_hub/Vandor%20side/common/flush_bar.dart';
import 'package:crafti_hub/Vandor%20side/screens/home/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<VendorOrderProvider>(context);
    final orders = orderProvider.orders;
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
                      padding: EdgeInsets.all(2.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                  color: order.status.trim() == "REJECTED"
                                      ? Colors.red[50]
                                      : order.status.trim() == "DELIVERED" ||
                                              order.status.trim() ==
                                                  "CONFIRMED" ||
                                              order.status.trim() ==
                                                  "OUT FOR DELIVERY"
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
                                                order.status.trim() ==
                                                    "CONFIRMED" ||
                                                order.status.trim() ==
                                                    "OUT FOR DELIVERY"
                                            ? Colors.green
                                            : Colors.orange,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 1.5.h,
                          ),
                          Text(
                            "Order ID: ${order.orderIds}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 1.h),
                          Text(
                            order.addressDetails.isEmpty
                                ? "Address: No address"
                                : "Address: ${order.addressDetails[0].addressLine1 ?? 'Not Address'}, ${order.addressDetails[0].addressLine2 ?? 'Not Found'}, ${order.addressDetails[0].city ?? 'not Found'}, ${order.addressDetails[0].pincode ?? 'not Found'}, ${order.addressDetails[0].state ?? 'not Found'}"
                                    .trim()
                                    .replaceAll(RegExp(r' ,| , '), ','),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 1.h),
                          Row(
                            children: [
                              Text(
                                "Mobile No:",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                width: 1.w,
                              ),
                              order.addressDetails[0].mobileNumber.isNotEmpty &&
                                      order.addressDetails[0].mobileNumber !=
                                          null
                                  ? GestureDetector(
                                      onLongPress: () {
                                        Clipboard.setData(ClipboardData(
                                            text: order.addressDetails[0]
                                                .mobileNumber));
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content:
                                                  Text('Copied to clipboard!')),
                                        );
                                        HapticFeedback.vibrate();
                                      },
                                      child: Text(
                                        order.addressDetails[0].mobileNumber,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    )
                                  : Text(
                                      'No Number',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                            ],
                          ),
                          SizedBox(height: 1.h),
                          Row(
                            children: [
                              Text(
                                "Whatsapp No:",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                width: 1.w,
                              ),
                              order.addressDetails[0].whatsappNumber
                                          .isNotEmpty &&
                                      order.addressDetails[0].whatsappNumber !=
                                          null
                                  ? GestureDetector(
                                      onLongPress: () {
                                        Clipboard.setData(ClipboardData(
                                            text: order.addressDetails[0]
                                                .whatsappNumber));
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content:
                                                  Text('Copied to clipboard!')),
                                        );
                                        HapticFeedback.vibrate();
                                      },
                                      child: Text(
                                        order.addressDetails[0].whatsappNumber,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    )
                                  : Text(
                                      order.addressDetails[0].whatsappNumber ??
                                          'No Whatsapp Number',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                            ],
                          ),
                          SizedBox(height: 1.h),
                          Text(
                            "Items:",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "   ${List.generate(order.productNames.length, (index) => "${order.productNames[index]} x ${order.quantities[index]}").join(", ")}",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 2.h),
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
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              DropdownButton<String>(
                                value: order.status,
                                onChanged: (String? newValue) {
                                  if (newValue != null) {
                                    final data = {"status": newValue};
                                    orderProvider
                                        .changeOrderStatus(order.id, data)
                                        .then((value) {
                                      return showFlushbar(
                                          context: context,
                                          color: Colors.green,
                                          icon: Icons.verified,
                                          message: 'Status Changed');
                                    });
                                  }
                                },
                                items: [
                                  "CONFIRMED",
                                  "WAITING FOR CONFIRMATION",
                                  "OUT FOR DELIVERY",
                                  "DELIVERED",
                                  "REJECTED"
                                ].map((String status) {
                                  return DropdownMenuItem<String>(
                                    value: status,
                                    child: Text(
                                      status,
                                      style: TextStyle(color: Color.fromARGB(255, 129, 63, 42),),
                                    ),
                                  );
                                }).toList(),
                              ),
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
