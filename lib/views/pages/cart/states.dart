abstract class CartStates {}

class CartInitialState extends CartStates {}

class CartLoadingState extends CartStates {}

class CartSuccessState extends CartStates {}

class CartFailedState extends CartStates {
  final String message;
  CartFailedState({this.message = "Something went wrong"});
}

class CartAddLoadingState extends CartStates {
  final int productId;
  CartAddLoadingState({required this.productId});
}

class CartAddSuccessState extends CartStates {}

class CartRemoveLoadingState extends CartStates {}

class CartUpdateQuantityState extends CartStates {}
