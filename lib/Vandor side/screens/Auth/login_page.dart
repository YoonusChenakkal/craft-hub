import 'package:crafti_hub/Vandor%20side/common/button.dart';
import 'package:crafti_hub/Vandor%20side/common/flush_bar.dart';
import 'package:crafti_hub/Vandor%20side/common/form_field_features.dart';
import 'package:crafti_hub/Vandor%20side/screens/Auth/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class VendorLoginPage extends StatelessWidget {
  const VendorLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<VendorAuthProvider>(context);
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              logo(),
              SizedBox(
                height: 6.h,
              ),
              TextFormField(
                validator: emailValidator,
                enabled: !authProvider.showOtpField,
                controller: authProvider.tcLoginEmail,
                decoration: textFormFieldDecoration(
                    hinttext: 'Email', prefixIcon: Icons.email_outlined),
              ),
              if (authProvider.showOtpField) ...[
                SizedBox(
                  height: 1.5.h,
                ),
                TextFormField(
                  validator: emptyCheckValidator,
                  controller: authProvider.tcLoginOtp,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(6),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  keyboardType: TextInputType.number,
                  decoration: textFormFieldDecoration(
                      hinttext: 'OTP', prefixIcon: Icons.person_2_outlined),
                ),
              ],
              SizedBox(
                height: 3.5.h,
              ),
              customButton(
                  isLoading: authProvider.isLoading,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (authProvider.tcLoginEmail.text.isEmpty) {
                        showFlushbar(
                          context: context,
                          color: Color.fromARGB(255, 129, 63, 42),
                          icon: Icons.error,
                          message: 'Enter email',
                        );
                      } else if (!authProvider.showOtpField) {
                        // If OTP field is not shown, proceed with email login
                        final data = {'email': authProvider.tcLoginEmail.text};
                        authProvider.loginVendor(data, context);
                      } else {
                        // If OTP field is shown, verify OTP
                        if (authProvider.tcLoginOtp.text.isEmpty ||
                            authProvider.tcLoginOtp.text.length < 6) {
                          showFlushbar(
                            context: context,
                            color: Colors.red,
                            icon: Icons.error,
                            message: 'Enter 6 digit OTP',
                          );
                        } else {
                          final data = {
                            'email': authProvider.tcLoginEmail.text,
                            'otp': authProvider.tcLoginOtp.text
                          };
                          authProvider.loginOtpVerify(data, context);
                        }
                      }
                    }
                  },
                  buttonName: 'Login',
                  color: Color.fromARGB(255, 129, 63, 42),),
              SizedBox(
                height: 1.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an Vendor account?",
                  ),
                  TextButton(
                      onPressed: () {
                        authProvider.resetLogin();
                        Navigator.pushReplacementNamed(
                            context, '/vendorRegister');
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(color: Color.fromARGB(255, 129, 63, 42),),
                      ))
                ],
              )
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
