import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../constants/colors.dart';
import '../controller/education_controller.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../models/education_model.dart';

class EducationScreen extends StatelessWidget {
  const EducationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final EducationController controller = Get.put(EducationController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Education Details',
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
            : Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(16.w),
                      child: Form(
                        key: controller.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header
                            Text(
                              'Tell us about your education',
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryText,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'Add your educational background to your resume',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: AppColors.secondaryText,
                              ),
                            ),
                            SizedBox(height: 32.h),

                            // Education Entries
                            ...controller.educationList
                                .asMap()
                                .entries
                                .map((entry) {
                              int index = entry.key;
                              Education education = entry.value;
                              return _buildEducationEntry(
                                  controller, index, education);
                            }).toList(),

                            SizedBox(height: 20.h),

                            // Add More Button
                            if (controller.canAddMore)
                              SizedBox(
                                width: double.infinity,
                                child: OutlinedButton.icon(
                                  onPressed: controller.addEducation,
                                  icon: Icon(Icons.add, size: 20.sp),
                                  label: Text('Add More Education'),
                                  style: OutlinedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 24.w,
                                      vertical: 12.h,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    side: BorderSide(
                                        color: AppColors.primaryBlue),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Save Button at bottom
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.shadow.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, -2),
                        ),
                      ],
                    ),
                    child: Column(
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
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                Text(
                                  '• At least one education entry with all fields filled',
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
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: controller.isFormComplete
                                  ? [
                                      AppColors.primaryBlue,
                                      AppColors.secondaryBlue,
                                    ]
                                  : [
                                      AppColors.primaryBorder,
                                      AppColors.primaryBorder,
                                    ],
                            ),
                            borderRadius: BorderRadius.circular(16.r),
                            boxShadow: controller.isFormComplete
                                ? [
                                    BoxShadow(
                                      color: AppColors.primaryBlue
                                          .withOpacity(0.3),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    ),
                                  ]
                                : null,
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: controller.isFormComplete
                                  ? controller.saveEducation
                                  : null,
                              borderRadius: BorderRadius.circular(16.r),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 24.w,
                                  vertical: 16.h,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.check_circle_outline,
                                      color: controller.isFormComplete
                                          ? AppColors.white
                                          : AppColors.secondaryText,
                                      size: 20.sp,
                                    ),
                                    SizedBox(width: 12.w),
                                    Text(
                                      'Save & Continue',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: controller.isFormComplete
                                            ? AppColors.white
                                            : AppColors.secondaryText,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
      ),
    );
  }

  Widget _buildEducationEntry(
      EducationController controller, int index, Education education) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.primaryBorder,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with remove button
          Row(
            children: [
              Text(
                'Education ${index + 1}',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryText,
                ),
              ),
              Spacer(),
              if (controller.educationList.length > 1)
                IconButton(
                  onPressed: () => controller.removeEducation(index),
                  icon: Icon(
                    Icons.delete_outline,
                    size: 20.sp,
                    color: AppColors.error,
                  ),
                ),
            ],
          ),
          SizedBox(height: 16.h),

          // Degree Field
          CustomTextField(
            label: 'Degree/Course',
            hint: 'e.g., Bachelor of Computer Science',
            isRequired: true,
            validator: controller.validateDegree,
            prefixIcon: Icon(
              Icons.school,
              size: 20.sp,
              color: AppColors.primaryBlue,
            ),
            onChanged: (value) {
              education.degree = value;
              controller.updateEducation(index, education);
            },
          ),
          SizedBox(height: 16.h),

          // Institution Field
          CustomTextField(
            label: 'Institution',
            hint: 'e.g., University of Technology',
            isRequired: true,
            validator: controller.validateInstitution,
            prefixIcon: Icon(
              Icons.business,
              size: 20.sp,
              color: AppColors.primaryBlue,
            ),
            onChanged: (value) {
              education.institution = value;
              controller.updateEducation(index, education);
            },
          ),
          SizedBox(height: 16.h),

          // Year Fields Row
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  label: 'Start Year',
                  hint: 'e.g., 2020',
                  keyboardType: TextInputType.number,
                  isRequired: true,
                  validator: controller.validateStartYear,
                  prefixIcon: Icon(
                    Icons.calendar_today,
                    size: 20.sp,
                    color: AppColors.primaryBlue,
                  ),
                  onChanged: (value) {
                    education.startYear = value;
                    controller.updateEducation(index, education);
                  },
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: CustomTextField(
                  label: 'End Year',
                  hint: 'e.g., 2024',
                  keyboardType: TextInputType.number,
                  isRequired: true,
                  validator: (value) =>
                      controller.validateEndYear(value, education.startYear),
                  prefixIcon: Icon(
                    Icons.calendar_today,
                    size: 20.sp,
                    color: AppColors.primaryBlue,
                  ),
                  onChanged: (value) {
                    education.endYear = value;
                    controller.updateEducation(index, education);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
