class UserModel {
  final String uid;
  final String? displayName;
  final String? email;
  final String? photoURL;
  final String? gender;
  final String? phoneNumber;

  UserModel({
    required this.uid,
    this.displayName,
    this.email,
    this.photoURL,
    this.gender,
    this.phoneNumber,
  });

  // Convert to Map for storage
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'displayName': displayName,
      'email': email,
      'photoURL': photoURL,
      'gender': gender,
      'phoneNumber': phoneNumber,
    };
  }

  // Create from Map
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] ?? '',
      displayName: json['displayName'],
      email: json['email'],
      photoURL: json['photoURL'],
      gender: json['gender'],
      phoneNumber: json['phoneNumber'],
    );
  }

  // Create from Firebase User
  factory UserModel.fromFirebaseUser(dynamic user) {
    return UserModel(
      uid: user.uid ?? '',
      displayName: user.displayName,
      email: user.email,
      photoURL: user.photoURL,
      phoneNumber: user.phoneNumber,
    );
  }

  // Copy with method for updating specific fields
  UserModel copyWith({
    String? uid,
    String? displayName,
    String? email,
    String? photoURL,
    String? gender,
    String? phoneNumber,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      photoURL: photoURL ?? this.photoURL,
      gender: gender ?? this.gender,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}
