import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/datasources/auth_remote_data_source.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import 'register_states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  final AuthRepository repository;

  RegisterCubit({AuthRepository? authRepository})
      : repository = authRepository ??
            AuthRepositoryImpl(remoteDataSource: AuthRemoteDataSourceImpl()),
        super(RegisterInitialState());

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isOccurred = true;
  bool isOccurredInConfirm = true;
  String? phoneCode = "+20";

  void togglePassword() {
    isOccurred = !isOccurred;
    emit(RegisterTogglePasswordState());
  }

  void toggleConfirmPassword() {
    isOccurredInConfirm = !isOccurredInConfirm;
    emit(RegisterToggleConfirmPasswordState());
  }

  void updateCode(String code) {
    phoneCode = code;
    emit(RegisterCodeUpdateState());
  }

  void updateForm() {
    emit(RegisterFormUpdateState());
  }

  Future<bool> register() async {
    if (passwordController.text != confirmPasswordController.text) {
      emit(RegisterFailedState(message: "Passwords do not match"));
      return false;
    }

    emit(RegisterLoadingState());
    final result = await repository.register(
      username: nameController.text.trim(),
      countryCode: phoneCode ?? "+20",
      phoneNumber: phoneController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text,
    );

    if (result.isSuccess) {
      emit(RegisterSuccessState());
      return true;
    } else {
      emit(RegisterFailedState(
        message: result.message ?? "Registration failed. Please try again.",
      ));
      return false;
    }
  }

  @override
  Future<void> close() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
