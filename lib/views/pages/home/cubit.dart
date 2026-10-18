import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/logic/dio_helper.dart';
import 'model.dart';
import 'states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  List<ProductModel> products = [];

  void getData() async {
    emit(HomeLoadingState());
    final resp = await DioHelper.getData("/api/Products");
    if (resp.isSuccess) {
      final details = ProductData.fromJson({"data": resp.data});
      products = details.list;
      emit(HomeSuccessState(list: details.list));
    } else {
      emit(HomeFailedState());
    }
  }

  /// إضافة منتج للـ cart بدون عمل rebuild للصفحة بالكامل
  Future<bool> addToCart(ProductModel product) async {
    final resp = await DioHelper.sendData(
      "/api/Cart/add",
      params: {"productId": product.id, "quantity": 1},
      requiresAuth: true,
    );
    return resp.isSuccess;
  }
}
