import 'package:crafti_hub/Vandor%20side/common/product_details_page.dart';
import 'package:crafti_hub/Vandor%20side/screens/Auth/auth_provider.dart';
import 'package:crafti_hub/Vandor%20side/screens/Auth/login_page.dart';
import 'package:crafti_hub/Vandor%20side/screens/Auth/register_page.dart';
import 'package:crafti_hub/Vandor%20side/screens/bottom%20navigation%20bar/bottom_bar.dart';
import 'package:crafti_hub/Vandor%20side/screens/home/home_page.dart';
import 'package:crafti_hub/Vandor%20side/screens/home/order_provider.dart';
import 'package:crafti_hub/Vandor%20side/screens/products/add_product_page.dart';
import 'package:crafti_hub/Vandor%20side/screens/products/edit_product_page.dart';
import 'package:crafti_hub/Vandor%20side/screens/products/product_Provider.dart';
import 'package:crafti_hub/Vandor%20side/screens/profile/profile_page.dart';
import 'package:crafti_hub/Vandor%20side/screens/profile/provider/profile_provider.dart';
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
import 'package:crafti_hub/spalsh%20Screen/splash_screen.dart';
import 'package:crafti_hub/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        //user Side
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => CategoriesProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),

        // Vendor Side

        ChangeNotifierProvider(create: (_) => VendorAuthProvider()),
        ChangeNotifierProvider(create: (_) => VendorProfileProvider()),
        ChangeNotifierProvider(create: (_) => VendorProductProvider()),
        ChangeNotifierProvider(create: (_) => VendorOrderProvider())
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
        debugShowCheckedModeBanner: false,
          theme: ThemeData(scaffoldBackgroundColor: Colors.white),
          initialRoute: '/splashScreen',
          routes: {
            '/welcomePage': (context) => WelcomePage(),

            //user Side

            '/splashScreen': (context) => SplashScreen(),
            '/login': (context) => LoginPage(),
            '/register': (context) => RegisterPage(),
            '/bottomBar': (context) => BottomBar(),
            '/cart': (context) => CartPage(),
            '/orders': (context) => OrderPage(),
            '/productDetails': (context) => ProductDetailPage(),

            // Vendon Side

            '/vendorLogin': (context) => VendorLoginPage(),
            '/vendorRegister': (context) => VendorRegisterPage(),
            '/vendorBottomBar': (context) => VendorBottomBar(),
            '/vendorHome': (context) => VendorHomePage(),
            '/vendorProfile': (context) => VendorProfilePage(),
            '/vendorAddProduct': (context) => VendorAddProductPage(),
            '/vendorProductDetails': (context) => VendorProductDetailPage(),
            '/vendorEditProduct': (context) => VendorEditProductPage()
          });
    });
  }
}
