import 'package:crafti_hub/Vandor%20side/common/button.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: 100.h,
          width: 100.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              logo(),
              SizedBox(
                height: 6.h,
              ),
              customButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  buttonName: 'User',
                  color: Colors.cyan),
              SizedBox(
                height: 2.h,
              ),
              customButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/vendorLogin');
                  },
                  buttonName: 'Vendor',
                  color: Colors.cyan),
            ],
          ),
        ),
      ),
    );
  }

  logo() {
    return CircleAvatar(
      backgroundColor: Colors.cyan,
      radius: 16.w,
      child: FittedBox(
        child: Text(
          'CRAFTI-HUB',
          style: TextStyle(
              fontSize: 19, color: Colors.white, fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}
