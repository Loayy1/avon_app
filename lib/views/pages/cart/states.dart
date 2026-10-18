abstract class CartStates {}

class CartInitialState extends CartStates {}

class CartLoadingState extends CartStates {}

class CartSuccessState extends CartStates {}

class CartFailedState extends CartStates {
  final String message;
  CartFailedState({this.message = "Something went wrong"});
}

class CartItemActionLoadingState extends CartStates {
  final int productId;
  CartItemActionLoadingState({required this.productId});
}

class CartUpdateQuantityState extends CartStates {}
