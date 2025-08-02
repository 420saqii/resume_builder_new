import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../constants/colors.dart';
import '../controller/current_info_controller.dart';
import '../../../widgets/custom_text_field.dart';

class CurrentInfoScreen extends StatelessWidget {
  const CurrentInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CurrentInfoController controller = Get.put(CurrentInfoController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Current Information',
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
                            // Header Section
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(20.w),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.primaryBlue.withOpacity(0.1),
                                    AppColors.secondaryBlue.withOpacity(0.05),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(16.r),
                                border: Border.all(
                                  color: AppColors.primaryBlue.withOpacity(0.2),
                                  width: 1,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.work_outline,
                                    size: 48.sp,
                                    color: AppColors.primaryBlue,
                                  ),
                                  SizedBox(height: 12.h),
                                  Text(
                                    'Tell us about your current role',
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primaryText,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    'Share your current designation and a brief description of your role',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: AppColors.secondaryText,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 24.h),

                            // Current Designation
                            CustomTextField(
                              label: 'Current Designation',
                              hint: 'e.g., Flutter Developer, UI/UX Designer',
                              controller: controller.designationController,
                              isRequired: true,
                              validator: controller.validateDesignation,
                              prefixIcon: Icon(
                                Icons.work,
                                size: 20.sp,
                                color: AppColors.primaryBlue,
                              ),
                              onChanged: (value) {
                                controller.designation.value = value;
                              },
                            ),
                            SizedBox(height: 20.h),

                            // Description
                            CustomTextField(
                              label: 'Description',
                              hint:
                                  'Describe your current role and responsibilities (3-4 lines)',
                              controller: controller.descriptionController,
                              isRequired: true,
                              validator: controller.validateDescription,
                              maxLines: 4,
                              prefixIcon: Icon(
                                Icons.description,
                                size: 20.sp,
                                color: AppColors.primaryBlue,
                              ),
                              onChanged: (value) {
                                controller.description.value = value;
                              },
                            ),
                            SizedBox(height: 20.h),

                            // Reference (Optional)
                            CustomTextField(
                              label: 'Reference (Optional)',
                              hint:
                                  'Add any reference or additional information',
                              controller: controller.referenceController,
                              validator: controller.validateReference,
                              maxLines: 3,
                              prefixIcon: Icon(
                                Icons.link,
                                size: 20.sp,
                                color: AppColors.primaryBlue,
                              ),
                              onChanged: (value) {
                                controller.reference.value = value;
                              },
                            ),
                            SizedBox(height: 32.h),

                            // Info Card
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(16.w),
                              decoration: BoxDecoration(
                                color: AppColors.secondaryBackground,
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: AppColors.primaryBorder,
                                  width: 1,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.info_outline,
                                        size: 20.sp,
                                        color: AppColors.primaryBlue,
                                      ),
                                      SizedBox(width: 8.w),
                                      Text(
                                        'Tips for a great description:',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.primaryText,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 12.h),
                                  _buildTip(
                                      '• Highlight your key responsibilities'),
                                  _buildTip(
                                      '• Mention technologies or tools you use'),
                                  _buildTip('• Include achievements or impact'),
                                  _buildTip(
                                      '• Keep it professional and concise'),
                                ],
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
                              color: AppColors.error.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(
                                color: AppColors.error.withOpacity(0.3),
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
                                if (controller.designation.value.trim().isEmpty)
                                  Text(
                                    '• Current Designation is required',
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      color: AppColors.error,
                                    ),
                                  ),
                                if (controller.description.value.trim().isEmpty)
                                  Text(
                                    '• Description is required',
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
                                  ? controller.saveCurrentInfo
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

  Widget _buildTip(String tip) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Text(
        tip,
        style: TextStyle(
          fontSize: 12.sp,
          color: AppColors.secondaryText,
        ),
      ),
    );
  }
}
