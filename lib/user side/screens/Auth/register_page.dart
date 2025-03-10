import 'package:crafti_hub/user%20side/common/flush_bar.dart';
import 'package:crafti_hub/user%20side/screens/Auth/auth_provider.dart';
import 'package:crafti_hub/user%20side/common/button.dart';
import 'package:crafti_hub/user%20side/common/crafti_hub_logo.dart';
import 'package:crafti_hub/user%20side/common/form_field_features.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final space = SizedBox(
      height: 1.5.h,
    );

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10.h),
              craftiHubLogo(),
              SizedBox(height: 6.h),
              TextFormField(
                enabled: !authProvider.showRegisterOtpField,
                validator: emptyCheckValidator,
                controller: authProvider.tcName,
                decoration: textFormFieldDecoration(
                    hinttext: 'Name', prefixIcon: Icons.person_2_outlined),
              ),
              space,
              TextFormField(
                enabled: !authProvider.showRegisterOtpField,
                validator: emailValidator,
                controller: authProvider.tcEmail,
                decoration: textFormFieldDecoration(
                    hinttext: 'Email', prefixIcon: Icons.email_outlined),
              ),
              if (authProvider.showRegisterOtpField) ...[
                SizedBox(height: 1.5.h),
                TextFormField(
                  validator: emptyCheckValidator,
                  controller: authProvider.tcOtp,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(6),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  keyboardType: TextInputType.number,
                  decoration: textFormFieldDecoration(
                      hinttext: 'OTP', prefixIcon: Icons.person_2_outlined),
                ),
              ],
              SizedBox(height: 3.5.h),
              customButton(
                isLoading: authProvider.isLoading,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (authProvider.tcEmail.text.isEmpty ||
                        authProvider.tcName.text.isEmpty) {
                      showFlushbar(
                        context: context,
                        color: Colors.red,
                        icon: Icons.error,
                        message: 'Fill All Fields',
                      );
                    } else if (!authProvider.showRegisterOtpField) {
                      // If OTP field is not shown, proceed with Register
                      final data = {
                        'username': authProvider.tcName.text,
                        'email': authProvider.tcEmail.text
                      };
                      authProvider.userRegister(data, context);
                    } else {
                      // If OTP field is shown, verify Register With OTP
                      if (authProvider.tcOtp.text.isEmpty ||
                          authProvider.tcOtp.text.length < 6) {
                        showFlushbar(
                          context: context,
                          color: Colors.red,
                          icon: Icons.error,
                          message: 'Enter 6 digit OTP',
                        );
                      } else {
                        final data = {
                          'email': authProvider.tcEmail.text,
                          'otp': authProvider.tcOtp.text
                        };
                        authProvider.verifyRegisterOtp(data, context);
                      }
                    }
                  }
                },
                buttonName: 'Register',
                color: Colors.brown,
              ),
              space,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?"),
                  TextButton(
                    onPressed: () {
                      authProvider.resetRegister();
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.brown),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
