import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/current_info_model.dart';
import '../../../constants/routes.dart';
import '../../../services/storage_service.dart';

class CurrentInfoController extends GetxController {
  final formKey = GlobalKey<FormState>();

  // Text controllers
  final TextEditingController designationController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController referenceController = TextEditingController();

  // Observable variables
  final RxString designation = ''.obs;
  final RxString description = ''.obs;
  final RxString reference = ''.obs;
  final RxBool isLoading = false.obs;

  // Computed property to check if form is complete
  bool get isFormComplete {
    return designation.value.trim().isNotEmpty &&
        description.value.trim().isNotEmpty;
  }

  // Validation functions
  String? validateDesignation(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Current designation is required';
    }
    if (value.trim().length < 3) {
      return 'Designation must be at least 3 characters';
    }
    if (value.trim().length > 50) {
      return 'Designation is too long (max 50 characters)';
    }
    return null;
  }

  String? validateDescription(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Description is required';
    }
    if (value.trim().length < 20) {
      return 'Description must be at least 20 characters';
    }
    if (value.trim().length > 300) {
      return 'Description is too long (max 300 characters)';
    }
    return null;
  }

  String? validateReference(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // Reference is optional
    }
    if (value.trim().length < 10) {
      return 'Reference must be at least 10 characters';
    }
    if (value.trim().length > 200) {
      return 'Reference is too long (max 200 characters)';
    }
    return null;
  }

  Future<void> saveCurrentInfo() async {
    if (!isFormComplete) {
      Get.snackbar(
        'Error',
        'Please complete all required fields',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;

      // Create CurrentInfo object
      final currentInfo = CurrentInfo(
        designation: designation.value.trim(),
        description: description.value.trim(),
        reference: reference.value.trim(),
      );

      // Save current info to storage
      await StorageService.updateResumeSection('currentInfo', currentInfo);

      Get.snackbar(
        'Success',
        'Current information saved successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // Navigate to resume preview screen
      Get.toNamed(Routes.resumePreview);
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred while saving',
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
    designationController.dispose();
    descriptionController.dispose();
    referenceController.dispose();
    super.onClose();
  }
}
