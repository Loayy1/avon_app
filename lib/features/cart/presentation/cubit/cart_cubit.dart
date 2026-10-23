import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/datasources/cart_remote_data_source.dart';
import '../../data/models/cart_item_model.dart';
import '../../data/repositories/cart_repository_impl.dart';
import '../../domain/repositories/cart_repository.dart';
import 'cart_states.dart';

class CartCubit extends Cubit<CartStates> {
  final CartRepository repository;

  CartCubit({CartRepository? cartRepository})
      : repository = cartRepository ??
            CartRepositoryImpl(remoteDataSource: CartRemoteDataSourceImpl()),
        super(CartInitialState());

  List<CartItemModel> items = [];

  /// حساب إجمالي السعر ديناميكياً من العناصر الموجودة في السلة
  double get subtotal => items.fold(0.0, (sum, item) => sum + (item.price * item.quantity));

  /// جلب عناصر السلة من الـ API عبر الـ Repository
  Future<void> getCart() async {
    emit(CartLoadingState());
    try {
      final list = await repository.getCart();
      items = list;
      emit(CartSuccessState());
    } catch (_) {
      emit(CartFailedState(message: "Failed to load cart items"));
    }
  }

  /// إضافة منتج إلى السلة
  Future<bool> addToCart(int productId, {int quantity = 1}) async {
    emit(CartItemActionLoadingState(productId: productId));
    final success = await repository.addToCart(productId, quantity: quantity);

    if (success) {
      await getCart();
      emit(CartAddedSuccessState());
      return true;
    } else {
      emit(CartFailedState(message: "Failed to add item to cart"));
      return false;
    }
  }

  /// حذف عنصر من السلة عبر الـ productId
  Future<bool> removeItem(int productId) async {
    emit(CartItemActionLoadingState(productId: productId));
    final success = await repository.removeFromCart(productId);

    if (success) {
      items.removeWhere((item) => item.productId == productId);
      emit(CartSuccessState());
      return true;
    } else {
      emit(CartFailedState(message: "Failed to remove item from cart"));
      await getCart();
      return false;
    }
  }

  /// تعديل كمية المنتج مع تحديث فوري (Optimistic update)
  Future<void> updateQuantity(int productId, int quantity) async {
    if (quantity <= 0) {
      await removeItem(productId);
      return;
    }

    final index = items.indexWhere((item) => item.productId == productId);
    if (index != -1) {
      final oldQuantity = items[index].quantity;
      items[index].quantity = quantity;
      emit(CartUpdateQuantityState());

      final success = await repository.updateQuantity(productId, quantity);

      if (!success) {
        // في حال فشل الـ API نرجع للكمية القديمة
        items[index].quantity = oldQuantity;
        emit(CartUpdateQuantityState());
        emit(CartFailedState(message: "Failed to update item quantity"));
      }
    }
  }
}
