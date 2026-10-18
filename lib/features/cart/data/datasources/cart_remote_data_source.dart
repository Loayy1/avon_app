import '../../../../core/logic/dio_helper.dart';
import '../../../../core/network/api_endpoints.dart';

abstract class CartRemoteDataSource {
  Future<CustomResp> getCart();
  Future<CustomResp> addToCart(int productId, int quantity);
  Future<CustomResp> updateQuantity(int productId, int quantity);
  Future<CustomResp> removeFromCart(int productId);
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  @override
  Future<CustomResp> getCart() {
    return DioHelper.getData(ApiEndpoints.cart, requiresAuth: true);
  }

  @override
  Future<CustomResp> addToCart(int productId, int quantity) {
    return DioHelper.sendData(
      ApiEndpoints.cartAdd,
      params: {"productId": productId, "quantity": quantity},
      requiresAuth: true,
    );
  }

  @override
  Future<CustomResp> updateQuantity(int productId, int quantity) {
    return DioHelper.updateData(
      ApiEndpoints.cartUpdate,
      params: {"productId": productId, "quantity": quantity},
      requiresAuth: true,
    );
  }

  @override
  Future<CustomResp> removeFromCart(int productId) {
    return DioHelper.deleteData(
      "${ApiEndpoints.cartRemove}/$productId",
      requiresAuth: true,
    );
  }
}
