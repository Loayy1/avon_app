import '../../domain/repositories/home_repository.dart';
import '../datasources/home_remote_data_source.dart';
import '../models/product_model.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<ProductModel>> getProducts() async {
    final resp = await remoteDataSource.getProducts();
    if (resp.isSuccess && resp.data != null) {
      List rawList = [];
      if (resp.data is List) {
        rawList = resp.data as List;
      } else if (resp.data is Map) {
        rawList = (resp.data['data'] ?? resp.data['products'] ?? []) as List;
      }
      return rawList.map((e) => ProductModel.fromJson(Map<String, dynamic>.from(e))).toList();
    }
    return [];
  }
}
