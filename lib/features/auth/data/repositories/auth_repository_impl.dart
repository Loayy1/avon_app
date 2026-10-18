import '../../../../core/logic/dio_helper.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/auth_response_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<AuthResponseModel> login({
    required String countryCode,
    required String phoneNumber,
    required String password,
  }) async {
    final resp = await remoteDataSource.login(
      countryCode: countryCode,
      phoneNumber: phoneNumber,
      password: password,
    );

    if (resp.isSuccess && resp.data != null) {
      final model = AuthResponseModel.fromJson(resp.data);
      if (model.token != null) {
        await DioHelper.saveToken(model.token);
      }
      return model;
    } else {
      return AuthResponseModel(
        isSuccess: false,
        message: resp.errorMessage,
      );
    }
  }

  @override
  Future<AuthResponseModel> register({
    required String username,
    required String countryCode,
    required String phoneNumber,
    required String email,
    required String password,
  }) async {
    final resp = await remoteDataSource.register(
      username: username,
      countryCode: countryCode,
      phoneNumber: phoneNumber,
      email: email,
      password: password,
    );

    if (resp.isSuccess) {
      final model = AuthResponseModel.fromJson(
        resp.data is Map ? Map<String, dynamic>.from(resp.data) : {},
      );
      if (model.token != null) {
        await DioHelper.saveToken(model.token);
      }
      return model;
    } else {
      return AuthResponseModel(
        isSuccess: false,
        message: resp.errorMessage,
      );
    }
  }

  @override
  Future<AuthResponseModel> verifyOtp({
    required String countryCode,
    required String phoneNumber,
    required String otpCode,
  }) async {
    final resp = await remoteDataSource.verifyOtp(
      countryCode: countryCode,
      phoneNumber: phoneNumber,
      otpCode: otpCode,
    );

    if (resp.isSuccess) {
      final model = AuthResponseModel.fromJson(resp.data is Map ? resp.data : {});
      if (model.token != null) {
        await DioHelper.saveToken(model.token);
      }
      return model;
    } else {
      return AuthResponseModel(
        isSuccess: false,
        message: resp.errorMessage,
      );
    }
  }

  @override
  Future<AuthResponseModel> resendOtp({
    required String countryCode,
    required String phoneNumber,
  }) async {
    final resp = await remoteDataSource.resendOtp(
      countryCode: countryCode,
      phoneNumber: phoneNumber,
    );

    if (resp.isSuccess) {
      return AuthResponseModel.fromJson(resp.data is Map ? resp.data : {});
    } else {
      return AuthResponseModel(
        isSuccess: false,
        message: resp.errorMessage,
      );
    }
  }

  @override
  Future<AuthResponseModel> forgotPassword({
    required String countryCode,
    required String phoneNumber,
  }) async {
    final resp = await remoteDataSource.forgotPassword(
      countryCode: countryCode,
      phoneNumber: phoneNumber,
    );

    if (resp.isSuccess) {
      return AuthResponseModel.fromJson(resp.data is Map ? resp.data : {});
    } else {
      return AuthResponseModel(
        isSuccess: false,
        message: resp.errorMessage,
      );
    }
  }

  @override
  Future<AuthResponseModel> resetPassword({
    required String countryCode,
    required String phoneNumber,
    required String newPassword,
    required String confirmPassword,
  }) async {
    final resp = await remoteDataSource.resetPassword(
      countryCode: countryCode,
      phoneNumber: phoneNumber,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );

    if (resp.isSuccess) {
      return AuthResponseModel.fromJson(resp.data is Map ? resp.data : {});
    } else {
      return AuthResponseModel(
        isSuccess: false,
        message: resp.errorMessage,
      );
    }
  }
}
