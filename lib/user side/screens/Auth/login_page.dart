import 'package:crafti_hub/user%20side/common/crafti_hub_logo.dart';
import 'package:crafti_hub/user%20side/screens/Auth/auth_provider.dart';
import 'package:crafti_hub/user%20side/common/button.dart';
import 'package:crafti_hub/user%20side/common/flush_bar.dart';
import 'package:crafti_hub/user%20side/common/form_field_features.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              craftiHubLogo(),
              SizedBox(
                height: 6.h,
              ),
              TextFormField(
                validator: emailValidator,
                enabled: !authProvider.showLoginOtpField,
                controller: authProvider.tcLoginEmail,
                decoration: textFormFieldDecoration(
                    hinttext: 'Email', prefixIcon: Icons.email_outlined),
              ),
              if (authProvider.showLoginOtpField) ...[
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
                          color: Colors.red,
                          icon: Icons.error,
                          message: 'Enter email',
                        );
                      } else if (!authProvider.showLoginOtpField) {
                        // If OTP field is not shown, proceed with email login
                        final data = {'email': authProvider.tcLoginEmail.text};
                        authProvider.loginUser(data, context);
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
                  color: Colors.brown),
              SizedBox(
                height: 1.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                  ),
                  TextButton(
                      onPressed: () {
                        authProvider.resetLogin();
                        Navigator.pushReplacementNamed(context, '/register');
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(color: Colors.brown),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
