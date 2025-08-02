import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../../constants/colors.dart';
import '../controller/personal_details_controller.dart';
import '../../../widgets/custom_text_field.dart';

class PersonalDetailsScreen extends StatelessWidget {
  const PersonalDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PersonalDetailsController controller =
        Get.put(PersonalDetailsController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Personal Details',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 20.sp),
          onPressed: () => Get.back(),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          // Dismiss keyboard when tapping outside
          FocusScope.of(context).unfocus();
        },
        child: Obx(() => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: EdgeInsets.all(16.w),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Profile Image Section
                      Center(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () => _showImagePickerDialog(controller),
                              child: Container(
                                width: 120.w,
                                height: 120.h,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.primaryBlue,
                                    width: 3,
                                  ),
                                  color: AppColors.secondaryBackground,
                                ),
                                child: CircleAvatar(
                                  child:
                                      controller.profileImagePath.value.isNotEmpty
                                          ? ClipRRect(
                                        borderRadius: BorderRadius.circular(168),
                                            child: Image.file(
                                              File(controller
                                                  .profileImagePath.value),
                                              fit: BoxFit.cover,
                                              height: 100.h,
                                              width: 120.w,
                                            ),
                                          )
                                          : Icon(
                                              Icons.person_add,
                                              size: 48.sp,
                                              color: AppColors.primaryBlue,
                                            ),
                                ),
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Tap to add profile photo',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: AppColors.secondaryText,
                                  ),
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  '*',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: AppColors.error,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 32.h),

                      // Form Fields
                      CustomTextField(
                        label: 'Full Name',
                        hint: 'Enter your full name',
                        controller: controller.fullNameController,
                        isRequired: true,
                        validator: controller.validateFullName,
                        prefixIcon: Icon(
                          Icons.person,
                          size: 20.sp,
                          color: AppColors.primaryBlue,
                        ),
                        onChanged: (value) {
                          controller.fullName.value = value;
                        },
                      ),
                      SizedBox(height: 20.h),

                      CustomTextField(
                        label: 'Email',
                        hint: 'Enter your email address',
                        controller: controller.emailController,
                        keyboardType: TextInputType.emailAddress,
                        isRequired: true,
                        validator: controller.validateEmail,
                        prefixIcon: Icon(
                          Icons.email,
                          size: 20.sp,
                          color: AppColors.primaryBlue,
                        ),
                        onChanged: (value) {
                          controller.email.value = value;
                        },
                      ),
                      SizedBox(height: 20.h),

                      CustomTextField(
                        label: 'Phone Number',
                        hint: 'Enter your phone number (e.g., +1 555-123-4567)',
                        controller: controller.phoneController,
                        keyboardType: TextInputType.phone,
                        validator: controller.validatePhone,
                        prefixIcon: Icon(
                          Icons.phone,
                          size: 20.sp,
                          color: AppColors.primaryBlue,
                        ),
                      ),
                      SizedBox(height: 20.h),

                      CustomTextField(
                        label: 'Address',
                        hint:
                            'Enter your complete address (e.g., 123 Main Street, City, State 12345)',
                        controller: controller.addressController,
                        maxLines: 3,
                        validator: controller.validateAddress,
                        textAlign: TextAlign.start,
                        prefixIcon: Icon(
                          Icons.location_on,
                          size: 20.sp,
                          color: AppColors.primaryBlue,
                        ),
                      ),
                      SizedBox(height: 32.h),

                      // Save Button
                      Obx(() => Column(
                            children: [
                              // Show what's missing when button is disabled
                              if (!controller.isFormComplete) ...[
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(12.w),
                                  decoration: BoxDecoration(
                                    color: AppColors.secondaryBackground,
                                    borderRadius: BorderRadius.circular(8.r),
                                    border: Border.all(
                                      color: AppColors.primaryBorder,
                                      width: 1,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Complete the following to continue:',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.primaryText,
                                        ),
                                      ),
                                      SizedBox(height: 8.h),
                                      if (controller.fullName.value
                                          .trim()
                                          .isEmpty)
                                        Text(
                                          '• Full Name is required',
                                          style: TextStyle(
                                            fontSize: 11.sp,
                                            color: AppColors.error,
                                          ),
                                        ),
                                      if (controller.email.value.trim().isEmpty)
                                        Text(
                                          '• Email is required',
                                          style: TextStyle(
                                            fontSize: 11.sp,
                                            color: AppColors.error,
                                          ),
                                        ),
                                      if (controller
                                          .profileImagePath.value.isEmpty)
                                        Text(
                                          '• Profile Photo is required',
                                          style: TextStyle(
                                            fontSize: 11.sp,
                                            color: AppColors.error,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 16.h),
                              ],
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: controller.isFormComplete
                                      ? controller.savePersonalDetails
                                      : null,
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 24.w,
                                      vertical: 16.h,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    backgroundColor: controller.isFormComplete
                                        ? AppColors.primaryBlue
                                        : AppColors.primaryBorder,
                                  ),
                                  child: Text(
                                    'Save & Continue',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      color: controller.isFormComplete
                                          ? AppColors.white
                                          : AppColors.secondaryText,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              )),
      ),
    );
  }

  void _showImagePickerDialog(PersonalDetailsController controller) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: AppColors.primaryBorder,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'Choose Profile Photo',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryText,
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Get.back();
                      _pickImage(controller, ImageSource.camera);
                    },
                    icon: Icon(Icons.camera_alt, size: 20.sp),
                    label: Text('Camera'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Get.back();
                      _pickImage(controller, ImageSource.gallery);
                    },
                    icon: Icon(Icons.photo_library, size: 20.sp),
                    label: Text('Gallery'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            if (controller.profileImagePath.value.isNotEmpty)
              SizedBox(
                width: double.infinity,
                child: TextButton.icon(
                  onPressed: () {
                    Get.back();
                    controller.clearProfileImage();
                  },
                  icon: Icon(Icons.delete, size: 20.sp, color: AppColors.error),
                  label: Text(
                    'Remove Photo',
                    style: TextStyle(color: AppColors.error),
                  ),
                ),
              ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(
      PersonalDetailsController controller, ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: source,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 80,
      );

      if (image != null) {
        controller.setProfileImage(image.path);
        Get.snackbar(
          'Success',
          'Profile photo added successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      String errorMessage = 'Failed to pick image';

      // Handle specific permission errors
      if (e.toString().contains('permission')) {
        errorMessage =
            'Camera/Photo permission denied. Please enable permissions in settings.';
      } else if (e.toString().contains('camera')) {
        errorMessage = 'Camera not available or permission denied.';
      } else if (e.toString().contains('gallery')) {
        errorMessage =
            'Photo library access denied. Please enable permissions in settings.';
      }

      Get.snackbar(
        'Error',
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
      );
    }
  }
}
