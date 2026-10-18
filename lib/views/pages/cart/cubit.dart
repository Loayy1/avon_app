import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/logic/dio_helper.dart';
import 'model.dart';
import 'states.dart';

class CartCubit extends Cubit<CartStates> {
  CartCubit() : super(CartInitialState());

  List<CartItemModel> items = [];

  /// إجمالي السعر محسوب من الـ items
  double get subtotal =>
      items.fold(0.0, (sum, item) => sum + (item.price * item.quantity));

  /// جلب الـ cart من الـ API
  Future<void> getCart() async {
    emit(CartLoadingState());
    final resp = await DioHelper.getData("/api/Cart", requiresAuth: true);
    if (resp.isSuccess) {
      final rawList = resp.data is List
          ? resp.data as List
          : (resp.data["data"] ?? resp.data["items"] ?? []) as List;
      items = rawList.map((e) => CartItemModel.fromJson(e)).toList();
      emit(CartSuccessState());
    } else {
      emit(CartFailedState(message: "Failed to load cart"));
    }
  }

  /// حذف item من الـ cart عن طريق productId
  Future<void> removeItem(int productId) async {
    emit(CartRemoveLoadingState());
    final resp = await DioHelper.deleteData(
      "/api/Cart/remove/$productId",
      requiresAuth: true,
    );
    if (resp.isSuccess) {
      await getCart();
    } else {
      emit(CartFailedState(message: "Failed to remove item"));
    }
  }

  /// تعديل الكمية عن طريق productId
  Future<void> updateQuantity(int productId, int quantity) async {
    // تحديث الـ UI فوراً بدون الانتظار
    final index = items.indexWhere((e) => e.productId == productId);
    if (index != -1) {
      items[index].quantity = quantity;
      emit(CartUpdateQuantityState());
    }
    // ثم بعدين بعت للـ API
    await DioHelper.updateData(
      "/api/Cart/update",
      params: {"productId": productId, "quantity": quantity},
      requiresAuth: true,
    );
  }
}
