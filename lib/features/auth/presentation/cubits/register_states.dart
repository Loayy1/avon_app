abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {}

class RegisterFailedState extends RegisterStates {
  final String message;
  RegisterFailedState({required this.message});
}

class RegisterTogglePasswordState extends RegisterStates {}

class RegisterToggleConfirmPasswordState extends RegisterStates {}

class RegisterCodeUpdateState extends RegisterStates {}

class RegisterFormUpdateState extends RegisterStates {}
