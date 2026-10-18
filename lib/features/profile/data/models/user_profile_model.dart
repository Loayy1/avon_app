class UserProfileModel {
  final String username;
  final String email;
  final String phoneNumber;
  final String? profilePhotoUrl;

  const UserProfileModel({
    required this.username,
    required this.email,
    required this.phoneNumber,
    this.profilePhotoUrl,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    final data = (json['data'] ?? json) as Map<String, dynamic>;
    return UserProfileModel(
      username: (data['username'] ?? data['userName'] ?? "User").toString(),
      email: (data['email'] ?? "").toString(),
      phoneNumber: (data['phoneNumber'] ?? data['phone'] ?? "").toString(),
      profilePhotoUrl: data['profilePhotoUrl']?.toString(),
    );
  }
}
