import '../../data/models/auth_response_model.dart';

abstract class AuthRepository {
  Future<AuthResponseModel> login({
    required String countryCode,
    required String phoneNumber,
    required String password,
  });

  Future<AuthResponseModel> register({
    required String username,
    required String countryCode,
    required String phoneNumber,
    required String email,
    required String password,
  });

  Future<AuthResponseModel> verifyOtp({
    required String countryCode,
    required String phoneNumber,
    required String otpCode,
  });

  Future<AuthResponseModel> resendOtp({
    required String countryCode,
    required String phoneNumber,
  });

  Future<AuthResponseModel> forgotPassword({
    required String countryCode,
    required String phoneNumber,
  });

  Future<AuthResponseModel> resetPassword({
    required String countryCode,
    required String phoneNumber,
    required String newPassword,
    required String confirmPassword,
  });
}
