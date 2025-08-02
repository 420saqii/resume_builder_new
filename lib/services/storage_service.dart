import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import '../models/user_model.dart';

class StorageService {
  static const String _userKey = 'user_data';
  static const String _isLoggedInKey = 'is_logged_in';

  static final GetStorage _storage = GetStorage();

  // Initialize storage
  static Future<void> init() async {
    await GetStorage.init();
  }

  // Save user data
  static Future<void> saveUser(UserModel user) async {
    await _storage.write(_userKey, jsonEncode(user.toJson()));
    await _storage.write(_isLoggedInKey, true);
  }

  // Get user data
  static UserModel? getUser() {
    final userData = _storage.read(_userKey);
    if (userData != null) {
      try {
        final Map<String, dynamic> userMap = jsonDecode(userData);
        return UserModel.fromJson(userMap);
      } catch (e) {
        print('Error parsing user data: $e');
        return null;
      }
    }
    return null;
  }

  // Check if user is logged in
  static bool isLoggedIn() {
    return _storage.read(_isLoggedInKey) ?? false;
  }

  // Clear all data (logout)
  static Future<void> clearAll() async {
    await _storage.remove(_userKey);
    await _storage.remove(_isLoggedInKey);
  }

  // Update specific user field
  static Future<void> updateUserField(String field, dynamic value) async {
    final user = getUser();
    if (user != null) {
      final updatedUser = user.copyWith(
        displayName: field == 'displayName' ? value : user.displayName,
        email: field == 'email' ? value : user.email,
        photoURL: field == 'photoURL' ? value : user.photoURL,
        gender: field == 'gender' ? value : user.gender,
        phoneNumber: field == 'phoneNumber' ? value : user.phoneNumber,
      );
      await saveUser(updatedUser);
    }
  }

  // Get specific user field
  static String? getUserField(String field) {
    final user = getUser();
    if (user != null) {
      switch (field) {
        case 'displayName':
          return user.displayName;
        case 'email':
          return user.email;
        case 'photoURL':
          return user.photoURL;
        case 'gender':
          return user.gender;
        case 'phoneNumber':
          return user.phoneNumber;
        default:
          return null;
      }
    }
    return null;
  }
}
