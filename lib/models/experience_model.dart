class Experience {
  String? title;
  String? companyName;
  String? startMonth;
  String? startYear;
  String? endMonth;
  String? endYear;
  String? description;

  Experience({
    this.title,
    this.companyName,
    this.startMonth,
    this.startYear,
    this.endMonth,
    this.endYear,
    this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'companyName': companyName,
      'startMonth': startMonth,
      'startYear': startYear,
      'endMonth': endMonth,
      'endYear': endYear,
      'description': description,
    };
  }

  factory Experience.fromJson(Map<String, dynamic> json) {
    return Experience(
      title: json['title'],
      companyName: json['companyName'],
      startMonth: json['startMonth'],
      startYear: json['startYear'],
      endMonth: json['endMonth'],
      endYear: json['endYear'],
      description: json['description'],
    );
  }

  bool get isValid {
    return title != null &&
        title!.isNotEmpty &&
        companyName != null &&
        companyName!.isNotEmpty &&
        startMonth != null &&
        startMonth!.isNotEmpty &&
        startYear != null &&
        startYear!.isNotEmpty &&
        endMonth != null &&
        endMonth!.isNotEmpty &&
        endYear != null &&
        endYear!.isNotEmpty &&
        description != null &&
        description!.isNotEmpty;
  }
}
