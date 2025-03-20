import 'package:crafti_hub/Vandor%20side/common/button.dart';
import 'package:crafti_hub/Vandor%20side/common/custom_app_bar.dart';
import 'package:crafti_hub/Vandor%20side/screens/home/order_card.dart';
import 'package:crafti_hub/Vandor%20side/screens/home/order_details_page.dart';
import 'package:crafti_hub/Vandor%20side/screens/home/order_model.dart';
import 'package:crafti_hub/Vandor%20side/screens/home/order_provider.dart';
import 'package:crafti_hub/Vandor%20side/screens/products/product_Provider.dart';
import 'package:crafti_hub/Vandor%20side/screens/profile/provider/profile_provider.dart';
import 'package:crafti_hub/Vandor%20side/screens/profile/model/user_model.dart';
import 'package:crafti_hub/user%20side/common/flush_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class VendorHomePage extends StatefulWidget {
  const VendorHomePage({super.key});

  @override
  State<VendorHomePage> createState() => _VendorHomePageState();
}

class _VendorHomePageState extends State<VendorHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<VendorOrderProvider>(context, listen: false).fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<VendorProfileProvider>(context);
    final orderProvider = Provider.of<VendorOrderProvider>(context);
    final productsProvider = Provider.of<VendorProductProvider>(context);

    final user = profileProvider.user;
    final orders = orderProvider.orders;
    return Scaffold(
      appBar: homeAppBar(user != null ? user.name : 'User'),
      floatingActionButton: FloatingActionButton.extended(
        label: Text(
          'New Product',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.brown,
        onPressed: () => Navigator.pushNamed(context, '/vendorAddProduct'),
        icon: const Icon(Icons.add, color: Colors.white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Verification Status Banner
              if (user != null) _buildCard(user),
              const SizedBox(height: 24),

              // Orders Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recent Orders",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  TextButton(
                    child: Text("View All",
                        style: TextStyle(
                          color: Colors.brown,
                        )),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrdersPage()));
                    },
                  ),
                ],
              ),

              // Orders List
              (orders.isEmpty)
                  ? const Center(
                      child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          child: Text("No orders yet")))
                  : SizedBox(
                      height: 18.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: orders.length > 2
                            ? 2
                            : orders.length, // Show last 2 orders
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              OrderCard(
                                order: orders[index],
                              ),
                              SizedBox(
                                width: 10,
                              )
                            ],
                          );
                        },
                      ),
                    ),

              const SizedBox(height: 24),

              // Quick Stats
              Row(
                children: [
                  _buildStatCard("Total Products",
                      productsProvider.products.length.toString(), Colors.blue),
                  const SizedBox(width: 12),
                  _buildStatCard(
                      "Pending Orders",
                      orderProvider.pendingOrders.length.toString(),
                      Colors.orange),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(UserModel user) {
    return Card(
      color: const Color.fromARGB(255, 248, 248, 248),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Icon(Icons.verified_user,
                size: 30,
                color:
                    user.isApproved ? Colors.brown[700] : Colors.yellow[700]),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Verification",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown[900]),
                  ),
                  SizedBox(height: 4),
                  user.isApproved
                      ? Text(
                          'Verification Completed',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                        )
                      : Text(
                          "Verification Pending - Under Review",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.red[700],
                          ),
                        ),
                ],
              ),
            ),
            SizedBox(width: 16),
            customRoundButton(
              onPressed: user.isApproved
                  ? () {}
                  : () {
                      Provider.of<VendorProfileProvider>(context, listen: false)
                          .fetchUser(context)
                          .then(
                        (_) {
                          showFlushbar(
                            context: context,
                            color: Colors.green,
                            icon: Icons.refresh,
                            message: 'Verification status updated',
                          );
                        },
                      );
                    },
              textWidget: Text(
                user.isApproved ? 'Done' : "Check",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
