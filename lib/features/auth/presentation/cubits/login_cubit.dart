import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/datasources/auth_remote_data_source.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import 'login_states.dart';

class LogInCubit extends Cubit<LogInStates> {
  final AuthRepository repository;

  LogInCubit({AuthRepository? authRepository})
      : repository = authRepository ??
            AuthRepositoryImpl(remoteDataSource: AuthRemoteDataSourceImpl()),
        super(LogInInitialState());

  bool isObscure = true;
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  String? phoneCode;
  String? errorMsg;

  void togglePassword() {
    isObscure = !isObscure;
    emit(LogInTogglePasswordState());
  }

  void formUpdate() {
    emit(LogInFormUpdateState());
  }

  void codeUpdate(String code) {
    phoneCode = code;
    emit(LogInCodeUpdateState());
  }

  Future<bool> logIn() async {
    emit(LogInLoadingState());
    final result = await repository.login(
      countryCode: phoneCode ?? "+20",
      phoneNumber: phoneController.text.trim(),
      password: passwordController.text,
    );

    if (result.isSuccess) {
      errorMsg = null;
      emit(LogInSuccessState());
      return true;
    } else {
      errorMsg = result.message ?? "Phone or password is wrong";
      emit(LogInFailedState(message: errorMsg!));
      return false;
    }
  }

  @override
  Future<void> close() {
    passwordController.dispose();
    phoneController.dispose();
    return super.close();
  }
}
