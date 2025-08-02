import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../constants/colors.dart';
import '../controller/skills_controller.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/step_indicator.dart';
import '../../../models/skill_model.dart';

class SkillsScreen extends StatelessWidget {
  const SkillsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SkillsController controller = Get.put(SkillsController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Skills',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 20.sp),
          onPressed: () => Get.back(),
        ),
        actions: [
          const StepIndicator(currentStep: 3, totalSteps: 7),
          SizedBox(width: 16.w),
        ],
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
                              'Showcase your skills',
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryText,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'Add your technical and professional skills with proficiency levels',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: AppColors.secondaryText,
                              ),
                            ),
                            SizedBox(height: 32.h),

                            // Skills Entries
                            if (controller.skillsList.isNotEmpty)
                              ...controller.skillsList
                                  .asMap()
                                  .entries
                                  .map((entry) {
                                int index = entry.key;
                                Skill skill = entry.value;
                                return _buildSkillEntry(
                                    controller, index, skill, context);
                              }).toList(),

                            SizedBox(height: 20.h),

                            // Add More Button
                            if (controller.canAddMore)
                              SizedBox(
                                width: double.infinity,
                                child: OutlinedButton.icon(
                                  onPressed: controller.addSkill,
                                  icon: Icon(Icons.add, size: 20.sp),
                                  label: Text('Add More Skills'),
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
                                  '• At least one skill with name and proficiency level',
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
                                  ? controller.saveSkills
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

  Widget _buildSkillEntry(SkillsController controller, int index, Skill skill,
      BuildContext context) {
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
                'Skill ${index + 1}',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryText,
                ),
              ),
              Spacer(),
              if (controller.skillsList.length > 1)
                IconButton(
                  onPressed: () => controller.removeSkill(index),
                  icon: Icon(
                    Icons.delete_outline,
                    size: 20.sp,
                    color: AppColors.error,
                  ),
                ),
            ],
          ),
          SizedBox(height: 16.h),

          // Skill Name Field
          CustomTextField(
            label: 'Skill Name',
            hint: 'e.g., Flutter, JavaScript, Project Management',
            isRequired: true,
            validator: controller.validateSkillName,
            prefixIcon: Icon(
              Icons.psychology,
              size: 20.sp,
              color: AppColors.primaryBlue,
            ),
            onChanged: (value) {
              skill.skillName = value;
              controller.updateSkill(index, skill);
            },
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
                    overlayColor: AppColors.primaryBlue.withOpacity(0.2),
                    trackHeight: 4.h,
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.r),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 16.r),
                  ),
                  child: Slider(
                    value: (skill.proficiencyLevel ?? 0).toDouble(),
                    min: 0.0,
                    max: 100.0,
                    divisions: 100,
                    label: '${skill.proficiencyLevel ?? 0}%',
                    onChanged: (value) {
                      skill.proficiencyLevel = value.round();
                      controller.updateSkill(index, skill);
                    },
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  '${skill.proficiencyLevel ?? 0}%',
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
            _getProficiencyDescription(skill.proficiencyLevel ?? 0),
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColors.secondaryText,
            ),
          ),
        ],
      ),
    );
  }

  String _getProficiencyDescription(int level) {
    if (level == 0) return 'Beginner - No experience';
    if (level <= 25) return 'Beginner - Basic understanding';
    if (level <= 50) return 'Intermediate - Some experience';
    if (level <= 75) return 'Advanced - Good experience';
    if (level <= 90) return 'Expert - Extensive experience';
    return 'Master - Exceptional expertise';
  }
}
