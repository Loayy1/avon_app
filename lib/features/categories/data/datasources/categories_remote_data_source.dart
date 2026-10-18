import '../../../../core/logic/dio_helper.dart';
import '../../../../core/network/api_endpoints.dart';

abstract class CategoriesRemoteDataSource {
  Future<CustomResp> getCategories();
}

class CategoriesRemoteDataSourceImpl implements CategoriesRemoteDataSource {
  @override
  Future<CustomResp> getCategories() {
    return DioHelper.getData(ApiEndpoints.categories);
  }
}
