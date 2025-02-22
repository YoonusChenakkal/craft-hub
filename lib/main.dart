import 'package:crafti_hub/user%20side/common/product_details_page.dart';
import 'package:crafti_hub/user%20side/screens/Auth/auth_provider.dart';
import 'package:crafti_hub/user%20side/screens/Auth/login_page.dart';
import 'package:crafti_hub/user%20side/screens/Auth/register_page.dart';
import 'package:crafti_hub/user%20side/screens/bottom%20navigation%20bar/bottom_bar.dart';
import 'package:crafti_hub/user%20side/screens/cart/view/cart_page.dart';
import 'package:crafti_hub/user%20side/screens/cart/view_model/cart_provider.dart';
import 'package:crafti_hub/user%20side/screens/category/categories_provider.dart';
import 'package:crafti_hub/user%20side/screens/home/home_provider.dart';
import 'package:crafti_hub/user%20side/screens/orders/order_page.dart';
import 'package:crafti_hub/user%20side/screens/orders/order_provider.dart';
import 'package:crafti_hub/user%20side/screens/profile/profile_provider.dart';
import 'package:crafti_hub/user%20side/screens/spalsh%20Screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => CategoriesProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
          theme: ThemeData(scaffoldBackgroundColor: Colors.white),
          initialRoute: '/splashScreen',
          routes: {
            '/splashScreen': (context) => SplashScreen(),
            '/login': (context) => LoginPage(),
            '/register': (context) => RegisterPage(),
            '/bottomBar': (context) => BottomBar(),
            '/cart': (context) => CartPage(),
            '/orders': (context) => OrderPage(),
            // '/home': (context) => HomePage(),
            // '/profile': (context) => ProfilePage(),
            // '/addProduct': (context) => AddProductPage(),
            '/productDetails': (context) => ProductDetailPage(),
            // '/editProduct': (context) => EditProductPage()
          });
    });
  }
}
