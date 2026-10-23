import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/logic/dio_helper.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../data/datasources/home_remote_data_source.dart';
import '../../data/models/product_model.dart';
import '../../data/repositories/home_repository_impl.dart';
import '../../domain/repositories/home_repository.dart';
import 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  final HomeRepository repository;

  HomeCubit({HomeRepository? homeRepository})
      : repository = homeRepository ??
            HomeRepositoryImpl(remoteDataSource: HomeRemoteDataSourceImpl()),
        super(HomeInitialState());

  List<ProductModel> products = [];

  void getData() async {
    emit(HomeLoadingState());
    try {
      final list = await repository.getProducts();
      products = list;
      emit(HomeSuccessState(list: list));
    } catch (_) {
      emit(HomeFailedState());
    }
  }

  /// إضافة منتج للـ cart بدون عمل rebuild للصفحة بالكامل
  Future<bool> addToCart(ProductModel product) async {
    final resp = await DioHelper.sendData(
      ApiEndpoints.cartAdd,
      params: {"productId": product.id, "quantity": 1},
      requiresAuth: true,
    );
    return resp.isSuccess;
  }
}
