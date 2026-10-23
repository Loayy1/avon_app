abstract class NavigationStates {}

class NavigationInitialState extends NavigationStates {}

class NavigationSuccessState extends NavigationStates {
  final int? index;
  NavigationSuccessState({this.index});
}

class NavigationFailedState extends NavigationStates {}
