import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/experience_model.dart';
import '../../../constants/routes.dart';

class ExperienceController extends GetxController {
  final formKey = GlobalKey<FormState>();

  // Observable variables
  final RxList<Experience> experienceList = <Experience>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Add first experience entry by default
    addExperience();
  }

  // Computed property to check if form is complete
  bool get isFormComplete {
    return experienceList.isNotEmpty &&
        experienceList.every((experience) => experience.isValid);
  }

  // Check if can add more experience
  bool get canAddMore {
    return experienceList.length < 5; // Limit to 5 experiences
  }

  // Add new experience entry
  void addExperience() {
    if (canAddMore) {
      experienceList.add(Experience());
    }
  }

  // Remove experience entry
  void removeExperience(int index) {
    if (experienceList.length > 1) {
      experienceList.removeAt(index);
    }
  }

  // Update experience entry
  void updateExperience(int index, Experience experience) {
    if (index < experienceList.length) {
      experienceList[index] = experience;
    }
  }

  // Validation functions
  String? validateTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Job title is required';
    }
    if (value.trim().length < 2) {
      return 'Job title must be at least 2 characters';
    }
    if (value.trim().length > 100) {
      return 'Job title is too long (max 100 characters)';
    }
    return null;
  }

  String? validateCompanyName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Company name is required';
    }
    if (value.trim().length < 2) {
      return 'Company name must be at least 2 characters';
    }
    if (value.trim().length > 100) {
      return 'Company name is too long (max 100 characters)';
    }
    return null;
  }

  String? validateMonth(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Month is required';
    }
    return null;
  }

  String? validateYear(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Year is required';
    }

    int? year = int.tryParse(value.trim());
    if (year == null) {
      return 'Please enter a valid year';
    }

    int currentYear = DateTime.now().year;
    if (year < 1950 || year > currentYear + 10) {
      return 'Year must be between 1950 and ${currentYear + 10}';
    }

    return null;
  }

  String? validateEndDate(String? endMonth, String? endYear, String? startMonth,
      String? startYear) {
    if (endMonth == null ||
        endMonth.isEmpty ||
        endYear == null ||
        endYear.isEmpty) {
      return 'End date is required';
    }

    if (startMonth == null ||
        startMonth.isEmpty ||
        startYear == null ||
        startYear.isEmpty) {
      return 'Start date is required';
    }

    // Check if end date is after start date
    int? startYearInt = int.tryParse(startYear.trim());
    int? endYearInt = int.tryParse(endYear.trim());

    if (startYearInt != null && endYearInt != null) {
      if (endYearInt < startYearInt) {
        return 'End date must be after start date';
      }
      if (endYearInt == startYearInt) {
        // Check months if same year
        List<String> months = [
          'January',
          'February',
          'March',
          'April',
          'May',
          'June',
          'July',
          'August',
          'September',
          'October',
          'November',
          'December'
        ];
        int startMonthIndex = months.indexOf(startMonth);
        int endMonthIndex = months.indexOf(endMonth);

        if (startMonthIndex != -1 &&
            endMonthIndex != -1 &&
            endMonthIndex < startMonthIndex) {
          return 'End date must be after start date';
        }
      }
    }

    return null;
  }

  String? validateDescription(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Description is required';
    }
    if (value.trim().length < 10) {
      return 'Description must be at least 10 characters';
    }
    if (value.trim().length > 500) {
      return 'Description is too long (max 500 characters)';
    }
    return null;
  }

  // Save experience details
  Future<void> saveExperience() async {
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
        'Experience details saved successfully! Moving to next step...',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );

      // TODO: Navigate to next screen (projects or other sections)
      // Get.toNamed(Routes.projects);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to save experience details',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
