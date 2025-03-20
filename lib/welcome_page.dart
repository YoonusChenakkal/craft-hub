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
                  color: Color.fromARGB(255, 129, 63, 42),),
              SizedBox(
                height: 2.h,
              ),
              customButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/vendorLogin');
                  },
                  buttonName: 'Vendor',
                  color: Color.fromARGB(255, 129, 63, 42),),
            ],
          ),
        ),
      ),
    );
  }

  logo() {
    return CircleAvatar(
      backgroundColor: Color.fromARGB(255, 129, 63, 42),
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
