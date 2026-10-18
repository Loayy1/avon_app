import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/logic/helper_methods.dart';
import '../../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../../features/auth/domain/repositories/auth_repository.dart';
import '../../view.dart';
import 'states.dart';

class LogInCubit extends Cubit<LogInStates> {
  final AuthRepository repository;

  LogInCubit({AuthRepository? authRepository})
      : repository = authRepository ??
            AuthRepositoryImpl(remoteDataSource: AuthRemoteDataSourceImpl()),
        super(LogInInitialState());

  bool isObscure = true;
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  String? phoneCode = "+20";
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

  Future<void> logIn() async {
    emit(LogInLoadingState());
    final result = await repository.login(
      countryCode: phoneCode ?? "+20",
      phoneNumber: phoneController.text.trim(),
      password: passwordController.text,
    );

    if (result.isSuccess) {
      errorMsg = null;
      emit(LogInSuccessState());
      goTo(page: const ViewPage());
    } else {
      errorMsg = result.message ?? "Phone or password is wrong";
      emit(LogInFailedState());
    }
  }

  @override
  Future<void> close() {
    passwordController.dispose();
    phoneController.dispose();
    return super.close();
  }
}