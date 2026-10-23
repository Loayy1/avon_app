import '../../data/models/category_model.dart';

abstract class CategoriesStates {}

class CategoriesInitialState extends CategoriesStates {}

class CategoriesLoadingState extends CategoriesStates {}

class CategoriesSuccessState extends CategoriesStates {
  final List<CategoryModel> list;

  CategoriesSuccessState({required this.list});
}

class CategoriesFailedState extends CategoriesStates {}
