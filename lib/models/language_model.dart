class Language {
  String? languageName;
  int? proficiencyLevel; // Percentage (0-100)

  Language({
    this.languageName,
    this.proficiencyLevel,
  });

  Map<String, dynamic> toJson() {
    return {
      'languageName': languageName,
      'proficiencyLevel': proficiencyLevel,
    };
  }

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      languageName: json['languageName'],
      proficiencyLevel: json['proficiencyLevel'],
    );
  }

  bool get isValid {
    return languageName != null &&
        languageName!.isNotEmpty &&
        proficiencyLevel != null &&
        proficiencyLevel! >= 1 &&
        proficiencyLevel! <= 100;
  }
}
