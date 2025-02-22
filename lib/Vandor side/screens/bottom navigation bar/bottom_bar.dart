import 'package:crafti_hub/Vandor%20side/screens/home/home_page.dart';
import 'package:crafti_hub/Vandor%20side/screens/products/products_page.dart';
import 'package:crafti_hub/Vandor%20side/screens/profile/profile_page.dart';
import 'package:flutter/material.dart';

class VendorBottomBar extends StatefulWidget {
  const VendorBottomBar({super.key});

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<VendorBottomBar> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [VendorHomePage(), VendorProductsPage(), VendorProfilePage()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<bool> _onWillPop() async {
    if (_selectedIndex != 0) {
      setState(() {
        _selectedIndex = 0; // Set the selected index to 0 (Home tab)
      });
    }
    return false; // Allow back action if on the first tab
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          backgroundColor: Colors.cyan,
          unselectedItemColor: const Color.fromARGB(255, 186, 247, 255),
          selectedItemColor: Colors.white,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Products'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
          ],
        ),
        body: _screens[_selectedIndex],
      ),
    );
  }
}
