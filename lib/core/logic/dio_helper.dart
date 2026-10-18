import 'package:dio/dio.dart';
import '../network/api_endpoints.dart';
import '../storage/cache_helper.dart';

class DioHelper {
  static String? get token => CacheHelper.getToken();

  static set token(String? val) {
    if (val != null) {
      CacheHelper.saveToken(val);
    } else {
      CacheHelper.removeToken();
    }
  }

  static final _dio = Dio(
    BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    ),
  );

  static Future<void> saveToken(String? newToken) async {
    token = newToken;
  }

  static Future<void> loadToken() async {
    await CacheHelper.init();
  }

  static Options _authOptions() {
    final t = token;
    return Options(
      headers: t != null ? {"Authorization": "Bearer $t"} : null,
    );
  }

  static Future<CustomResp> getData(
    String path, {
    Map<String, dynamic>? params,
    bool requiresAuth = false,
  }) async {
    try {
      final resp = await _dio.get(
        path,
        queryParameters: params,
        options: requiresAuth ? _authOptions() : null,
      );
      return CustomResp(
        isSuccess: true,
        data: resp.data,
        statusCode: resp.statusCode,
      );
    } on DioException catch (ex) {
      return _handleDioError(ex);
    }
  }

  static Future<CustomResp> sendData(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? params,
    bool requiresAuth = false,
  }) async {
    try {
      final resp = await _dio.post(
        path,
        data: data,
        queryParameters: params,
        options: requiresAuth ? _authOptions() : null,
      );
      return CustomResp(
        isSuccess: true,
        data: resp.data,
        statusCode: resp.statusCode,
      );
    } on DioException catch (ex) {
      return _handleDioError(ex);
    }
  }

  static Future<CustomResp> updateData(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? params,
    bool requiresAuth = false,
  }) async {
    try {
      final resp = await _dio.put(
        path,
        data: data,
        queryParameters: params,
        options: requiresAuth ? _authOptions() : null,
      );
      return CustomResp(
        isSuccess: true,
        data: resp.data,
        statusCode: resp.statusCode,
      );
    } on DioException catch (ex) {
      return _handleDioError(ex);
    }
  }

  static Future<CustomResp> deleteData(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? params,
    bool requiresAuth = false,
  }) async {
    try {
      final resp = await _dio.delete(
        path,
        data: data,
        queryParameters: params,
        options: requiresAuth ? _authOptions() : null,
      );
      return CustomResp(
        isSuccess: true,
        data: resp.data,
        statusCode: resp.statusCode,
      );
    } on DioException catch (ex) {
      return _handleDioError(ex);
    }
  }

  static CustomResp _handleDioError(DioException ex) {
    String? customMsg;
    if (ex.type == DioExceptionType.connectionTimeout ||
        ex.type == DioExceptionType.sendTimeout ||
        ex.type == DioExceptionType.receiveTimeout) {
      customMsg = "Connection timed out. Please check your internet connection.";
    } else if (ex.type == DioExceptionType.connectionError) {
      customMsg = "Cannot connect to server. Please verify your internet connection.";
    } else if (ex.response?.data is Map) {
      final d = ex.response!.data as Map;
      customMsg = d["message"]?.toString() ?? d["error"]?.toString();
    }
    return CustomResp(
      isSuccess: false,
      data: ex.response?.data,
      statusCode: ex.response?.statusCode,
      message: customMsg,
    );
  }
}

class CustomResp {
  final bool isSuccess;
  final dynamic data;
  final int? statusCode;
  final String? message;

  CustomResp({
    required this.isSuccess,
    required this.data,
    this.statusCode,
    this.message,
  });

  String get errorMessage {
    if (message != null && message!.isNotEmpty) {
      return message!;
    }
    if (data is Map) {
      if (data["message"] != null && data["message"].toString().isNotEmpty) {
        return data["message"].toString();
      }
      if (data["error"] != null && data["error"].toString().isNotEmpty) {
        return data["error"].toString();
      }
      if (data["errors"] != null) {
        if (data["errors"] is Map) {
          final errMap = data["errors"] as Map;
          final firstKey = errMap.keys.firstOrNull;
          if (firstKey != null && errMap[firstKey] is List && (errMap[firstKey] as List).isNotEmpty) {
            return (errMap[firstKey] as List).first.toString();
          }
        }
        return data["errors"].toString();
      }
      if (data["title"] != null && data["title"].toString().isNotEmpty) {
        return data["title"].toString();
      }
    }
    if (statusCode == 401) {
      return "Unauthorized. Please login again.";
    }
    return "Something went wrong. Please check your internet connection.";
  }
}
