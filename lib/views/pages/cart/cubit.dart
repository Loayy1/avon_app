import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/logic/dio_helper.dart';
import 'model.dart';
import 'states.dart';

class CartCubit extends Cubit<CartStates> {
  CartCubit() : super(CartInitialState());

  List<CartItemModel> items = [];

  /// حساب إجمالي السعر ديناميكياً من العناصر الموجودة في السلة
  double get subtotal =>
      items.fold(0.0, (sum, item) => sum + (item.price * item.quantity));

  /// جلب عناصر السلة من الـ API
  Future<void> getCart() async {
    emit(CartLoadingState());
    final resp = await DioHelper.getData("/api/Cart", requiresAuth: true);
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

      items = rawList
          .map((e) => CartItemModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();

      emit(CartSuccessState());
    } else {
      final msg = resp.statusCode == 401
          ? "Please login first to view your cart"
          : "Failed to load cart items";
      emit(CartFailedState(message: msg));
    }
  }

  /// إضافة منتج إلى السلة من أي مكان في التطبيق
  Future<bool> addToCart(int productId, {int quantity = 1}) async {
    emit(CartItemActionLoadingState(productId: productId));
    final resp = await DioHelper.sendData(
      "/api/Cart/add",
      params: {"productId": productId, "quantity": quantity},
      requiresAuth: true,
    );

    if (resp.isSuccess) {
      await getCart();
      return true;
    } else {
      emit(CartFailedState(
        message: resp.statusCode == 401
            ? "Please login first to add items"
            : "Failed to add item to cart",
      ));
      return false;
    }
  }

  /// حذف عنصر من السلة عبر الـ productId
  Future<bool> removeItem(int productId) async {
    emit(CartItemActionLoadingState(productId: productId));
    final resp = await DioHelper.deleteData(
      "/api/Cart/remove/$productId",
      requiresAuth: true,
    );

    if (resp.isSuccess) {
      // إزالة العنصر محلياً وإعادة الحساب فوراً
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

      final resp = await DioHelper.updateData(
        "/api/Cart/update",
        params: {"productId": productId, "quantity": quantity},
        requiresAuth: true,
      );

      if (!resp.isSuccess) {
        // في حال فشل الـ API نرجع للكمية القديمة
        items[index].quantity = oldQuantity;
        emit(CartUpdateQuantityState());
        emit(CartFailedState(message: "Failed to update item quantity"));
      }
    }
  }
}
