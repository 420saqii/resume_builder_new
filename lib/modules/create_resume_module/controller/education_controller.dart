import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/education_model.dart';
import '../../../constants/routes.dart';

class EducationController extends GetxController {
  final formKey = GlobalKey<FormState>();

  // Observable variables
  final RxList<Education> educationList = <Education>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Add first education entry by default
    addEducation();
  }

  // Computed property to check if form is complete
  bool get isFormComplete {
    return educationList.isNotEmpty &&
        educationList.every((education) => education.isValid);
  }

  // Check if can add more education
  bool get canAddMore {
    return educationList.length < 3;
  }

  // Add new education entry
  void addEducation() {
    if (canAddMore) {
      educationList.add(Education());
    }
  }

  // Remove education entry
  void removeEducation(int index) {
    if (educationList.length > 1) {
      educationList.removeAt(index);
    }
  }

  // Update education entry
  void updateEducation(int index, Education education) {
    if (index < educationList.length) {
      educationList[index] = education;
    }
  }

  // Validation functions
  String? validateDegree(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Degree is required';
    }
    if (value.trim().length < 3) {
      return 'Degree must be at least 3 characters';
    }
    return null;
  }

  String? validateInstitution(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Institution is required';
    }
    if (value.trim().length < 3) {
      return 'Institution must be at least 3 characters';
    }
    return null;
  }

  String? validateStartYear(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Start year is required';
    }

    int? year = int.tryParse(value.trim());
    if (year == null) {
      return 'Please enter a valid year';
    }

    int currentYear = DateTime.now().year;
    if (year < 1950 || year > currentYear) {
      return 'Start year must be between 1950 and $currentYear';
    }

    return null;
  }

  String? validateEndYear(String? value, String? startYear) {
    if (value == null || value.trim().isEmpty) {
      return 'End year is required';
    }

    int? year = int.tryParse(value.trim());
    if (year == null) {
      return 'Please enter a valid year';
    }

    int currentYear = DateTime.now().year;
    if (year < 1950 || year > currentYear + 10) {
      return 'End year must be between 1950 and ${currentYear + 10}';
    }

    // Check if end year is after start year
    if (startYear != null && startYear.isNotEmpty) {
      int? startYearInt = int.tryParse(startYear.trim());
      if (startYearInt != null && year < startYearInt) {
        return 'End year must be after start year';
      }
    }

    return null;
  }

  // Save education details
  Future<void> saveEducation() async {
    if (!isFormComplete) {
      Get.snackbar(
        'Validation Error',
        'Please fill in all required fields correctly',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;

    try {
      // TODO: Save to storage or send to next screen
      Get.snackbar(
        'Success',
        'Education details saved successfully! Moving to next step...',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to save education details',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      isLoading.value = false;
      return;
    } finally {
      isLoading.value = false;
    }

    // Navigate to skills screen (outside try-catch to avoid navigation errors)
    try {
      Get.toNamed(Routes.skills);
    } catch (e) {
      print('Navigation error: $e');
      Get.snackbar(
        'Navigation Error',
        'Failed to navigate to skills screen',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
