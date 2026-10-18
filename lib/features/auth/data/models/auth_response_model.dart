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
    bool success = true;
    if (json.containsKey("isSuccess")) {
      success = json["isSuccess"] == true;
    } else if (json.containsKey("status")) {
      success = json["status"] == true;
    }

    String? msg = json["message"]?.toString();
    if (msg == null && json["errors"] != null) {
      if (json["errors"] is Map) {
        final errMap = json["errors"] as Map;
        final firstKey = errMap.keys.firstOrNull;
        if (firstKey != null &&
            errMap[firstKey] is List &&
            (errMap[firstKey] as List).isNotEmpty) {
          msg = (errMap[firstKey] as List).first.toString();
        }
      } else {
        msg = json["errors"].toString();
      }
    }

    return AuthResponseModel(
      isSuccess: success,
      token: json["token"] ?? json["data"]?["token"],
      refreshToken: json["refreshToken"] ?? json["data"]?["refreshToken"],
      message: msg,
    );
  }
}
