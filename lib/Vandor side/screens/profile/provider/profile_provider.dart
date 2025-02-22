import 'package:crafti_hub/Vandor%20side/common/flush_bar.dart';
import 'package:crafti_hub/local_storage.dart';
import 'package:crafti_hub/Vandor%20side/screens/profile/model/user_model.dart';
import 'package:crafti_hub/Vandor%20side/screens/profile/profile_repository.dart';
import 'package:flutter/material.dart';

class VendorProfileProvider extends ChangeNotifier {
  UserModel? user;
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
}
