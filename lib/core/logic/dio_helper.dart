import 'package:dio/dio.dart';

class DioHelper {
  static String? token;

  static final _dio = Dio(
    BaseOptions(baseUrl: "https://cosmatics.growfet.com"),
  );

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
    Map<String, dynamic>? params,
    bool requiresAuth = false,
  }) async {
    try {
      final resp = await _dio.put(
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

  static Future<CustomResp> deleteData(
    String path, {
    bool requiresAuth = false,
  }) async {
    try {
      final resp = await _dio.delete(
        path,
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
    print("loay$data");
  }
}
