import '../../domain/repositories/categories_repository.dart';
import '../datasources/categories_remote_data_source.dart';
import '../models/category_model.dart';

class CategoriesRepositoryImpl implements CategoriesRepository {
  final CategoriesRemoteDataSource remoteDataSource;

  CategoriesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<CategoryModel>> getCategories() async {
    final resp = await remoteDataSource.getCategories();
    if (resp.isSuccess && resp.data != null) {
      List rawList = [];
      if (resp.data is List) {
        rawList = resp.data as List;
      } else if (resp.data is Map) {
        rawList = (resp.data['data'] ?? resp.data['categories'] ?? []) as List;
      }
      return rawList.map((e) => CategoryModel.fromJson(Map<String, dynamic>.from(e))).toList();
    }
    return [];
  }
}
