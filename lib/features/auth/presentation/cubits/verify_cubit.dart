import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/datasources/auth_remote_data_source.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import 'verify_states.dart';

class VerifyCubit extends Cubit<VerifyStates> {
  final AuthRepository repository;

  VerifyCubit({AuthRepository? authRepository})
      : repository = authRepository ??
            AuthRepositoryImpl(remoteDataSource: AuthRemoteDataSourceImpl()),
        super(VerifyInitialState());

  final List<FocusNode> focusNodes = List.generate(4, (_) => FocusNode());
  final List<TextEditingController> codeControllers =
      List.generate(4, (_) => TextEditingController());

  String get otpCode => codeControllers.map((c) => c.text).join();

  void onCodeChanged() {
    emit(VerifyCodeChangedState());
  }

  Future<bool> verifyOtp({
    required String countryCode,
    required String phoneNumber,
  }) async {
    emit(VerifyLoadingState());
    final result = await repository.verifyOtp(
      countryCode: countryCode,
      phoneNumber: phoneNumber,
      otpCode: otpCode,
    );

    if (result.isSuccess) {
      emit(VerifySuccessState());
      return true;
    } else {
      emit(VerifyFailedState(
        message: result.message ?? "Invalid verification code",
      ));
      return false;
    }
  }

  Future<bool> resendOtp({
    required String countryCode,
    required String phoneNumber,
  }) async {
    emit(VerifyResendLoadingState());
    final result = await repository.resendOtp(
      countryCode: countryCode,
      phoneNumber: phoneNumber,
    );

    if (result.isSuccess) {
      emit(VerifyResendSuccessState());
      return true;
    } else {
      emit(VerifyFailedState(
        message: result.message ?? "Failed to resend code",
      ));
      return false;
    }
  }

  @override
  Future<void> close() {
    for (var c in codeControllers) {
      c.dispose();
    }
    for (var n in focusNodes) {
      n.dispose();
    }
    return super.close();
  }
}
