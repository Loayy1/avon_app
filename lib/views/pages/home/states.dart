import 'package:cosmetics_app/views/pages/home/model.dart';

class HomeStates {}

class HomeInitialState extends HomeStates {}

class HomeLoadingState extends HomeStates {}

class HomeSuccessState extends HomeStates {
  final List<ProductModel> list;

  HomeSuccessState({required this.list});
}

class HomeFailedState extends HomeStates {}
