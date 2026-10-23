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
      success = json["isSuccess"] == true || json["isSuccess"] == 1;
    } else if (json.containsKey("status")) {
      final s = json["status"];
      success = s == true || s == 1 || s == 200 || s == "success";
    }

    String? token;
    if (json["token"] != null) {
      token = json["token"].toString();
    } else if (json["accessToken"] != null) {
      token = json["accessToken"].toString();
    } else if (json["data"] is Map) {
      final d = json["data"] as Map;
      token = d["token"]?.toString() ?? d["accessToken"]?.toString();
    } else if (json["data"] is String && (json["data"] as String).isNotEmpty) {
      token = json["data"].toString();
    }

    String? refreshToken;
    if (json["refreshToken"] != null) {
      refreshToken = json["refreshToken"].toString();
    } else if (json["data"] is Map) {
      final d = json["data"] as Map;
      refreshToken = d["refreshToken"]?.toString();
    }

    String? msg = json["message"]?.toString() ?? json["error"]?.toString();
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
      token: token,
      refreshToken: refreshToken,
      message: msg,
    );
  }
}
