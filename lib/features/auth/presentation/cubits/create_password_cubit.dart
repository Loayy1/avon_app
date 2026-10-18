import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/datasources/auth_remote_data_source.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import 'create_password_states.dart';

class CreatePasswordCubit extends Cubit<CreatePasswordStates> {
  final AuthRepository repository;

  CreatePasswordCubit({AuthRepository? authRepository})
      : repository = authRepository ??
            AuthRepositoryImpl(remoteDataSource: AuthRemoteDataSourceImpl()),
        super(CreatePasswordInitialState());

  bool isObscure = true;
  bool isObscureConfirm = true;
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void togglePassword() {
    isObscure = !isObscure;
    emit(CreatePasswordToggleState());
  }

  void toggleConfirmPassword() {
    isObscureConfirm = !isObscureConfirm;
    emit(CreatePasswordConfirmToggleState());
  }

  void formUpdate() {
    emit(CreatePasswordFormUpdateState());
  }

  Future<bool> resetPassword({
    required String countryCode,
    required String phoneNumber,
  }) async {
    if (passwordController.text != confirmPasswordController.text) {
      emit(CreatePasswordFailedState(message: "Passwords do not match"));
      return false;
    }

    emit(CreatePasswordLoadingState());
    final result = await repository.resetPassword(
      countryCode: countryCode,
      phoneNumber: phoneNumber,
      newPassword: passwordController.text,
      confirmPassword: confirmPasswordController.text,
    );

    if (result.isSuccess) {
      emit(CreatePasswordSuccessState());
      return true;
    } else {
      emit(CreatePasswordFailedState(
        message: result.message ?? "Failed to reset password",
      ));
      return false;
    }
  }

  @override
  Future<void> close() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
