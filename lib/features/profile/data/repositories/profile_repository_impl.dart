import '../../../../core/logic/dio_helper.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_remote_data_source.dart';
import '../models/user_profile_model.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<UserProfileModel?> getProfile() async {
    final resp = await remoteDataSource.getProfile();
    if (resp.isSuccess && resp.data != null) {
      if (resp.data is Map) {
        return UserProfileModel.fromJson(Map<String, dynamic>.from(resp.data));
      }
    }
    return null;
  }

  @override
  Future<bool> logout() async {
    try {
      await remoteDataSource.logout();
    } catch (_) {}
    await DioHelper.saveToken(null);
    return true;
  }
}
