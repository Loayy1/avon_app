abstract class CreatePasswordStates {}

class CreatePasswordInitialState extends CreatePasswordStates {}

class CreatePasswordLoadingState extends CreatePasswordStates {}

class CreatePasswordSuccessState extends CreatePasswordStates {}

class CreatePasswordFailedState extends CreatePasswordStates {
  final String message;
  CreatePasswordFailedState({required this.message});
}

class CreatePasswordToggleState extends CreatePasswordStates {}

class CreatePasswordConfirmToggleState extends CreatePasswordStates {}

class CreatePasswordFormUpdateState extends CreatePasswordStates {}
