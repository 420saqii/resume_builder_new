class CurrentInfo {
  final String designation;
  final String description;
  final String reference;

  CurrentInfo({
    required this.designation,
    required this.description,
    this.reference = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'designation': designation,
      'description': description,
      'reference': reference,
    };
  }

  factory CurrentInfo.fromJson(Map<String, dynamic> json) {
    return CurrentInfo(
      designation: json['designation'] ?? '',
      description: json['description'] ?? '',
      reference: json['reference'] ?? '',
    );
  }

  bool get isValid {
    return designation.trim().isNotEmpty && description.trim().isNotEmpty;
  }

  CurrentInfo copyWith({
    String? designation,
    String? description,
    String? reference,
  }) {
    return CurrentInfo(
      designation: designation ?? this.designation,
      description: description ?? this.description,
      reference: reference ?? this.reference,
    );
  }
}
