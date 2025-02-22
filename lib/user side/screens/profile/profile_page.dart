import 'package:crafti_hub/user%20side/common/button.dart';
import 'package:crafti_hub/user%20side/common/custom_app_bar.dart';
import 'package:crafti_hub/user%20side/common/expandable_address_card.dart';
import 'package:crafti_hub/user%20side/const/local_storage.dart';
import 'package:crafti_hub/user%20side/screens/profile/about.dart';
import 'package:crafti_hub/user%20side/screens/profile/pay.dart';
import 'package:crafti_hub/user%20side/screens/profile/personal_info_setcion.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'Profile'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildOrderAndCartSection(context),
            SizedBox(height: 1.5.h),
            const PersonalInfoSetcion(),
            const SavedAddressSection(),
            _buildSettingsSection(context), // Added settings section
            SizedBox(height: 2.h),
            _buildLogoutButton(context),
          ],
        ),
      ),
    );
  }

  // Add this new widget method for settings section
  Widget _buildSettingsSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(color: const Color.fromARGB(255, 129, 63, 42)),
        ),
        child: Column(
          children: [
            _buildSettingsTile(
              context,
              icon: Icons.payment_outlined,
              title: 'Payment Methods',
              page: Pay(),
            ),
            _buildSettingsTile(
              context,
              icon: Icons.info,
              title: 'About',
              page: About(),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method for building consistent list tiles
  Widget _buildSettingsTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Widget page,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Colors.brown[800]),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
          color: Colors.brown[900],
        ),
      ),
      trailing: Icon(Icons.chevron_right, color: Colors.grey[600]),
      onTap: () =>
          Navigator.push(context, MaterialPageRoute(builder: (_) => page)),
    );
  }

  // Rest of your existing methods remain the same
  Widget _buildOrderAndCartSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildButtonCard(
          text: 'Orders',
          icon: Icons.shopping_bag_outlined,
          onpressed: () => Navigator.pushNamed(context, '/orders'),
        ),
        _buildButtonCard(
          text: 'Cart',
          icon: Icons.shopping_cart_outlined,
          onpressed: () => Navigator.pushNamed(context, '/cart'),
        ),
      ],
    );
  }

  Widget _buildButtonCard({
    required String text,
    required IconData icon,
    required VoidCallback onpressed,
  }) {
    return SizedBox(
      width: 170,
      height: 60,
      child: GestureDetector(
        onTap: onpressed,
        child: Card(
          shape: const StadiumBorder(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: const Color.fromARGB(255, 40, 32, 0)),
                const SizedBox(width: 5),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: customButton(
        isLoading: false,
        color: Colors.red,
        buttonName: 'Log Out',
        onPressed: () async {
          await LocalStorage.clearUser();
          Navigator.pushNamedAndRemoveUntil(
              context, '/login', (route) => false);
        },
      ),
    );
  }
}
