import 'package:crafti_hub/user%20side/common/flush_bar.dart';
import 'package:crafti_hub/local_storage.dart';
import 'package:crafti_hub/user%20side/screens/profile/profile_repository.dart';
import 'package:crafti_hub/user%20side/screens/profile/user_model.dart';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  UserModel? user;
  List<UserAddress> userAddress = [];
  bool _isLoading = false;

  get isLoading => _isLoading;

  set isLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  final _profileRepo = ProfileRepository();

  fetchUser(BuildContext context) async {
    isLoading = true;
    int? userId = await LocalStorage.getUser();
    print(userId);
    try {
      final response = await _profileRepo.fetchUser(userId);

      user = UserModel.fromJson(response.data);

      print('Sucess User Fetch');
      notifyListeners();
    } on Exception catch (e) {
      // Display the parsed error message
      showFlushbar(
        context: context,
        color: Colors.red,
        icon: Icons.error,
        message: 'Fetching User Failed', // Clean up message
      );
      print("❌ Registration failed: $e");
    } finally {
      isLoading = false;
    }
  }

  // add address
  Future addAddress(BuildContext context, Map<String, dynamic> data) async {
    isLoading = true;
    try {
      await _profileRepo.addAddress(data);
      Navigator.pop(context);
      await showFlushbar(
        context: context,
        color: Colors.green,
        icon: Icons.check,
        message: 'Adding Address Success',
      );

      fetchUser(context);
      notifyListeners();
    } on Exception catch (e) {
      showFlushbar(
        context: context,
        color: Colors.red,
        icon: Icons.error,
        message: 'Adding Address Failed',
      );
      print("❌ Adding Address failed: $e");
    } finally {
      isLoading = false;
    }
  }
}
