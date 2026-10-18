abstract class ForgotPasswordStates {}

class ForgotPasswordInitialState extends ForgotPasswordStates {}

class ForgotPasswordLoadingState extends ForgotPasswordStates {}

class ForgotPasswordSuccessState extends ForgotPasswordStates {}

class ForgotPasswordFailedState extends ForgotPasswordStates {
  final String message;
  ForgotPasswordFailedState({required this.message});
}

class ForgotPasswordCodeUpdateState extends ForgotPasswordStates {}

class ForgotPasswordFormUpdateState extends ForgotPasswordStates {}
