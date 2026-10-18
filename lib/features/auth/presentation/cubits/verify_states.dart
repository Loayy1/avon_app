abstract class VerifyStates {}

class VerifyInitialState extends VerifyStates {}

class VerifyLoadingState extends VerifyStates {}

class VerifySuccessState extends VerifyStates {}

class VerifyFailedState extends VerifyStates {
  final String message;
  VerifyFailedState({required this.message});
}

class VerifyResendLoadingState extends VerifyStates {}

class VerifyResendSuccessState extends VerifyStates {}

class VerifyCodeChangedState extends VerifyStates {}
