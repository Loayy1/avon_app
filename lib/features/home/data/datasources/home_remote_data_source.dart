import '../../../../core/logic/dio_helper.dart';
import '../../../../core/network/api_endpoints.dart';

abstract class HomeRemoteDataSource {
  Future<CustomResp> getProducts();
  Future<CustomResp> getSliders();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  @override
  Future<CustomResp> getProducts() {
    return DioHelper.getData(ApiEndpoints.products);
  }

  @override
  Future<CustomResp> getSliders() {
    return DioHelper.getData(ApiEndpoints.sliders);
  }
}
