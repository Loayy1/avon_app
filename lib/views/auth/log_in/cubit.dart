import 'package:cosmetics_app/views/auth/log_in/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/logic/dio_helper.dart';
import '../../../core/logic/helper_methods.dart';
import '../../view.dart';

class LogInCubit extends Cubit<LogInStates>{
  LogInCubit():super(LogInInitialState());

  bool isObscure = true;
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  String? phoneCode;
  String? errorMsg;

  void togglePassword(){
   isObscure = !isObscure;
   emit(LogInTogglePasswordState());
  }

  void formUpdate(){
    emit(LogInFormUpdateState());
  }

  void codeUpdate(String code){
      phoneCode = code;
      emit(LogInCodeUpdateState());
  }


  void logIn() async {
    emit(LogInLoadingState());
    final resp = await DioHelper.sendData(
      "/api/Auth/login",
      data: {
        "countryCode": phoneCode,
        "phoneNumber": phoneController.text,
        "password": passwordController.text,
      },
    );
    if (resp.isSuccess) {
      final token = resp.data["token"] ?? resp.data["data"]?["token"];
      await DioHelper.saveToken(token);
      emit(LogInSuccessState());
      goTo(page: ViewPage());
    } else {
      emit(LogInFailedState());
      errorMsg = "phone or password is wrong";
    }
  }

}