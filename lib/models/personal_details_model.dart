class PersonalDetails {
  String? fullName;
  String? email;
  String? phone;
  String? address;
  String? profileImagePath;

  PersonalDetails({
    this.fullName,
    this.email,
    this.phone,
    this.address,
    this.profileImagePath,
  });

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'address': address,
      'profileImagePath': profileImagePath,
    };
  }

  factory PersonalDetails.fromJson(Map<String, dynamic> json) {
    return PersonalDetails(
      fullName: json['fullName'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      profileImagePath: json['profileImagePath'],
    );
  }

  bool get isValid {
    return fullName != null &&
        fullName!.isNotEmpty &&
        email != null &&
        email!.isNotEmpty &&
        profileImagePath != null &&
        profileImagePath!.isNotEmpty;
  }
}
