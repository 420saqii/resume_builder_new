class Skill {
  String? skillName;
  int? proficiencyLevel; // Percentage (0-100)

  Skill({
    this.skillName,
    this.proficiencyLevel,
  });

  Map<String, dynamic> toJson() {
    return {
      'skillName': skillName,
      'proficiencyLevel': proficiencyLevel,
    };
  }

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      skillName: json['skillName'],
      proficiencyLevel: json['proficiencyLevel'],
    );
  }

  bool get isValid {
    return skillName != null &&
        skillName!.isNotEmpty &&
        proficiencyLevel != null &&
        proficiencyLevel! >= 1 &&
        proficiencyLevel! <= 100;
  }
}
