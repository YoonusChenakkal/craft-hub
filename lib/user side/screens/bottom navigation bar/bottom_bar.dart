import 'package:crafti_hub/user%20side/common/product_details_page.dart';
import 'package:crafti_hub/user%20side/screens/category/categories_page.dart';
import 'package:crafti_hub/user%20side/screens/home/home_page.dart';
import 'package:crafti_hub/user%20side/screens/profile/profile_page.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [HomePage(), CategoriesPage(), ProfilePage()];

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
          backgroundColor: Colors.brown,
          unselectedItemColor: const Color.fromARGB(255, 255, 220, 186),
          selectedItemColor: Colors.white,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.store), label: 'Categories'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
          ],
        ),
        body: _screens[_selectedIndex],
      ),
    );
  }
}
