import '../../data/models/cart_item_model.dart';

abstract class CartRepository {
  Future<List<CartItemModel>> getCart();
  Future<bool> addToCart(int productId, {int quantity = 1});
  Future<bool> updateQuantity(int productId, int quantity);
  Future<bool> removeFromCart(int productId);
}
