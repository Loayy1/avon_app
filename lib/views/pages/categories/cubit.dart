import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/categories/data/datasources/categories_remote_data_source.dart';
import '../../../features/categories/data/models/category_model.dart';
import '../../../features/categories/data/repositories/categories_repository_impl.dart';
import '../../../features/categories/domain/repositories/categories_repository.dart';
import 'states.dart';

class CategoriesCubit extends Cubit<CategoriesStates> {
  final CategoriesRepository repository;

  CategoriesCubit({CategoriesRepository? categoriesRepository})
      : repository = categoriesRepository ??
            CategoriesRepositoryImpl(remoteDataSource: CategoriesRemoteDataSourceImpl()),
        super(CategoriesInitialState());

  List<CategoryModel> categories = [];

  void getData() async {
    emit(CategoriesLoadingState());
    try {
      final list = await repository.getCategories();
      categories = list;
      emit(CategoriesSuccessState(list: list));
    } catch (_) {
      emit(CategoriesFailedState());
    }
  }
}