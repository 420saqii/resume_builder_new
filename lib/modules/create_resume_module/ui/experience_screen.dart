import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../constants/colors.dart';
import '../controller/experience_controller.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../models/experience_model.dart';

class ExperienceScreen extends StatelessWidget {
  const ExperienceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ExperienceController controller = Get.put(ExperienceController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Work Experience',
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
                              'Your Work Experience',
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryText,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'Add your professional work experience with details',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: AppColors.secondaryText,
                              ),
                            ),
                            SizedBox(height: 32.h),

                            // Experience Entries
                            if (controller.experienceList.isNotEmpty)
                              ...controller.experienceList
                                  .asMap()
                                  .entries
                                  .map((entry) {
                                int index = entry.key;
                                Experience experience = entry.value;
                                return _buildExperienceEntry(
                                    controller, index, experience, context);
                              }).toList(),

                            SizedBox(height: 20.h),

                            // Add More Button
                            if (controller.canAddMore)
                              SizedBox(
                                width: double.infinity,
                                child: OutlinedButton.icon(
                                  onPressed: controller.addExperience,
                                  icon: Icon(Icons.add, size: 20.sp),
                                  label: Text('Add More Experience'),
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
                                  '• At least one experience with all required fields',
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
                                  ? controller.saveExperience
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

  Widget _buildExperienceEntry(ExperienceController controller, int index,
      Experience experience, BuildContext context) {
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
                'Experience ${index + 1}',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryText,
                ),
              ),
              Spacer(),
              if (controller.experienceList.length > 1)
                IconButton(
                  onPressed: () => controller.removeExperience(index),
                  icon: Icon(
                    Icons.delete_outline,
                    size: 20.sp,
                    color: AppColors.error,
                  ),
                ),
            ],
          ),
          SizedBox(height: 16.h),

          // Job Title Field
          CustomTextField(
            label: 'Job Title',
            hint: 'e.g., Senior Flutter Developer, Project Manager',
            isRequired: true,
            validator: controller.validateTitle,
            prefixIcon: Icon(
              Icons.work,
              size: 20.sp,
              color: AppColors.primaryBlue,
            ),
            onChanged: (value) {
              experience.title = value;
              controller.updateExperience(index, experience);
            },
          ),
          SizedBox(height: 16.h),

          // Company Name Field
          CustomTextField(
            label: 'Company Name',
            hint: 'e.g., Google, Microsoft, Apple',
            isRequired: true,
            validator: controller.validateCompanyName,
            prefixIcon: Icon(
              Icons.business,
              size: 20.sp,
              color: AppColors.primaryBlue,
            ),
            onChanged: (value) {
              experience.companyName = value;
              controller.updateExperience(index, experience);
            },
          ),
          SizedBox(height: 16.h),

          // Date Range Section
          Text(
            'Duration',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryText,
            ),
          ),
          SizedBox(height: 12.h),

          // Start Date
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  label: 'Start Month',
                  hint: 'e.g., January',
                  isRequired: true,
                  validator: controller.validateMonth,
                  prefixIcon: Icon(
                    Icons.calendar_today,
                    size: 20.sp,
                    color: AppColors.primaryBlue,
                  ),
                  onChanged: (value) {
                    experience.startMonth = value;
                    controller.updateExperience(index, experience);
                  },
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: CustomTextField(
                  label: 'Start Year',
                  hint: 'e.g., 2020',
                  keyboardType: TextInputType.number,
                  isRequired: true,
                  validator: controller.validateYear,
                  prefixIcon: Icon(
                    Icons.calendar_month,
                    size: 20.sp,
                    color: AppColors.primaryBlue,
                  ),
                  onChanged: (value) {
                    experience.startYear = value;
                    controller.updateExperience(index, experience);
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // End Date
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  label: 'End Month',
                  hint: 'e.g., December',
                  isRequired: true,
                  validator: (value) => controller.validateEndDate(
                      value,
                      experience.endYear,
                      experience.startMonth,
                      experience.startYear),
                  prefixIcon: Icon(
                    Icons.calendar_today,
                    size: 20.sp,
                    color: AppColors.primaryBlue,
                  ),
                  onChanged: (value) {
                    experience.endMonth = value;
                    controller.updateExperience(index, experience);
                  },
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: CustomTextField(
                  label: 'End Year',
                  hint: 'e.g., 2023',
                  keyboardType: TextInputType.number,
                  isRequired: true,
                  validator: (value) => controller.validateEndDate(
                      experience.endMonth,
                      value,
                      experience.startMonth,
                      experience.startYear),
                  prefixIcon: Icon(
                    Icons.calendar_month,
                    size: 20.sp,
                    color: AppColors.primaryBlue,
                  ),
                  onChanged: (value) {
                    experience.endYear = value;
                    controller.updateExperience(index, experience);
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Description Field
          CustomTextField(
            label: 'Description',
            hint:
                'Describe your role, responsibilities, and achievements (3-4 lines)',
            isRequired: true,
            validator: controller.validateDescription,
            maxLines: 4,
            prefixIcon: Icon(
              Icons.description,
              size: 20.sp,
              color: AppColors.primaryBlue,
            ),
            onChanged: (value) {
              experience.description = value;
              controller.updateExperience(index, experience);
            },
          ),
        ],
      ),
    );
  }
}
