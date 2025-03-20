import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'package:crafti_hub/local_storage.dart';
import 'package:crafti_hub/user%20side/screens/home/home_provider.dart';
import 'package:crafti_hub/user%20side/screens/profile/profile_provider.dart';
import 'package:crafti_hub/Vandor%20side/screens/profile/provider/profile_provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..forward();

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _initializeApp();
  }

  Future<void> _initializeApp() async {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    homeProvider.fetchPromoBanners(context);
    homeProvider.fetchCarousel(context);
    homeProvider.fetchOfferProducts(context);
    homeProvider.fetchPopularProducts(context);

    final userType = await LocalStorage.getUserType();
    final userId = await LocalStorage.getUser();

    if (userId != null) {
      if (userType == 'vendor') {
        await Provider.of<VendorProfileProvider>(context, listen: false)
            .fetchUser(context);
        Navigator.pushReplacementNamed(context, '/vendorBottomBar');
      } else {
        await Provider.of<ProfileProvider>(context, listen: false)
            .fetchUser(context);
        Navigator.pushReplacementNamed(context, '/bottomBar');
      }
    } else {
      Navigator.pushReplacementNamed(context, '/welcomePage');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FadeTransition(
        opacity: _animation,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/logo.jpg', height: 20.h, width: 20.h),
              SizedBox(height: 1.h),
              RichText(
                text: TextSpan(
                  text: 'Crafti ',
                  style: GoogleFonts.cairoPlay(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: 'Hub',
                      style: GoogleFonts.novaSquare(
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 129, 63, 42),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
