import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const String _userId = 'user_id';
  static const String _userType = 'user_type';

  /// Save user in SharedPreferences
  static Future<void> saveUser(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_userId, userId);
  }

  /// Get user
  static Future<int?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt(_userId);
    if (userId == null) return null;
    return userId;
  }

  /// Remove user  (logout)
  static Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userType);
  }

  /// Save  User Or Vendor Logged
  static Future<void> saveUserType(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userType, userId);
  }

  /// Get User Or Vendor Logged
  static Future<String?> getUserType() async {
    final prefs = await SharedPreferences.getInstance();
    String? userType = prefs.getString(_userType);
    if (userType == null) return null;
    return userType;
  }

  /// Remove User Or Vendor Logged  (logout)
  static Future<void> clearUserType() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userType);
  }
}
