import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/datasources/auth_remote_data_source.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import 'forgot_password_states.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordStates> {
  final AuthRepository repository;

  ForgotPasswordCubit({AuthRepository? authRepository})
      : repository = authRepository ??
            AuthRepositoryImpl(remoteDataSource: AuthRemoteDataSourceImpl()),
        super(ForgotPasswordInitialState());

  String? phoneCode = "+20";
  final phoneController = TextEditingController();

  void updateCode(String code) {
    phoneCode = code;
    emit(ForgotPasswordCodeUpdateState());
  }

  void updateForm() {
    emit(ForgotPasswordFormUpdateState());
  }

  Future<bool> forgotPassword() async {
    emit(ForgotPasswordLoadingState());
    final result = await repository.forgotPassword(
      countryCode: phoneCode ?? "+20",
      phoneNumber: phoneController.text.trim(),
    );

    if (result.isSuccess) {
      emit(ForgotPasswordSuccessState());
      return true;
    } else {
      emit(ForgotPasswordFailedState(
        message: result.message ?? "Failed to send reset code",
      ));
      return false;
    }
  }

  @override
  Future<void> close() {
    phoneController.dispose();
    return super.close();
  }
}
