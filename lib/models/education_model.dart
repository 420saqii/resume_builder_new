class Education {
  String? degree;
  String? institution;
  String? startYear;
  String? endYear;

  Education({
    this.degree,
    this.institution,
    this.startYear,
    this.endYear,
  });

  Map<String, dynamic> toJson() {
    return {
      'degree': degree,
      'institution': institution,
      'startYear': startYear,
      'endYear': endYear,
    };
  }

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      degree: json['degree'],
      institution: json['institution'],
      startYear: json['startYear'],
      endYear: json['endYear'],
    );
  }

  bool get isValid {
    return degree != null &&
        degree!.isNotEmpty &&
        institution != null &&
        institution!.isNotEmpty &&
        startYear != null &&
        startYear!.isNotEmpty &&
        endYear != null &&
        endYear!.isNotEmpty;
  }
}
