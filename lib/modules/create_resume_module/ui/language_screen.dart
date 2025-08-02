import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../constants/colors.dart';
import '../controller/language_controller.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../models/language_model.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LanguageController controller = Get.put(LanguageController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Languages',
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
            : Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.primaryBackground,
                      AppColors.white,
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.all(16.w),
                        child: Form(
                          key: controller.formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Header with beautiful design
                              Container(
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
                                    color:
                                        AppColors.primaryBlue.withOpacity(0.2),
                                    width: 1,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(12.w),
                                          decoration: BoxDecoration(
                                            color: AppColors.primaryBlue,
                                            borderRadius:
                                                BorderRadius.circular(12.r),
                                          ),
                                          child: Icon(
                                            Icons.language,
                                            color: AppColors.white,
                                            size: 24.sp,
                                          ),
                                        ),
                                        SizedBox(width: 16.w),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Languages You Know',
                                                style: TextStyle(
                                                  fontSize: 22.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.primaryText,
                                                ),
                                              ),
                                              SizedBox(height: 4.h),
                                              Text(
                                                'Add all the languages you can speak, write, or understand',
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color:
                                                      AppColors.secondaryText,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 32.h),

                              // Language Entries
                              if (controller.languageList.isNotEmpty)
                                ...controller.languageList
                                    .asMap()
                                    .entries
                                    .map((entry) {
                                  int index = entry.key;
                                  Language language = entry.value;
                                  return _buildLanguageEntry(
                                      controller, index, language, context);
                                }).toList(),

                              SizedBox(height: 24.h),

                              // Add More Button
                              if (controller.canAddMore)
                                SizedBox(
                                  width: double.infinity,
                                  child: OutlinedButton.icon(
                                    onPressed: controller.addLanguage,
                                    icon: Icon(Icons.add, size: 20.sp),
                                    label: Text('Add More Languages'),
                                    style: OutlinedButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 24.w,
                                        vertical: 12.h,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
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

                    // Save Button at bottom with beautiful design
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
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.info_outline,
                                    color: AppColors.error,
                                    size: 16.sp,
                                  ),
                                  SizedBox(width: 8.w),
                                  Expanded(
                                    child: Text(
                                      'Add at least one language with proficiency level to continue',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: AppColors.error,
                                        fontWeight: FontWeight.w500,
                                      ),
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
                                    ? controller.saveLanguages
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
                ),
              )),
      ),
    );
  }

  Widget _buildLanguageEntry(LanguageController controller, int index,
      Language language, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: AppColors.primaryBorder.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with remove button
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: AppColors.primaryBlue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryBlue,
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          'Language ${index + 1}',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryText,
                          ),
                        ),
                      ),
                      if (controller.languageList.length > 1)
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.error.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: IconButton(
                            onPressed: () => controller.removeLanguage(index),
                            icon: Icon(
                              Icons.delete_outline,
                              size: 20.sp,
                              color: AppColors.error,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 20.h),

                  // Language Name Field with beautiful design
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.secondaryBackground,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: AppColors.primaryBorder.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: CustomTextField(
                      label: 'Language Name',
                      hint: 'e.g., English, Spanish, French, German',
                      isRequired: true,
                      validator: controller.validateLanguageName,
                      prefixIcon: Icon(
                        Icons.translate,
                        size: 20.sp,
                        color: AppColors.primaryBlue,
                      ),
                      onChanged: (value) {
                        language.languageName = value;
                        controller.updateLanguage(index, language);
                      },
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Proficiency Level Section
                  Text(
                    'Proficiency Level',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryText,
                    ),
                  ),
                  SizedBox(height: 8.h),

                  // Slider with percentage display
                  Row(
                    children: [
                      Expanded(
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: AppColors.primaryBlue,
                            inactiveTrackColor: AppColors.primaryBorder,
                            thumbColor: AppColors.primaryBlue,
                            overlayColor:
                                AppColors.primaryBlue.withOpacity(0.2),
                            trackHeight: 4.h,
                            thumbShape:
                                RoundSliderThumbShape(enabledThumbRadius: 8.r),
                            overlayShape:
                                RoundSliderOverlayShape(overlayRadius: 16.r),
                          ),
                          child: Slider(
                            value: (language.proficiencyLevel ?? 0).toDouble(),
                            min: 0.0,
                            max: 100.0,
                            divisions: 100,
                            label: '${language.proficiencyLevel ?? 0}%',
                            onChanged: (value) {
                              language.proficiencyLevel = value.round();
                              controller.updateLanguage(index, language);
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 6.h),
                        decoration: BoxDecoration(
                          color: AppColors.primaryBlue,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          '${language.proficiencyLevel ?? 0}%',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Proficiency level description
                  SizedBox(height: 8.h),
                  Text(
                    _getProficiencyDescription(language.proficiencyLevel ?? 0),
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.secondaryText,
                    ),
                  ),

                  // Language icon and info
                  if (language.languageName != null &&
                      language.languageName!.isNotEmpty)
                    Container(
                      margin: EdgeInsets.only(top: 12.h),
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: AppColors.primaryBlue.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: AppColors.primaryBlue.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: AppColors.primaryBlue,
                            size: 16.sp,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'Language added successfully',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: AppColors.primaryBlue,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _getProficiencyDescription(int level) {
    if (level == 0) return 'Beginner - No knowledge';
    if (level <= 25) return 'Beginner - Basic understanding';
    if (level <= 50) return 'Intermediate - Can communicate';
    if (level <= 75) return 'Advanced - Fluent speaker';
    if (level <= 90) return 'Expert - Native-like proficiency';
    return 'Master - Native speaker';
  }
}
