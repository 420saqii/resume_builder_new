import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../constants/colors.dart';
import '../../../models/personal_details_model.dart';
import '../../../models/education_model.dart';
import '../../../models/skill_model.dart';
import '../../../models/experience_model.dart';
import '../../../models/language_model.dart';
import '../../../models/current_info_model.dart';
import '../../../models/resume_data_model.dart';
import '../../../services/storage_service.dart';

class ResumePreviewScreen extends StatelessWidget {
  const ResumePreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Load saved resume data
    final ResumeData? resumeData = StorageService.getResumeData();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Resume Preview',
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
          IconButton(
            icon: Icon(Icons.edit, size: 20.sp),
            onPressed: () {
              // TODO: Navigate to edit mode
              Get.snackbar(
                'Edit Mode',
                'Edit functionality coming soon!',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.blue,
                colorText: Colors.white,
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Section
                  _buildHeaderSection(),
                  SizedBox(height: 24.h),

                  // Personal Details Section
                  _buildSectionTitle('Personal Details', Icons.person),
                  _buildPersonalDetailsCard(resumeData),
                  SizedBox(height: 20.h),

                  // Current Information Section
                  _buildSectionTitle('Current Information', Icons.work),
                  _buildCurrentInfoCard(resumeData),
                  SizedBox(height: 20.h),

                  // Education Section
                  _buildSectionTitle('Education', Icons.school),
                  _buildEducationCard(resumeData),
                  SizedBox(height: 20.h),

                  // Skills Section
                  _buildSectionTitle('Skills', Icons.psychology),
                  _buildSkillsCard(resumeData),
                  SizedBox(height: 20.h),

                  // Experience Section
                  _buildSectionTitle('Work Experience', Icons.work_history),
                  _buildExperienceCard(resumeData),
                  SizedBox(height: 20.h),

                  // Languages Section
                  _buildSectionTitle('Languages', Icons.language),
                  _buildLanguagesCard(resumeData),
                  SizedBox(height: 32.h),
                ],
              ),
            ),
          ),

          // Action Buttons
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
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // TODO: Share resume
                      Get.snackbar(
                        'Share',
                        'Share functionality coming soon!',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.blue,
                        colorText: Colors.white,
                      );
                    },
                    icon: Icon(Icons.share, size: 18.sp),
                    label: Text('Share'),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      side: BorderSide(color: AppColors.primaryBlue),
                      foregroundColor: AppColors.primaryBlue,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primaryBlue,
                          AppColors.secondaryBlue,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryBlue.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          // TODO: Generate and download PDF
                          Get.snackbar(
                            'Generating PDF',
                            'PDF generation coming soon!',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.green,
                            colorText: Colors.white,
                          );
                        },
                        borderRadius: BorderRadius.circular(16.r),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 24.w,
                            vertical: 12.h,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.download,
                                color: AppColors.white,
                                size: 20.sp,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                'Download PDF',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.white,
                                ),
                              ),
                            ],
                          ),
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
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryBlue,
            AppColors.secondaryBlue,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryBlue.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            Icons.preview,
            size: 48.sp,
            color: AppColors.white,
          ),
          SizedBox(height: 12.h),
          Text(
            'Resume Preview',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Review all your information before generating your resume',
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.white.withOpacity(0.9),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20.sp,
            color: AppColors.primaryBlue,
          ),
          SizedBox(width: 8.w),
          Text(
            title,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalDetailsCard(ResumeData? resumeData) {
    if (resumeData?.personalDetails == null) {
      return _buildInfoCard([
        _buildInfoRow('Status', 'No personal details added yet'),
      ]);
    }

    final personalDetails = resumeData!.personalDetails!;
    return _buildInfoCard([
      _buildInfoRow('Full Name', personalDetails.fullName ?? 'Not provided'),
      _buildInfoRow('Email', personalDetails.email ?? 'Not provided'),
      if (personalDetails.phone?.isNotEmpty == true)
        _buildInfoRow('Phone', personalDetails.phone!),
      if (personalDetails.address?.isNotEmpty == true)
        _buildInfoRow('Address', personalDetails.address!),
      _buildInfoRow('Profile Photo',
          personalDetails.profileImagePath != null ? '✓ Added' : 'Not added'),
    ]);
  }

  Widget _buildCurrentInfoCard(ResumeData? resumeData) {
    if (resumeData?.currentInfo == null) {
      return _buildInfoCard([
        _buildInfoRow('Status', 'No current information added yet'),
      ]);
    }

    final currentInfo = resumeData!.currentInfo!;
    return _buildInfoCard([
      _buildInfoRow('Current Designation', currentInfo.designation),
      _buildInfoRow('Description', currentInfo.description),
      if (currentInfo.reference.isNotEmpty)
        _buildInfoRow('Reference', currentInfo.reference),
    ]);
  }

  Widget _buildEducationCard(ResumeData? resumeData) {
    if (resumeData?.educationList.isEmpty ?? true) {
      return _buildInfoCard([
        _buildInfoRow('Status', 'No education details added yet'),
      ]);
    }

    final education = resumeData!.educationList.first;
    return _buildInfoCard([
      _buildInfoRow('Degree', education.degree ?? 'Not provided'),
      _buildInfoRow('Institution', education.institution ?? 'Not provided'),
      _buildInfoRow('Duration',
          '${education.startYear ?? 'N/A'} - ${education.endYear ?? 'N/A'}'),
    ]);
  }

  Widget _buildSkillsCard(ResumeData? resumeData) {
    if (resumeData?.skillsList.isEmpty ?? true) {
      return _buildInfoCard([
        _buildInfoRow('Status', 'No skills added yet'),
      ]);
    }

    final skills = resumeData!.skillsList;
    return _buildInfoCard(
      skills
          .map((skill) => _buildInfoRow(
                skill.skillName ?? 'Unknown Skill',
                '${skill.proficiencyLevel}%',
              ))
          .toList(),
    );
  }

  Widget _buildExperienceCard(ResumeData? resumeData) {
    if (resumeData?.experienceList.isEmpty ?? true) {
      return _buildInfoCard([
        _buildInfoRow('Status', 'No work experience added yet'),
      ]);
    }

    final experience = resumeData!.experienceList.first;
    return _buildInfoCard([
      _buildInfoRow('Title', experience.title ?? 'Not provided'),
      _buildInfoRow('Company', experience.companyName ?? 'Not provided'),
      _buildInfoRow('Duration',
          '${experience.startMonth} ${experience.startYear} - ${experience.endMonth} ${experience.endYear}'),
      _buildInfoRow('Description', experience.description ?? 'Not provided'),
    ]);
  }

  Widget _buildLanguagesCard(ResumeData? resumeData) {
    if (resumeData?.languageList.isEmpty ?? true) {
      return _buildInfoCard([
        _buildInfoRow('Status', 'No languages added yet'),
      ]);
    }

    final languages = resumeData!.languageList;
    return _buildInfoCard(
      languages
          .map((language) => _buildInfoRow(
                language.languageName ?? 'Unknown Language',
                '${language.proficiencyLevel}%',
              ))
          .toList(),
    );
  }

  Widget _buildInfoCard(List<Widget> children) {
    return Container(
      width: double.infinity,
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
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100.w,
            child: Text(
              '$label:',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryText,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.secondaryText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
