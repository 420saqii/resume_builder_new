import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import '../../../constants/routes.dart';
import '../../../models/user_model.dart';
import '../../../services/storage_service.dart';
import '../../../utils/snackbar_utils.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final RxBool isLoading = false.obs;
  final Rx<UserModel?> currentUser = Rx<UserModel?>(null);

  @override
  void onInit() {
    super.onInit();
    // Check if user is already logged in
    checkLoginStatus();
  }

  // Check if user is already logged in
  void checkLoginStatus() {
    final user = StorageService.getUser();
    if (user != null && StorageService.isLoggedIn()) {
      currentUser.value = user;
    }
  }

  // Sign in with Google
  Future<void> signInWithGoogle() async {
    try {
      isLoading.value = true;

      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // User cancelled the sign-in
        isLoading.value = false;
        return;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the credential
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        // Create user model from Firebase user
        final userModel = UserModel.fromFirebaseUser(user);

        // Save user data to local storage
        await StorageService.saveUser(userModel);

        // Update current user
        currentUser.value = userModel;

        // Navigate to home screen
        Get.offAllNamed(Routes.home);

        SnackbarUtils.showSuccess(
          title: 'Success',
          message: 'Welcome ${userModel.displayName ?? 'User'}!',
        );
      }
    } catch (e) {
      print('Error signing in with Google: $e');
      SnackbarUtils.showError(
        title: 'Error',
        message: 'Failed to sign in with Google. Please try again.',
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      isLoading.value = true;

      // Sign out from Firebase
      await _auth.signOut();

      // Sign out from Google
      await _googleSignIn.signOut();

      // Clear local storage
      await StorageService.clearAll();

      // Clear current user
      currentUser.value = null;

      // Navigate to auth screen
      Get.offAllNamed(Routes.auth);

      SnackbarUtils.showSuccess(
        title: 'Success',
        message: 'Signed out successfully',
      );
    } catch (e) {
      print('Error signing out: $e');
      SnackbarUtils.showError(
        title: 'Error',
        message: 'Failed to sign out. Please try again.',
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Update user profile
  Future<void> updateUserProfile({
    String? displayName,
    String? gender,
    String? phoneNumber,
  }) async {
    try {
      final currentUserData = currentUser.value;
      if (currentUserData != null) {
        final updatedUser = currentUserData.copyWith(
          displayName: displayName,
          gender: gender,
          phoneNumber: phoneNumber,
        );

        await StorageService.saveUser(updatedUser);
        currentUser.value = updatedUser;

        SnackbarUtils.showSuccess(
          title: 'Success',
          message: 'Profile updated successfully',
        );
      }
    } catch (e) {
      print('Error updating profile: $e');
      SnackbarUtils.showError(
        title: 'Error',
        message: 'Failed to update profile. Please try again.',
      );
    }
  }

  // Get current user
  UserModel? get user => currentUser.value;

  // Check if user is logged in
  bool get isLoggedIn => currentUser.value != null;
}
