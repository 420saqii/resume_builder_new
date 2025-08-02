import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/skill_model.dart';

class SkillsController extends GetxController {
  final formKey = GlobalKey<FormState>();

  // Observable variables
  final RxList<Skill> skillsList = <Skill>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Add first skill entry by default
    addSkill();
  }

  // Computed property to check if form is complete
  bool get isFormComplete {
    return skillsList.isNotEmpty && skillsList.every((skill) => skill.isValid);
  }

  // Check if can add more skills
  bool get canAddMore {
    return skillsList.length < 6;
  }

  // Add new skill entry
  void addSkill() {
    if (canAddMore) {
      skillsList.add(Skill());
    }
  }

  // Remove skill entry
  void removeSkill(int index) {
    if (skillsList.length > 1) {
      skillsList.removeAt(index);
    }
  }

  // Update skill entry
  void updateSkill(int index, Skill skill) {
    if (index < skillsList.length) {
      skillsList[index] = skill;
    }
  }

  // Validation functions
  String? validateSkillName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Skill name is required';
    }
    if (value.trim().length < 2) {
      return 'Skill name must be at least 2 characters';
    }
    if (value.trim().length > 50) {
      return 'Skill name is too long (max 50 characters)';
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

  // Save skills details
  Future<void> saveSkills() async {
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
        'Skills saved successfully! Moving to next step...',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );

      // TODO: Navigate to next screen (experience details)
      // Get.toNamed(Routes.experienceDetails);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to save skills',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
