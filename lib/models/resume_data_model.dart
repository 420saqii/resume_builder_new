import 'personal_details_model.dart';
import 'education_model.dart';
import 'skill_model.dart';
import 'experience_model.dart';
import 'language_model.dart';
import 'current_info_model.dart';

class ResumeData {
  final PersonalDetails? personalDetails;
  final List<Education> educationList;
  final List<Skill> skillsList;
  final List<Experience> experienceList;
  final List<Language> languageList;
  final CurrentInfo? currentInfo;
  final String? selectedTemplate;

  ResumeData({
    this.personalDetails,
    this.educationList = const [],
    this.skillsList = const [],
    this.experienceList = const [],
    this.languageList = const [],
    this.currentInfo,
    this.selectedTemplate,
  });

  Map<String, dynamic> toJson() {
    return {
      'personalDetails': personalDetails?.toJson(),
      'educationList': educationList.map((e) => e.toJson()).toList(),
      'skillsList': skillsList.map((s) => s.toJson()).toList(),
      'experienceList': experienceList.map((e) => e.toJson()).toList(),
      'languageList': languageList.map((l) => l.toJson()).toList(),
      'currentInfo': currentInfo?.toJson(),
      'selectedTemplate': selectedTemplate,
    };
  }

  factory ResumeData.fromJson(Map<String, dynamic> json) {
    return ResumeData(
      personalDetails: json['personalDetails'] != null
          ? PersonalDetails.fromJson(json['personalDetails'])
          : null,
      educationList: (json['educationList'] as List<dynamic>?)
              ?.map((e) => Education.fromJson(e))
              .toList() ??
          [],
      skillsList: (json['skillsList'] as List<dynamic>?)
              ?.map((s) => Skill.fromJson(s))
              .toList() ??
          [],
      experienceList: (json['experienceList'] as List<dynamic>?)
              ?.map((e) => Experience.fromJson(e))
              .toList() ??
          [],
      languageList: (json['languageList'] as List<dynamic>?)
              ?.map((l) => Language.fromJson(l))
              .toList() ??
          [],
      currentInfo: json['currentInfo'] != null
          ? CurrentInfo.fromJson(json['currentInfo'])
          : null,
      selectedTemplate: json['selectedTemplate'],
    );
  }

  ResumeData copyWith({
    PersonalDetails? personalDetails,
    List<Education>? educationList,
    List<Skill>? skillsList,
    List<Experience>? experienceList,
    List<Language>? languageList,
    CurrentInfo? currentInfo,
    String? selectedTemplate,
  }) {
    return ResumeData(
      personalDetails: personalDetails ?? this.personalDetails,
      educationList: educationList ?? this.educationList,
      skillsList: skillsList ?? this.skillsList,
      experienceList: experienceList ?? this.experienceList,
      languageList: languageList ?? this.languageList,
      currentInfo: currentInfo ?? this.currentInfo,
      selectedTemplate: selectedTemplate ?? this.selectedTemplate,
    );
  }

  bool get isComplete {
    return personalDetails != null &&
        personalDetails!.isValid &&
        educationList.isNotEmpty &&
        educationList.every((e) => e.isValid) &&
        skillsList.isNotEmpty &&
        skillsList.every((s) => s.isValid) &&
        experienceList.isNotEmpty &&
        experienceList.every((e) => e.isValid) &&
        languageList.isNotEmpty &&
        languageList.every((l) => l.isValid) &&
        currentInfo != null &&
        currentInfo!.isValid;
  }

  int get completionPercentage {
    int completedSections = 0;
    int totalSections =
        6; // personal, education, skills, experience, languages, current info

    if (personalDetails != null && personalDetails!.isValid)
      completedSections++;
    if (educationList.isNotEmpty && educationList.every((e) => e.isValid))
      completedSections++;
    if (skillsList.isNotEmpty && skillsList.every((s) => s.isValid))
      completedSections++;
    if (experienceList.isNotEmpty && experienceList.every((e) => e.isValid))
      completedSections++;
    if (languageList.isNotEmpty && languageList.every((l) => l.isValid))
      completedSections++;
    if (currentInfo != null && currentInfo!.isValid) completedSections++;

    return ((completedSections / totalSections) * 100).round();
  }
}
