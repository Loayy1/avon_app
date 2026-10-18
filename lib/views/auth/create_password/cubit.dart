import 'package:cosmetics_app/views/auth/create_password/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/logic/dio_helper.dart';

class CreatePasswordCubit extends Cubit<CreatePasswordStates> {
  CreatePasswordCubit() : super(CreatePasswordInitialState());

  bool isObscure = true;
  bool confirmIsObscure = true;
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void resetPassword({required String phone, required String phoneCode}) async {
    final resp = await DioHelper.sendData(
      "/api/Auth/reset-password",
      data: {
        "countryCode": phoneCode,
        "phoneNumber": phone,
        "newPassword": passwordController.text,
        "confirmPassword": confirmPasswordController.text,
      },
    );
    if (resp.isSuccess) {
      emit(CreatePasswordSuccessState());
    }else{
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
}
