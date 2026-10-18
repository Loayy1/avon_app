import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioHelper {
  static String? token;

  static final _dio = Dio(
    BaseOptions(
      baseUrl: "https://cosmatics.growfet.com",
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    ),
  );

  /// حفظ الـ token في الـ SharedPreferences وفي الـ memory
  static Future<void> saveToken(String? newToken) async {
    token = newToken;
    try {
      final prefs = await SharedPreferences.getInstance();
      if (newToken != null && newToken.isNotEmpty) {
        await prefs.setString("auth_token", newToken);
      } else {
        await prefs.remove("auth_token");
      }
    } catch (e) {
      print("Error saving token: $e");
    }
  }

  /// تحميل الـ token المحفوظ عند بدء التطبيق
  static Future<void> loadToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      token = prefs.getString("auth_token");
      print("Loaded token: $token");
    } catch (e) {
      print("Error loading token: $e");
    }
  }

  static Options _authOptions() {
    return Options(
      headers: token != null ? {"Authorization": "Bearer $token"} : null,
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
      return CustomResp(
        isSuccess: false,
        data: ex.response?.data,
        statusCode: ex.response?.statusCode,
      );
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
      return CustomResp(
        isSuccess: false,
        data: ex.response?.data,
        statusCode: ex.response?.statusCode,
      );
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
      return CustomResp(
        isSuccess: false,
        data: ex.response?.data,
        statusCode: ex.response?.statusCode,
      );
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
      return CustomResp(
        isSuccess: false,
        data: ex.response?.data,
        statusCode: ex.response?.statusCode,
      );
    }
  }
}

class CustomResp {
  bool isSuccess;
  dynamic data;
  int? statusCode;

  CustomResp({required this.isSuccess, required this.data, this.statusCode}) {
    print("loay status: $statusCode, data: $data");
  }
}
