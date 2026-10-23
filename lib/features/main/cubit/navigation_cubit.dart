import 'package:flutter_bloc/flutter_bloc.dart';
import 'navigation_states.dart';

class NavigationCubit extends Cubit<NavigationStates> {
  NavigationCubit() : super(NavigationInitialState());

  int currentIndex = 0;

  void changePage(int index) {
    currentIndex = index;
    emit(NavigationSuccessState(index: index));
  }
}
