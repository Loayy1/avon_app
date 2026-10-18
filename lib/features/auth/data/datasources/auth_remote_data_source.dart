import '../../../../core/logic/dio_helper.dart';
import '../../../../core/network/api_endpoints.dart';

abstract class AuthRemoteDataSource {
  Future<CustomResp> login({
    required String countryCode,
    required String phoneNumber,
    required String password,
  });

  Future<CustomResp> register({
    required String username,
    required String countryCode,
    required String phoneNumber,
    required String email,
    required String password,
  });

  Future<CustomResp> verifyOtp({
    required String countryCode,
    required String phoneNumber,
    required String otpCode,
  });

  Future<CustomResp> resendOtp({
    required String countryCode,
    required String phoneNumber,
  });

  Future<CustomResp> forgotPassword({
    required String countryCode,
    required String phoneNumber,
  });

  Future<CustomResp> resetPassword({
    required String countryCode,
    required String phoneNumber,
    required String newPassword,
    required String confirmPassword,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<CustomResp> login({
    required String countryCode,
    required String phoneNumber,
    required String password,
  }) {
    return DioHelper.sendData(
      ApiEndpoints.login,
      data: {
        "countryCode": countryCode,
        "phoneNumber": phoneNumber,
        "password": password,
      },
    );
  }

  @override
  Future<CustomResp> register({
    required String username,
    required String countryCode,
    required String phoneNumber,
    required String email,
    required String password,
  }) {
    return DioHelper.sendData(
      ApiEndpoints.register,
      data: {
        "username": username,
        "countryCode": countryCode,
        "phoneNumber": phoneNumber,
        "email": email,
        "password": password,
      },
    );
  }

  @override
  Future<CustomResp> verifyOtp({
    required String countryCode,
    required String phoneNumber,
    required String otpCode,
  }) {
    return DioHelper.sendData(
      ApiEndpoints.verifyOtp,
      data: {
        "countryCode": countryCode,
        "phoneNumber": phoneNumber,
        "otpCode": otpCode,
      },
    );
  }

  @override
  Future<CustomResp> resendOtp({
    required String countryCode,
    required String phoneNumber,
  }) {
    return DioHelper.sendData(
      ApiEndpoints.resendOtp,
      data: {
        "countryCode": countryCode,
        "phoneNumber": phoneNumber,
      },
    );
  }

  @override
  Future<CustomResp> forgotPassword({
    required String countryCode,
    required String phoneNumber,
  }) {
    return DioHelper.sendData(
      ApiEndpoints.forgotPassword,
      data: {
        "countryCode": countryCode,
        "phoneNumber": phoneNumber,
      },
    );
  }

  @override
  Future<CustomResp> resetPassword({
    required String countryCode,
    required String phoneNumber,
    required String newPassword,
    required String confirmPassword,
  }) {
    return DioHelper.sendData(
      ApiEndpoints.resetPassword,
      data: {
        "countryCode": countryCode,
        "phoneNumber": phoneNumber,
        "newPassword": newPassword,
        "confirmPassword": confirmPassword,
      },
    );
  }
}
