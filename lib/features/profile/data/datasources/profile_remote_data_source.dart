import '../../../../core/logic/dio_helper.dart';
import '../../../../core/network/api_endpoints.dart';

abstract class ProfileRemoteDataSource {
  Future<CustomResp> getProfile();
  Future<CustomResp> logout();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  @override
  Future<CustomResp> getProfile() {
    return DioHelper.getData(ApiEndpoints.profile, requiresAuth: true);
  }

  @override
  Future<CustomResp> logout() {
    return DioHelper.sendData(ApiEndpoints.logout, requiresAuth: true);
  }
}
