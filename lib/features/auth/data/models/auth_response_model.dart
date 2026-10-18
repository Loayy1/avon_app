class AuthResponseModel {
  final bool isSuccess;
  final String? token;
  final String? refreshToken;
  final String? message;

  const AuthResponseModel({
    required this.isSuccess,
    this.token,
    this.refreshToken,
    this.message,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      isSuccess: true,
      token: json["token"] ?? json["data"]?["token"],
      refreshToken: json["refreshToken"] ?? json["data"]?["refreshToken"],
      message: json["message"]?.toString(),
    );
  }
}
