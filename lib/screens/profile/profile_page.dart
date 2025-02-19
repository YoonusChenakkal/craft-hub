import 'package:crafti_hub/common/button.dart';
import 'package:crafti_hub/common/expandable_address_card.dart';
import 'package:crafti_hub/const/local_storage.dart';
import 'package:crafti_hub/screens/profile/personal_info_setcion.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildOrderAndCartSection(context),
            SizedBox(
              height: 1.5.h,
            ),
            PersonalInfoSetcion(),
            SavedAddressSection(),
            _buildLogoutButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderAndCartSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildButtonCard(
            text: 'Orders',
            icon: Icons.shopping_bag_outlined,
            onpressed: () => {}),
        _buildButtonCard(
            text: 'Cart',
            icon: Icons.shopping_cart_outlined,
            onpressed: () => Navigator.pushNamed(context, '')),
      ],
    );
  }

  Widget _buildButtonCard(
      {required String text,
      required IconData icon,
      required VoidCallback onpressed}) {
    return SizedBox(
        width: 170,
        height: 60,
        child: GestureDetector(
          onTap: onpressed,
          child: Card(
            shape: StadiumBorder(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: const Color.fromARGB(255, 40, 32, 0),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    text,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
        ));
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
          Navigator.pushNamedAndRemoveUntil(context, '', (route) => false);
        },
      ),
    );
  }
}
