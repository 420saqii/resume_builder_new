import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/language_model.dart';
import '../../../constants/routes.dart';
import '../../../services/storage_service.dart';

class LanguageController extends GetxController {
  final formKey = GlobalKey<FormState>();

  // Observable variables
  final RxList<Language> languageList = <Language>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Add first language entry by default
    addLanguage();
  }

  // Computed property to check if form is complete
  bool get isFormComplete {
    return languageList.isNotEmpty &&
        languageList.every((language) => language.isValid);
  }

  // Check if can add more languages
  bool get canAddMore {
    return languageList.length < 10; // Limit to 10 languages
  }

  // Add new language entry
  void addLanguage() {
    if (canAddMore) {
      languageList.add(Language());
    }
  }

  // Remove language entry
  void removeLanguage(int index) {
    if (languageList.length > 1) {
      languageList.removeAt(index);
    }
  }

  // Update language entry
  void updateLanguage(int index, Language language) {
    if (index < languageList.length) {
      languageList[index] = language;
    }
  }

  // Validation functions
  String? validateLanguageName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Language name is required';
    }
    if (value.trim().length < 2) {
      return 'Language name must be at least 2 characters';
    }
    if (value.trim().length > 50) {
      return 'Language name is too long (max 50 characters)';
    }

    // Check for duplicate languages
    String trimmedValue = value.trim().toLowerCase();
    int count = 0;
    for (Language lang in languageList) {
      if (lang.languageName?.toLowerCase() == trimmedValue) {
        count++;
      }
    }
    if (count > 1) {
      return 'This language is already added';
    }

    return null;
  }

  String? validateProficiencyLevel(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Proficiency level is required';
    }

    int? level = int.tryParse(value.trim());
    if (level == null) {
      return 'Please enter a valid number';
    }

    if (level < 1 || level > 100) {
      return 'Proficiency level must be between 1 and 100';
    }

    return null;
  }

  // Save languages details
  Future<void> saveLanguages() async {
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
      // Save language list to storage
      await StorageService.updateResumeSection('languageList', languageList);

      Get.snackbar(
        'Success',
        'Languages saved successfully! Moving to next step...',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );

      // Navigate to current info screen
      Get.toNamed(Routes.currentInfo);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to save languages',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
