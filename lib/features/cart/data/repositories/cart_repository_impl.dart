import '../../domain/repositories/cart_repository.dart';
import '../datasources/cart_remote_data_source.dart';
import '../models/cart_item_model.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource remoteDataSource;

  CartRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<CartItemModel>> getCart() async {
    final resp = await remoteDataSource.getCart();
    if (resp.isSuccess && resp.data != null) {
      List rawList = [];
      if (resp.data is List) {
        rawList = resp.data as List;
      } else if (resp.data is Map) {
        rawList = (resp.data["items"] ??
                resp.data["data"] ??
                resp.data["cartItems"] ??
                resp.data["cart_items"] ??
                resp.data["cart"]?["items"] ??
                []) as List;
      }

      return rawList
          .map((e) => CartItemModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    }
    return [];
  }

  @override
  Future<bool> addToCart(int productId, {int quantity = 1}) async {
    final resp = await remoteDataSource.addToCart(productId, quantity);
    return resp.isSuccess;
  }

  @override
  Future<bool> updateQuantity(int productId, int quantity) async {
    final resp = await remoteDataSource.updateQuantity(productId, quantity);
    return resp.isSuccess;
  }

  @override
  Future<bool> removeFromCart(int productId) async {
    final resp = await remoteDataSource.removeFromCart(productId);
    return resp.isSuccess;
  }
}
