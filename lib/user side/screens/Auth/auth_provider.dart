import 'package:crafti_hub/user%20side/screens/Auth/Auth_repository.dart';
import 'package:crafti_hub/user%20side/common/flush_bar.dart';
import 'package:crafti_hub/user%20side/const/local_storage.dart';
import 'package:crafti_hub/user%20side/screens/profile/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthProvider extends ChangeNotifier {
  bool showLoginOtpField = false;
  bool showRegisterOtpField = false;

  bool _isLoading = false;
  TextEditingController tcLoginEmail = TextEditingController();
  TextEditingController tcLoginOtp = TextEditingController();

  TextEditingController tcName = TextEditingController();
  TextEditingController tcEmail = TextEditingController();
  TextEditingController tcOtp = TextEditingController();

  get isLoading => _isLoading;

  set isLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  resetLogin() {
    showLoginOtpField = false;
    tcLoginEmail.clear;
    tcLoginOtp.clear;
    notifyListeners();
  }

  resetRegister() {
    showRegisterOtpField = false;
    tcName.clear();
    tcEmail.clear();
    notifyListeners();
  }

  final _authRepo = AuthRepository();

  // Register Vendor ----------->

  userRegister(data, BuildContext context) async {
    isLoading = true;
    try {
      final response = await _authRepo.userRegister(data);
      final message = response.data['message'];
      showRegisterOtpField = true;
      await showFlushbar(
        context: context,
        color: Colors.green,
        icon: Icons.check,
        message: message,
      );
    } catch (e) {
      // Display the parsed error message
      showFlushbar(
        context: context,
        color: Colors.red,
        icon: Icons.error,
        message: e.toString().replaceAll('Exception: ', ''), // Clean up message
      );
      print("❌ Registration failed: $e");
    } finally {
      isLoading = false;
    }
  }
  // verify Register Otp

  verifyRegisterOtp(data, BuildContext context) async {
    isLoading = true;
    try {
      await _authRepo.verifyRegisterOtp(data);

      resetRegister();

      Navigator.pushReplacementNamed(context, '/login');
      await showFlushbar(
        context: context,
        color: Colors.green,
        icon: Icons.check,
        message: 'User Registration Successful ,Login to continue',
      );
    } catch (e) {
      // Display the parsed error message
      showFlushbar(
        context: context,
        color: Colors.red,
        icon: Icons.error,
        message: e.toString().replaceAll('Exception: ', ''), // Clean up message
      );
      print("❌ Registration failed: $e");
    } finally {
      isLoading = false;
    }
  }
  // Login Vendor ------------->

  loginVendor(data, BuildContext context) async {
    isLoading = true;

    try {
      final response = await _authRepo.loginVendor(data);

      final message = response.data['message'];

      await showFlushbar(
        context: context,
        color: Colors.green,
        icon: Icons.check,
        message: message,
      );
      showLoginOtpField = true;
      notifyListeners();
    } catch (e) {
      // Display the parsed error message
      showFlushbar(
        context: context,
        color: Colors.red,
        icon: Icons.error,
        message: e.toString().replaceAll('Exception: ', ''), // Clean up message
      );
      print("❌ Registration failed: $e");
    } finally {
      isLoading = false;
    }
  }
  // login Otp Verify ------------->

  loginOtpVerify(data, BuildContext context) async {
    isLoading = true;
    print('----------------------------------------------------->$data');
    try {
      final response = await _authRepo.loginOtpVerify(data);
      print(response.data);

      if (response.data is Map<String, dynamic>) {
        final message = response.data['message'] ?? 'Login successful!';
        final userId = response.data['user_id'];

        // Save user ID locally
        await LocalStorage.saveUser(userId);

        // Fetch user profile
        await Provider.of<ProfileProvider>(context, listen: false)
            .fetchUser(context);

        // Navigate to the home screen
        Navigator.pushReplacementNamed(context, '/bottomBar');

        // Show a success message
        await showFlushbar(
          context: context,
          color: Colors.green,
          icon: Icons.login,
          message: message,
        );
      }
      resetLogin();
    } on Exception catch (e) {
      // Display the parsed error message
      showFlushbar(
        context: context,
        color: Colors.red,
        icon: Icons.error,
        message: e.toString().replaceAll('Exception: ', ''), // Clean up message
      );
      print("❌ Registration failed: $e");
    } finally {
      isLoading = false;
    }
  }
}
