abstract class LogInStates {}

class LogInInitialState extends LogInStates {}

class LogInLoadingState extends LogInStates {}

class LogInSuccessState extends LogInStates {}

class LogInFailedState extends LogInStates {
  final String message;
  LogInFailedState({this.message = "Phone or password is wrong"});
}

class LogInTogglePasswordState extends LogInStates {}

class LogInCodeUpdateState extends LogInStates {}

class LogInFormUpdateState extends LogInStates {}
