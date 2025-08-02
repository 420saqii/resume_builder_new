import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/personal_details_model.dart';
import '../../../constants/routes.dart';
import '../../../services/storage_service.dart';

class PersonalDetailsController extends GetxController {
  final formKey = GlobalKey<FormState>();

  // Text controllers
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  // Observable variables
  final RxString profileImagePath = ''.obs;
  final RxBool isLoading = false.obs;
  final RxString fullName = ''.obs;
  final RxString email = ''.obs;

  // Computed property to check if form is complete
  bool get isFormComplete {
    return fullName.value.trim().isNotEmpty &&
        email.value.trim().isNotEmpty &&
        profileImagePath.value.isNotEmpty;
  }

  // Validation functions
  String? validateFullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Full name is required';
    }
    if (value.trim().length < 2) {
      return 'Full name must be at least 2 characters';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    if (!GetUtils.isEmail(value.trim())) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // Phone is optional
    }

    // Remove all non-digit characters for validation
    String cleanPhone = value.replaceAll(RegExp(r'[^\d]'), '');

    if (cleanPhone.length < 10) {
      return 'Phone number must be at least 10 digits';
    }
    if (cleanPhone.length > 15) {
      return 'Phone number is too long';
    }

    // Check if it contains only digits and basic symbols
    if (!RegExp(r'^[\d\s\-\+\(\)]+$').hasMatch(value.trim())) {
      return 'Please enter a valid phone number format';
    }

    return null;
  }

  String? validateAddress(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // Address is optional
    }

    String trimmedAddress = value.trim();

    if (trimmedAddress.length < 10) {
      return 'Address must be at least 10 characters';
    }
    if (trimmedAddress.length > 200) {
      return 'Address is too long (max 200 characters)';
    }

    // Check for minimum address components (should have street number/name)
    if (!RegExp(r'\d').hasMatch(trimmedAddress)) {
      return 'Address should include a street number';
    }

    // Check for common address keywords
    List<String> addressKeywords = [
      'street',
      'avenue',
      'road',
      'drive',
      'lane',
      'court',
      'plaza',
      'way',
      'boulevard',
      'highway'
    ];
    bool hasAddressKeyword = addressKeywords
        .any((keyword) => trimmedAddress.toLowerCase().contains(keyword));

    if (!hasAddressKeyword && trimmedAddress.length < 15) {
      return 'Please provide a more detailed address';
    }

    return null;
  }

  // Set profile image
  void setProfileImage(String path) {
    profileImagePath.value = path;
  }

  // Clear profile image
  void clearProfileImage() {
    profileImagePath.value = '';
  }

  // Get personal details object
  PersonalDetails getPersonalDetails() {
    return PersonalDetails(
      fullName: fullNameController.text.trim(),
      email: emailController.text.trim(),
      phone: phoneController.text.trim(),
      address: addressController.text.trim(),
      profileImagePath:
          profileImagePath.value.isNotEmpty ? profileImagePath.value : null,
    );
  }

  // Validate form
  bool validateForm() {
    bool isFormValid = formKey.currentState?.validate() ?? false;

    // Check if profile image is selected
    if (profileImagePath.value.isEmpty) {
      Get.snackbar(
        'Profile Photo Required',
        'Please add a profile photo to continue',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return false;
    }

    return isFormValid;
  }

  // Save personal details
  Future<void> savePersonalDetails() async {
    if (!validateForm()) {
      // Specific validation messages are already shown in validateForm()
      return;
    }

    isLoading.value = true;

    try {
      final personalDetails = getPersonalDetails();

      // Save personal details to storage
      await StorageService.updateResumeSection(
          'personalDetails', personalDetails);

      Get.snackbar(
        'Success',
        'Personal details saved successfully! Moving to next step...',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );

      // Navigate to education screen
      Get.toNamed(Routes.education);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to save personal details',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.onClose();
  }
}
