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
  final bool isSuccess;
  final dynamic data;
  final int? statusCode;

  CustomResp({required this.isSuccess, required this.data, this.statusCode});

  String get errorMessage {
    if (data is Map && data["message"] != null) {
      return data["message"].toString();
    }
    if (data is Map && data["error"] != null) {
      return data["error"].toString();
    }
    if (statusCode == 401) {
      return "Unauthorized. Please login again.";
    }
    return "Something went wrong. Please try again.";
  }
}
