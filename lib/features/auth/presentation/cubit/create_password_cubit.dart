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
  bool confirmIsObscure = true;
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void resetPassword({required String phone, required String phoneCode}) async {
    if (passwordController.text != confirmPasswordController.text) {
      emit(CreatePasswordFailedState());
      return;
    }

    emit(CreatePasswordLoadingState());
    final result = await repository.resetPassword(
      countryCode: phoneCode,
      phoneNumber: phone,
      newPassword: passwordController.text,
      confirmPassword: confirmPasswordController.text,
    );

    if (result.isSuccess) {
      emit(CreatePasswordSuccessState());
    } else {
      emit(CreatePasswordFailedState());
    }
  }

  void formUpdate() {
    emit(CreatePasswordFormUpdateState());
  }

  void setPasswordObscure() {
    isObscure = !isObscure;
    emit(CreatePasswordToggleState());
  }

  void confirmObscure() {
    confirmIsObscure = !confirmIsObscure;
    emit(CreatePasswordToggleConfirmState());
  }

  @override
  Future<void> close() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
